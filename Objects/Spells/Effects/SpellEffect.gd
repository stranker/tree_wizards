extends Spatial

enum SpellEffect {STUN, ICE, BURN, LAST}
export (SpellEffect) var spell_effect = SpellEffect.LAST
export var effect_duration : float = 0

var current_enemy : Spatial = null
onready var timer = Timer.new()

signal on_end_effect

func _ready():
	create_timer()
	pass

func restart():
	timer.start()
	pass

func create_timer():
	call_deferred("add_child", timer)
	timer.connect("timeout", self, "on_timeout")
	timer.wait_time = effect_duration
	timer.one_shot = true
	timer.call_deferred("start")
	pass

func on_timeout():
	emit_signal("on_end_effect", self)
	pass

func apply_effect(enemy_effect_manager : Spatial):
	current_enemy = enemy_effect_manager
	pass
