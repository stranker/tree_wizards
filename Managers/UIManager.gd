extends Node

signal on_interactable_zone_entered()
signal on_interactable_zone_exited()

var current_interactable_zone = null

func on_interactable_zone_entered(zone):
	current_interactable_zone = zone
	emit_signal("on_interactable_zone_entered")
	pass

func on_interactable_zone_exited():
	current_interactable_zone = null
	emit_signal("on_interactable_zone_exited")
	pass

func _show_interactable_zone():
	if current_interactable_zone:
		current_interactable_zone.show_ui()
	pass

func on_interact_pressed():
	_show_interactable_zone()
	pass
