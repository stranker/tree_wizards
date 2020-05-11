extends "res://Objects/Spells/Spell.gd"

var target = null
var chase : bool = false

signal on_target(target)

func initialize():
	.initialize()
	spell_type = SpellManager.SpellType.Target
	pass

func set_target(enemy):
	target = enemy
	if !target:
		queue_free()
	emit_signal("on_target", target)
	pass
