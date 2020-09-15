extends "res://Objects/Spells/Spell.gd"

export var live_time : float = 4
export var rotate_to_dir : bool = false
export var speed : float = 3

var velocity : Vector3
var dir : Vector3

var initial_pos : Vector3 = Vector3.ZERO
var accumulated_pos : Vector3 = Vector3.ZERO

func initialize():
	.initialize()
	spell_type = SpellManager.SpellType.Directional
	spell_data["spell_type"] = spell_type
	pass

func _ready():
	create_live_timer(live_time)
	pass

func _process(delta):
	global_transform.origin += velocity * delta
	accumulated_pos += velocity * delta
	check_position()
	pass

func check_position():
	if accumulated_pos.length() > spell_range:
		queue_free()
	pass

func _set_spell_dir(direction : Vector3):
	dir = direction
	velocity = dir * speed
	var visual = get_node("Visual")
	if visual:
		visual.rotation.y = Vector2(dir.z, dir.x).angle()
	pass

func cast(direction, pos):
	.cast(direction, pos)
	_set_spell_dir(direction)
	initial_pos = global_transform.origin
	pass
