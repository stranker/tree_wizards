extends Node
# This will track the position of every pointer in its public `state` property, which is a
# Dictionary, in which each key is a pointer id (integer) and each value its position (Vector2).
# It works by listening to input events not handled by other means.
# It also remaps the pointer indices coming from the OS to the lowest available to be friendlier.
# It can be conveniently setup as a singleton.

var pointer_dic : Dictionary = {}
