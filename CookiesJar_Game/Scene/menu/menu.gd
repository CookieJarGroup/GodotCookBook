extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_playSound_pressed():
	$welcome.play()


func _on_welcome_finished():
	print ("fff")


func _on_audio_finished():
	print ("fff")

# validar mediante alguna estructura de datos*
func _on_Button_pressed():
	$Popup.popup()


func _on_siguente_pressed():
	get_tree().change_scene("res://Scene/main.tscn")
