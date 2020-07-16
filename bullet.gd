extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = Vector2()
var speed = 1000
var life_span = .5
var life = 0

signal portalDamage;

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("portalDamage",self.get_parent(),"damage_portal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collisions = move_and_collide(direction*speed*delta)
	if collisions: 
		var collided = collisions.get_collider()
		print (collided.get_class())
		if collided.get_class() == "KinematicBody2D":collided.queue_free()
		if collided.get_class() == "RigidBody2D": emit_signal("portalDamage")
		else: self.queue_free()
	life = life + delta;
	if life > life_span: self.queue_free()
