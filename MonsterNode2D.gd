extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 100;

signal escaped_monster;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#AI code
	var side_move = 0;
	if (self.position.x < 275):
		side_move = speed/2;
	if (self.position.x > 480):
		side_move = speed * -1/2;
	move_and_collide(Vector2(side_move*delta,speed*delta));
	# print(self.get_instance_id(), self.position)
	
	if ((self.position.y > (576-(125*self.get_scale().y))) && (self.position.x > 200 && self.position.x < 480)):
		emit_signal("escaped_monster");
		self.queue_free();
	
	if (self.position.x > 775||self.position.x < 0):
		self.queue_free()
