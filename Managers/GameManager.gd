extends Node

onready var wizard : KinematicBody = get_tree().get_nodes_in_group("Player")[0]

onready var is_android_device : bool = OS.get_name().to_lower() == "android"
