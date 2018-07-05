extends CanvasLayer
var userNameFld
var userPasswordFld

func _ready():
	$loginVideo.play()

func _process(delta):#se ejecuta cada frame.
	pass

func _on_Salir_pressed():
	get_tree().quit()#salir del juego

func _on_Iniciar_pressed():
	get_tree().change_scene("res://Scene/LessonsScene/Lessons.tscn")#cambia de escena

func _on_LEditUser_text_changed( new_text ):#Guarda el inputtext del username
	userNameFld = new_text

func passFld( new_text ):
	print(new_text)
