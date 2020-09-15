extends Node

enum SpellType {Directional, Ground, Target, Last}
var can_throw_spell : bool = true

var spells : Array = []
var spell_names : Array = []

var wizard : KinematicBody = null
var wizard_cast_helper : Spatial = null

signal spell_casted(spell)
signal cast_cooldown(cd)
signal cast_ready
signal spell_info(spell_data)

var cooldown_timer : Timer

func _ready():
	cooldown_timer = Timer.new()
	get_tree().root.call_deferred("add_child",cooldown_timer)
	cooldown_timer.connect("timeout", self, "_on_cooldown_timer_timeout")
	pass

func init(wiz):
	wizard = wiz
	wizard_cast_helper = wizard.get_cast_helper()

func _process(delta):
	if !cooldown_timer.is_stopped():
		emit_signal("cast_cooldown", cooldown_timer.wait_time)
	pass

func check_spell_info(casted_words):
	var spell_name : String = get_spell_name(casted_words)
	for spell in spells:
		if spell.spell_name == spell_name:
			emit_signal("spell_info", spell.get_spell_info())
			break
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
	var spell_pos = wizard_cast_helper.get_spell_pos()
	var spell_direction = wizard.get_spell_direction()
	get_tree().root.call_deferred("add_child", spell)
	spell.cast(spell_direction, spell_pos)
	emit_signal("spell_casted", spell)
	pass
