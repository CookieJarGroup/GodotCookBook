extends Node


func _ready():
	pass

func _on_Button_pressed():
    $HTTPRequest.request("http://www.mocky.io/v2/5185415ba171ea3a00704eed")

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
    var json = JSON.parse(body.get_string_from_utf8())
    print(json.result)
    $gotInfo.set_text(str(json.result))
