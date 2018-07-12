extends CanvasLayer
var userNameFld
var userPasswordFld

#Coleccion de credenciales
var ls = {'andres': 'root', 'system': 'manager', 'user': 'user'}

func _ready():
	$loginVideo.play()
	$error_msj.hide()

func _process(delta):#se ejecuta cada frame.
	pass

func _on_Salir_pressed():
	get_tree().quit()#salir del juego

func _on_Iniciar_pressed():
	validar_credenciales()

func _on_LEditUser_text_changed( new_text ):#Guarda el inputtext del username
	userNameFld = new_text

func passFld( new_text ):
	userPasswordFld = new_text
	
func validar_credenciales():
	for _item in ls:
		if(userNameFld == _item and userPasswordFld == ls[_item] ):
			get_tree().change_scene("res://Scene/LessonsScene/Lessons.tscn")#cambia de escena
		else:
			$error_msj.show();

