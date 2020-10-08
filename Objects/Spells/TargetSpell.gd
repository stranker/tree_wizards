extends "res://Objects/Spells/Spell.gd"

var target = null

signal on_target(target)

func initialize():
	.initialize()
	spell_type = SpellManager.SpellType.Target
	spell_data["spell_type"] = spell_type
	pass

func _set_target(enemy):
	target = enemy
	if target:
		target.call_deferred("add_child", self)
		target.connect("dead", self, "_on_enemy_dead")
	pass

func cast(current_enemy, direction, pos):
	.cast(current_enemy, direction, pos)
	_set_target(current_enemy)

func can_cast_spell(enemy : KinematicBody):
	if !enemy:
		return false
	else:
		var wizard = GameManager.wizard
		return enemy.global_transform.origin.distance_to(wizard.global_transform.origin) <= spell_area * 0.5

func _on_enemy_dead():
	call_deferred("queue_free")
