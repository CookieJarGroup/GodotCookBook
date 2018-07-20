extends Panel

onready var conn = get_node("PMSConnector")


func _ready():
	conn.hola()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
