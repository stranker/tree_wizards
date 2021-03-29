extends Node

var debug_panel

func set_panel(panel):
	debug_panel = panel

func debug(info):
	if !debug_panel:
		return
	debug_panel.set_debug(str(info))
	pass

func debug_var(info, _var):
	if !debug_panel:
		return
	debug_panel.set_debug_var(str(info), str(_var))
	pass

func set_player_state(state):
	debug_panel.set_player_state(state)
	pass

func set_visual_state(state):
	debug_panel.set_visual_state(state)
	pass
