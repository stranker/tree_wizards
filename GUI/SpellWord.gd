extends Button

export var spell_name : String = ""
export (Array, NodePath) var next_words
export var learned : bool = false
export var spell_texture : Texture = null

enum SpellState {CanClick, Clicked, Reseting, Last}

export (SpellState) var current_state = SpellState.CanClick

signal word_pressed(spell_name)

var word_parent = null
var reseting : bool = false

func _ready():
	$Icon.texture = spell_texture
	pass

func on_click():
	if current_state == SpellState.CanClick:
		if spell_name != "":
			emit_signal("word_pressed", spell_name)
		activate_next_words()
		deactivate_parent_words()
		$Anim.play("Clicked")
		current_state = SpellState.Clicked
	pass

func activate_next_words():
	for word in next_words:
		if get_node(word).learned:
			get_node(word).set_active(true, self)
	pass

func deactivate_parent_words():
	if !word_parent:
		return
	for word in word_parent.next_words:
		if get_node(word) != self:
			get_node(word).set_active(false, null)
	pass

func set_active(value, parent):
	visible = value
	word_parent = parent
	var current_spell_name = ""
	if word_parent:
		current_spell_name = word_parent.spell_name + spell_name
	else:
		current_spell_name = spell_name
	var spell_texture_name = "res://Assets/Sprites/Spells/" + current_spell_name.to_lower() + "_icon.png"
	spell_texture = load(spell_texture_name)
	$Icon.texture = spell_texture
	pass

func reset():
	if current_state == SpellState.Reseting:
		return
	current_state = SpellState.Reseting
	if $Anim.is_playing():
		$Anim.stop()
	$Anim.play("Reset",-1,1.5)
	pass

func learn():
	learned = true
	pass

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Reset":
		current_state = SpellState.CanClick
		visible = false
		$Anim.play("CanClick")
	pass # Replace with function body.

func can_be_clicked():
	return current_state == SpellState.CanClick and visible