extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var monster_scene = preload("res://MonsterNode2D.tscn")

var event_timer = 0;
var wave = 1;
var monster_rate = 10; #accellerates
var damage = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func check_quit():
	if (Input.is_action_pressed("quit")):
		get_tree().quit()

func _on_MonsterNode2D_escaped_monster():
	damage= damage + 1
	get_node("ui/rightPanel/DamageRect").set_size(Vector2(15,damage+4))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_quit();
	
	event_timer = event_timer + delta;
	
	#get_node("ui/bottomPanel/info")
	
	if (event_timer > (wave*monster_rate)):
		var monster = monster_scene.instance()
		add_child(monster);
		monster.translate(Vector2(200+rand_range(0,400),100));
		monster.connect("escaped_monster",self,"_on_MonsterNode2D_escaped_monster")
		wave += 1;
		monster_rate = monster_rate - .2
		if (monster_rate < .6): monster_rate = .6
		print("Monster Rate:", monster_rate)
	
