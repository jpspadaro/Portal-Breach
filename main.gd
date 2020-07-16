extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var monster1_scene = preload("res://MonsterNode2D.tscn")
var monster2_scene = preload("res://zoclo.tscn")
var monster3_scene = preload("res://djMon.tscn")
var death_scene = preload("res://outro_splash.tscn")
var win_scene = preload("res://win_splash.tscn")
var boulder_scene = preload("res://Boulder.tscn")

var event_timer = 0;
var wave = 1;
var monster_rate = 5; #accellerates
var damage = 0;

var portal_damage = 0;
var portal_life = 1000000;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();

func check_quit():
	if (Input.is_action_pressed("quit")):
		get_tree().quit()

func _on_MonsterNode2D_escaped_monster():
	damage= damage + 1
	get_node("ui/rightPanel/DamageRect").set_size(Vector2(15,damage+4))
	
func new_monster(wave):
	var which_mon = randi() % 5;
	var my_monster
	if (which_mon < 3):
		my_monster = monster1_scene.instance()
	elif (which_mon > 3):
		my_monster = monster2_scene.instance()
	else:
		my_monster = monster3_scene.instance()
		
	if (wave > 5):
		var mon_scale = rand_range(.5, 2)
		my_monster.set_scale(Vector2(mon_scale,mon_scale))

	return my_monster

func drop_boulder():
	var boulder = boulder_scene.instance()
	var x = rand_range(64,700)
	var y = rand_range(64,500)
	boulder.translate(Vector2(x,y))
	add_child(boulder)
	
func damage_portal():
	portal_damage += 1
	print("Portal Damaged! :", portal_damage)
	if portal_damage > portal_life:
		get_tree().change_scene_to(win_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_quit();
	
	event_timer = event_timer + delta;
	
	#get_node("ui/bottomPanel/info")
	
	if (wave==2):
		get_node("Speach1").play(0);
	
	if (wave==5):
		get_node("Speach9").play(0);
		
	if (wave==10):
		get_node("Speach4").play(0);
		
	if (wave==50):
		get_node("Speach5").play(0);
		
	if (wave==200):
		get_node("Speach6").play(0);
		
	if (wave==500):
		get_node("Speach7").play(0);
	
	if (wave==1000):
		get_node("Speach8").play(0);
		
	if (wave==2000):
		get_node("Speach10").play(0);
	
	if (event_timer > (wave*monster_rate)):
		var monster = new_monster(wave)
		add_child(monster);
		monster.translate(Vector2(200+rand_range(0,350),100));
		monster.connect("escaped_monster",self,"_on_MonsterNode2D_escaped_monster")
		wave += 1;
		monster_rate = monster_rate - .2
		if (monster_rate < .1): monster_rate = .1
		#print("Monster Rate:", monster_rate)
	
	if (damage > 300):
		get_node("FloorMap").set_modulate(Color(.75,0,0,.25))
		get_node("ui/bottomPanel/info").text = "DANGER -- DAMAGE CRITICAL"
		if ((damage % 25) == 0):
			drop_boulder()
		
	if (damage > 400):
		get_tree().change_scene_to(death_scene)
