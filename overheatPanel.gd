extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_playerBody2D_gunOverheat(overheatval):
	get_node("ColorRect").set_size(Vector2(12+(overheatval*10), 12))
