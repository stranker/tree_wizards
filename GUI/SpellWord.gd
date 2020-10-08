extends Control

export var spell_name : String = ""
export var spell_texture : Texture = null
export var spell_scene : PackedScene = null
var spell : Spatial = null
export var learned : bool = false
export var initial_button : bool = false
export (Array, NodePath) var next_spells

enum SpellState {CANCLICK, CLICKED, RESETING, OUTMANA, LAST}

export (SpellState) var current_state

signal spell_pressed(spell)

var spell_parent : Control = null

func _ready():
	if !initial_button:
		spell = spell_scene.instance()
		spell.initialize()
		visible = false
	current_state = SpellState.CANCLICK
	if spell_texture:
		$Icon.texture = spell_texture
	
	pass

func on_click():
	if current_state != SpellState.CANCLICK:
		return
	activate_next_spells()
	deactivate_parent_spells()
	$Anim.play("Clicked")
	current_state = SpellState.CLICKED
	if spell:
		emit_signal("spell_pressed", spell)
	pass

func activate_next_spells():
	for spell in next_spells:
		if get_node(spell).learned:
			get_node(spell).set_active(true, self)
	pass

func deactivate_parent_spells():
	if !spell_parent:
		return
	for spell_button in spell_parent.next_spells:
		var spell = spell_parent.get_node(spell_button)
		if spell:
			if spell != self:
				spell.set_active(false, null)
	pass

func set_active(value, parent):
	visible = value
	spell_parent = parent
	mana_check()
	pass

func mana_check():
	if spell:
		if GameManager.wizard.mana < spell.mana_cost:
			current_state = SpellState.OUTMANA
			$Anim.play("OutMana")
	pass

func reset():
	if current_state == SpellState.RESETING:
		return
	if !initial_button:
		current_state = SpellState.RESETING
		if $Anim.is_playing():
			$Anim.stop()
		$Anim.play("Reset",-1,1.5)
	else:
		current_state = SpellState.CANCLICK
		$Anim.play("CanClick")
	pass

func learn():
	learned = true
	pass

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Reset":
		current_state = SpellState.CANCLICK
		visible = false
		$Anim.play("CanClick")
	pass # Replace with function body.

func can_be_clicked():
	return current_state == SpellState.CANCLICK and visible
