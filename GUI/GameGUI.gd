extends CanvasLayer

signal on_interact_pressed()
signal on_joystick_force(force)
signal on_jump_pressed()
signal on_dash_pressed()

onready var jump_button = $Control/Jump
onready var dash_button = $Control/Dash
onready var interact_button = $Control/Interact
onready var joystick = $Control/Joystick

func _ready():
	UiManager.connect("on_interactable_zone_entered", self, "show_interactable_button")
	UiManager.connect("on_interactable_zone_exited", self, "hide_interactable_button")
	connect("on_interact_pressed", UiManager, "on_interact_pressed")
	interact_button.hide()
	if !GameManager.is_android_device:
		_hide_android_ui()
	pass

func show_interactable_button():
	interact_button.show()
	pass

func hide_interactable_button():
	interact_button.hide()
	pass

func _on_Interact_button_down():
	emit_signal("on_interact_pressed")
	pass # Replace with function body.

func _on_Joystick_analog_force(force):
	emit_signal("on_joystick_force", force)
	pass # Replace with function body.

func _on_Dash_button_down():
	emit_signal("on_dash_pressed")
	pass # Replace with function body.

func _hide_android_ui():
	dash_button.hide()
	joystick.hide()
	pass

func _on_PowerTree_on_casting_spell():
	pass # Replace with function body.
