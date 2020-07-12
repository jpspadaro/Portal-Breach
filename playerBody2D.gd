extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = Vector2(0,0)
var gun_overheat = 0;

signal gunOverheat;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called to resolve player input
func get_input(delta):
	if Input.is_action_pressed("up"):
		move_and_collide(Vector2(0,-75)*delta);
		direction=Vector2(0,-1);
	if Input.is_action_pressed("down"):
		move_and_collide(Vector2(0,75)*delta);
		direction=Vector2(0,1);
	if Input.is_action_pressed("left"):
		move_and_collide(Vector2(-75,0)*delta);
		direction=Vector2(-1,0);
	if Input.is_action_pressed("right"):
		move_and_collide(Vector2(75,0)*delta);
		direction=Vector2(1,0);
	if Input.is_action_pressed("attack"):
		print ("Gun Overheat:",gun_overheat)
		gun_overheat += delta;
		if (gun_overheat<10):
			var bullet = preload("res://bullet.tscn").instance()
			bullet.direction = direction
			bullet.position = self.position;
			get_parent().add_child(bullet);
			get_node("AudioStreamGunNormal").play(0);
		else:
			get_node("AudioStreamGunOverheat").play(0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input(delta);
	gun_overheat -= (delta/2)
	if (gun_overheat<0): gun_overheat = 0
	emit_signal("gunOverheat", gun_overheat)
