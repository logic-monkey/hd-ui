@tool
extends HBoxContainer
class_name HDUI_HEART_BAR

var _mhp: int = 12
var _chp: int = 12

@export var max_hp: int = 12:
	set(v):
		if not Engine.is_editor_hint() and not is_node_ready(): await  ready
		_mhp = v
		set_max_hp()
	get:
		return _mhp
		
@export var cur_hp: int = 12:
	set(v):
		if not Engine.is_editor_hint() and not is_node_ready(): await  ready
		_chp = v
		set_cur_hp_instant()
	get:
		return _chp
		
var hero_hp : HeartPoints

func set_max_hp():
	var m = max_hp
	if m < 0: m = 0
	if m > 0: m /=4
	while get_child_count() > m:
		var c = get_child(-1)
		c.queue_free()
		remove_child(c)
	while get_child_count() < m:
		add_child(preload("res://addons/hd-ui/ui_heart.tscn").instantiate())
	
func set_cur_hp_instant():
	if max_hp <= 0: return
	var c = cur_hp
	for i in max_hp / 4:
		if c >= 4:
			get_child(i).value = 4
			c -= 4
		else:
			get_child(i).value = c
			c = 0

	pass

func _ready():
	if not hero_hp:
		max_hp = 0
		cur_hp = 0
		
func _process(_delta):
	#print ("Bar is updating")
	if not hero_hp:
		#print ("not hero_hp")
		max_hp = 0
		cur_hp = 0
		return
	var hp = hero_hp as HeartPoints
	if hp.hp != max_hp: 
		#print("updating max!")
		max_hp = hp.hp
	if hp.hp - hp.damage_taken != cur_hp: 
		#print("updating HP!")
		cur_hp = hp.hp - hp.damage_taken
		
