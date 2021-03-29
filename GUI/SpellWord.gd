extends Control

enum SpellState {CANCLICK, CLICKED, RESETING, OUTMANA, LAST}

export var spell_name : String = ""
export var spell_texture : Texture = null
export var spell_scene : PackedScene = null
export var spell_learned : bool = false
export var initial_button : bool = false
var next_spells : Array = []
var current_state = SpellState.LAST
onready var anim = $Anim
onready var icon = $Icon


signal spell_pressed(spell)

var spell_parent : Control = null

func _ready():
	if !initial_button:
		visible = false
	current_state = SpellState.CANCLICK
	if spell_texture:
		icon.texture = spell_texture
	_get_next_spells()
	pass

func _get_next_spells():
	if initial_button:
		var spell_trees = get_children()
		for spell_tree in spell_trees:
			if spell_tree is Control and spell_tree.is_in_group("SpellTree"):
				next_spells.append(spell_tree.get_child(0))
	else:
		for child in get_children():
			if child is Control and child.is_in_group("SpellButton"):
				next_spells.append(child)
	pass

func on_click():
	if current_state != SpellState.CANCLICK:
		return
	activate_next_spells()
	deactivate_parent_spells()
	anim.play("Clicked")
	current_state = SpellState.CLICKED
	if spell_scene:
		emit_signal("spell_pressed", spell_scene)
	pass

func activate_next_spells():
	for spell in next_spells:
		if spell.spell_learned:
			spell.set_active(true, self)
	pass

func deactivate_parent_spells():
	if !spell_parent:
		return
	for spell_button in spell_parent.next_spells:
		if spell_button:
			if spell_button != self:
				spell_button.set_active(false, null)
	pass

func set_active(value, parent):
	visible = value
	spell_parent = parent
	pass

func reset():
	if current_state == SpellState.RESETING:
		return
	if !initial_button:
		current_state = SpellState.RESETING
		if anim.is_playing():
			anim.stop()
		anim.play("Reset",-1,1.5)
	else:
		current_state = SpellState.CANCLICK
		anim.play("CanClick")
	pass

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Reset":
		current_state = SpellState.CANCLICK
		visible = false
		anim.play("CanClick")
	pass # Replace with function body.

func can_be_clicked():
	return current_state == SpellState.CANCLICK and visible
