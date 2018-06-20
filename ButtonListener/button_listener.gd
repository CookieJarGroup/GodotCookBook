extends Node

var state = 0 

func _ready():
	print("Ready!")

func my_function_event():
	print("Button pressed")

func button_down():
	print("Button down")

func button_up():
	print("Button up")

func button_toggled(my_function_event):
	if (state):
		state = 0
	else:
		state = 1
	print(state)

