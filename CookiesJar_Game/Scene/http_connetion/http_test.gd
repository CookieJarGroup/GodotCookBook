extends Node

var url_1 = "http://www.mocky.io/v2/5185415ba171ea3a00704eed"
var url_2 = "https://httpbin.org/get"
var url_3 = "http://2aefe761.ngrok.io/api/get-products"

func _ready():
	pass

func _on_Button_pressed():
    $HTTPRequest.request(url_3)

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
    var json = JSON.parse(body.get_string_from_utf8())
    print(json.result.productos[0].descripcion)
    #$gotInfo.set_text(json.result)
