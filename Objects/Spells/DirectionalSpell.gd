extends "res://Objects/Spells/Spell.gd"

export var live_time : float = 4
export var rotate_to_dir : bool = false
export var speed : float = 3
export var can_move : bool = false

var velocity : Vector3
var dir : Vector3

var visual : Spatial = null

func initialize():
	.initialize()
	spell_type = SpellManager.SpellType.Directional
	pass

func _ready():
	create_live_timer(live_time)
	pass

func _process(delta):
	if can_move:
		transform.origin += velocity * delta
	pass

func spell_dir(direction : Vector3, move : bool):
	dir = direction
	velocity = dir * speed
	can_move = move
	visual = get_node("Visual")
	if rotate_to_dir:
		visual.rotation.y = Vector2(dir.z,dir.x).angle()
	pass
