class_name TextureManager
extends Reference

func NewTextureFromURL(URL: String, parent: Node) -> ImageTexture:
	var http_request = HTTPRequest.new()
	var image = Image.new()
	var texture = ImageTexture.new()

	parent.add_child(http_request)
	
	var error = http_request.request(URL)
#	TODO: Add a ErrorStatus class to pretty print common errors based on the type and status number
	if error != OK:
		print("An error occured in the HTTP Texture Request")

	var response = yield(http_request, "request_completed")
	var body:PoolByteArray = response[3]

	if _is_png(body):
		image.load_png_from_buffer(body)
	elif _is_jpg(body):
		image.load_jpg_from_buffer(body)
	elif _is_webp(body):
		image.load_webp_from_buffer(body)
	else:
		push_error("Not a valid image file")

	texture.create_from_image(image)
	
	return texture

func _is_png(body) -> bool:
	if (body[0] == 137 && body[1] == 80
		&& body[2] == 78 && body[3] == 71
		&& body[4] == 13 && body[5] == 10
		&& body[6] == 26 && body[7] == 10):
			return true
	else:
		return false

func _is_jpg(body) -> bool:
#	Just lazily checking the first three bytes here.
#	Normally there's different JPG types but the first
#	three bytes will always be FF D8 FF (255 216 255)
	if (body[0] == 255 && body[1] == 216
		&& body[2] == 255):
			return true
	else:
		return false

func _is_webp(body) -> bool:
#	The 5th through 8th bytes contain the file size
#	so naturally we exclude those
	if (body[0] == 82 && body[1] == 73
		&& body[2] == 70 && body[3] == 70
		&& body[8] == 87 && body[9] == 69
		&& body[10] == 66 && body[11] == 80):
			return true
	else:
		return false
