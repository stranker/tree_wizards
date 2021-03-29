extends "res://Objects/Spells/Spell.gd"

var velocity : Vector3
var dir : Vector3

var accumulated_pos : Vector3 = Vector3.ZERO

func _ready():
	if spell_effect_scene:
		spell_effect = spell_effect_scene.instance()
	pass

func _physics_process(delta):
	move_and_slide(velocity)
	accumulated_pos += velocity * delta
	if accumulated_pos.length() > spell_range:
		call_deferred("queue_free")
	pass

func _set_spell_data(pos : Vector3, direction : Vector3):
	translate(pos)
	dir = direction
	velocity = dir * spell_speed
	var visual = get_node("Visual")
	if visual:
		visual.rotation.y = Vector2(dir.z, dir.x).angle()
	pass

func cast(wizard, pos, direction):
	.cast(wizard, pos, direction)
	_set_spell_data(pos, direction)
	pass
