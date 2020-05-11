extends Node

var current_camera : Camera = null

func camera_shake(time, amount):
	if current_camera:
		current_camera.shake(time, amount)
	pass
