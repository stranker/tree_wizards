extends Node

var debug_panel

func set_panel(panel):
	debug_panel = panel

func debug(info):
	if debug_panel == null:
		return
	var str_info = str(info)
	debug_panel.set_debug(str_info)
	pass

func set_player_state(state):
	debug_panel.set_player_state(state)
	pass

func set_visual_state(state):
	debug_panel.set_visual_state(state)
	pass
