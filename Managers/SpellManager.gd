extends Node

enum SpellType {Directional, Ground, Target, Last}
enum SpellEffectType {Freeze, Burn, Poison, Stun, Last}

onready var wizard : KinematicBody = GameManager.wizard

var current_spell_scene : PackedScene = null
var current_spell : Spatial = null

var can_throw_spell : bool = true

signal spell_casted(spell)
signal cast_cooldown(cd)
signal cast_ready

onready var cooldown_timer : Timer = Timer.new()

func _ready():
	call_deferred("add_child", cooldown_timer)
	cooldown_timer.connect("timeout", self, "_on_cooldown_timer_timeout")
	pass

func _process(delta):
	if !cooldown_timer.is_stopped():
		emit_signal("cast_cooldown", cooldown_timer.wait_time)
	pass

func on_spell(spell_scene):
	current_spell_scene = spell_scene
	pass

func _on_cooldown_timer_timeout():
	can_throw_spell = true
	emit_signal("cast_ready")
	pass # Replace with function body.

func on_cast_spell():
	if !current_spell_scene:
		return
	_create_spell()
	current_spell_scene = null
	pass

func _create_spell():
	current_spell = current_spell_scene.instance()
	var spell_pos = wizard.get_spell_pos()
	var spell_direction = wizard.get_spell_direction()
	get_tree().root.call_deferred("add_child", current_spell)
	current_spell.cast(wizard, spell_pos, spell_direction)
	emit_signal("spell_casted", current_spell)
	pass

func _on_spell_learned(spell_name):
	print(spell_name)
	pass
