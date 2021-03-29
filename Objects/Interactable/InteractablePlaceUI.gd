extends CanvasLayer

export (NodePath) var main_panel_path 
onready var main_panel = get_node(main_panel_path)

func _ready():
	main_panel.visible = false
	pass

func _toggle_visibility():
	main_panel.visible = !main_panel.visible
	pass
