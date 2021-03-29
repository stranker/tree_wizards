extends Area

export var is_activated : bool = false

export (NodePath) var target_zone_path
onready var target_zone = get_node(target_zone_path)

signal on_wizard_enter(zone)
signal on_wizard_exit()

var activate_timer : Timer
var activate_time : float = 1

func _create_activate_timer():
	activate_timer = Timer.new()
	add_child(activate_timer)
	activate_timer.wait_time = activate_time
	activate_timer.connect("timeout", self, "on_activated")
	activate_timer.start()
	pass

func on_activated():
	is_activated = true
	activate_timer.call_deferred("queue_free")
	pass

func _ready():
	connect("on_wizard_enter", UiManager, "on_interactable_zone_entered")
	connect("on_wizard_exit", UiManager, "on_interactable_zone_exited")
	_create_activate_timer()
	pass

func _on_InteractableZone_body_entered(body):
	if !is_activated:
		return
	emit_signal("on_wizard_enter", target_zone)
	pass # Replace with function body.


func _on_InteractableZone_body_exited(body):
	if !is_activated:
		return
	emit_signal("on_wizard_exit")
	pass # Replace with function body.
