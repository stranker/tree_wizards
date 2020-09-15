extends Spatial

export var damage : int = 1
export var spell_name : String = ""
export var mana_cost : int = 1
export var spell_range : float = 1
export var spell_area : float = 1
export (SpellManager.SpellType) var spell_type = SpellManager.SpellType.Last
var activated : bool = false

var spell_data : Dictionary = {}

signal on_hit(target)

func initialize():
	spell_data["damage"] = damage
	spell_data["spell_name"] = spell_name
	spell_data["spell_range"] = spell_range
	spell_data["spell_area"] = spell_area
	spell_data["mana_cost"] = mana_cost
	pass

func on_time_out():
	call_deferred("queue_free")
	pass

func is_enemy(body):
	return body.is_in_group("Enemy")

func create_live_timer(time):
	var timer = Timer.new()
	timer.wait_time = time
	add_child(timer)
	timer.connect("timeout",self, "on_time_out")
	timer.start()
	pass

func get_spell_info():
	return spell_data

func cast(spell_direction : Vector3, pos : Vector3):
	global_transform.origin = pos
	pass
