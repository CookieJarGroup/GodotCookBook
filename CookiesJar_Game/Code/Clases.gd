extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	$AnimatedSprite.animation = "caminar"
	

func _on_Regresar_pressed():
	get_tree().change_scene("res://Scene/main.tscn")#cambiar de escena 

func _on_Open_Door_pressed():
	get_tree().change_scene("res://Scene/InstructionsScene/Instructions.tscn")#cambiar de escena 

func _on_Back_pressed():
	get_tree().change_scene("res://Scene/main.tscn")#cambiar de escena 


func _on_Match_pressed():
	get_tree().change_scene("res://Scene/matchScene/UNION.tscn")#cambiar de escena
