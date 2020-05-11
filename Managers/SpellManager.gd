extends Node

enum SpellType {Directional, Ground, Target, Last}
var can_throw_spell : bool = true

var spells : Array = []
var spell_names : Array = []

var wizard : KinematicBody = null
var wizard_spell_pos : Position3D = null
var wizard_cast_view : Position3D = null

signal spell_casted
signal cast_cooldown(cd)
signal cast_ready
signal spell_info(spell_range, effect_area)

var cooldown_timer : Timer

func _ready():
	cooldown_timer = Timer.new()
	get_tree().root.call_deferred("add_child",cooldown_timer)
	cooldown_timer.connect("timeout", self, "_on_cooldown_timer_timeout")
	pass

func _process(delta):
	if !cooldown_timer.is_stopped():
		emit_signal("cast_cooldown", cooldown_timer.wait_time)
	pass

func check_spell_info(casted_words):
	var spell_name : String = get_spell_name(casted_words)
	var spell_info = null
	for spell in spells:
		if !spell_info and spell.spell_name == spell_name:
			spell_info = spell.get_spell_info()
	if !spell_info:
		return
	emit_signal("spell_info", spell_info.spell_range, spell_info.effect_area)
	pass

func get_spell_name(spell_list):
	var spell_name : String = ""
	for spell in spell_list:
		spell_name += spell
	return spell_name

func add_spells(spells_dic : Dictionary):
	for spell_name in spells_dic.keys():
		var spell = spells_dic[spell_name].instance()
		spell.initialize()
		spells.append(spell)
	pass

func _on_cooldown_timer_timeout():
	can_throw_spell = true
	emit_signal("cast_ready")
	pass # Replace with function body.

func on_cast_spell(spell_words):
	if spell_words.empty():
		return
	if !can_throw_spell:
		return
	var spell_name = get_spell_name(spell_words)
	var spell = get_spell(spell_name)
	if !spell:
		return
	cast_spell(spell)
	pass

func get_spell(spell_name):
	for spell in spells:
		if spell.spell_name == spell_name:
			return spell

func cast_spell(spell_to_cast : Spatial):
	var spell = spell_to_cast.duplicate()
	var spell_pos = wizard_spell_pos.global_transform.origin
	get_tree().root.call_deferred("add_child", spell)
	match spell.spell_type:
		SpellType.Directional:
			cast_directional_spell(spell, spell_pos)
		SpellType.Ground:
			spell_pos = wizard_cast_view.global_transform.origin
			cast_ground_spell(spell, spell_pos)
		SpellType.Target:
			cast_target_spell(spell, spell_pos)
	#can_throw_spell = false
	emit_signal("spell_casted")
	pass

func cast_directional_spell(spell, spell_pos):
	spell.transform.origin = spell_pos
	spell.call_deferred("spell_dir", wizard.spell_direction(), true)
	pass

func cast_ground_spell(spell, spell_pos):
	spell.transform.origin = spell_pos
	pass 

func cast_target_spell(spell, spell_pos):
	spell.set_target(wizard.closest_enemy())
	spell.transform.origin = spell_pos
	pass
