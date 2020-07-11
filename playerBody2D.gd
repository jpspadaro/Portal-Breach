extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called to resolve player input
func get_input(delta):
	if Input.is_action_pressed("up"):
		move_and_collide(Vector2(0,-50)*delta);
		direction=Vector2(0,-1);
	if Input.is_action_pressed("down"):
		move_and_collide(Vector2(0,50)*delta);
		direction=Vector2(0,1);
	if Input.is_action_pressed("left"):
		move_and_collide(Vector2(-50,0)*delta);
		direction=Vector2(-1,0);
	if Input.is_action_pressed("right"):
		move_and_collide(Vector2(50,0)*delta);
		direction=Vector2(1,0);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input(delta);
	
