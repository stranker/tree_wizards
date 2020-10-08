extends Node

enum SpellType {Directional, Ground, Target, Last}
var can_throw_spell : bool = true

var wizard : KinematicBody = null
var wizard_cast_helper : Spatial = null

var current_spell : Spatial = null

signal spell_casted(spell)
signal cast_cooldown(cd)
signal cast_ready
signal spell_info(spell_data)
signal spell_failed()

onready var cooldown_timer : Timer = Timer.new()

func _ready():
	call_deferred("add_child", cooldown_timer)
	cooldown_timer.connect("timeout", self, "_on_cooldown_timer_timeout")
	pass

func init(wiz):
	wizard = wiz
	wizard_cast_helper = wizard.get_cast_helper()
	pass

func _process(delta):
	if !cooldown_timer.is_stopped():
		emit_signal("cast_cooldown", cooldown_timer.wait_time)
	pass

func on_spell(spell):
	current_spell = spell
	if current_spell:
		emit_signal("spell_info", spell.get_spell_info())
	pass

func _on_cooldown_timer_timeout():
	can_throw_spell = true
	emit_signal("cast_ready")
	pass # Replace with function body.

func on_cast_spell():
	if !current_spell:
		return
	create_spell()
	current_spell = null
	pass

func create_spell():
	var current_enemy = wizard.current_enemy
	if !current_spell.can_cast_spell(current_enemy):
		emit_signal("spell_failed")
		return
	var spell = current_spell.duplicate()
	var spell_pos = wizard_cast_helper.get_spell_pos()
	var spell_direction = wizard.get_spell_direction()
	get_tree().root.call_deferred("add_child", spell)
	spell.cast(current_enemy, spell_direction, spell_pos)
	emit_signal("spell_casted", spell)
	pass
