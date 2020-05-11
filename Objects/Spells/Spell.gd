extends Spatial

export var damage : int = 1
export var spell_name : String = ""
export (SpellManager.SpellType) var spell_type = SpellManager.SpellType.Last
var activated : bool = false

class SpellInfo:
	var spell_range = 0
	var effect_area = 0
	
	func _init(s_range, s_effect_area):
		spell_range = s_range
		effect_area = s_effect_area
		pass

var spell_info_data : SpellInfo = null

signal on_hit(target)

func initialize():
	pass

func on_time_out():
	queue_free()
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
	return spell_info_data
