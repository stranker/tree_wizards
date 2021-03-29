extends KinematicBody

export var spell_damage : int = 1
export var spell_name : String = ""
export var spell_range : float = 1
export var spell_speed : float = 1
export var spell_effect_scene : PackedScene = null
var spell_effect : Spatial = null
var activated : bool = false
var text_damage_scene = preload("res://UI/DamagePop.tscn")
var hit_particles_scene = preload("res://Objects/Misc/HitParticles.tscn")

var total_damage : int = 0
var is_critic : bool = false

signal on_enemy_hit(target)

func _ready():
	connect("on_enemy_hit", self, "_on_enemy_hit")

func cast(wizard, spell_pos, spell_dir):
	pass

func is_enemy(body : Spatial):
	return body.is_in_group("Enemy")

func _get_total_damage():
	total_damage = WizardStatsManager.base_damage + spell_damage
	is_critic = rand_range(0, 1) < WizardStatsManager.magic_critic_chance
	if is_critic:
		total_damage *= WizardStatsManager.base_magic_critic
	return total_damage

func _on_enemy_hit(target):
	_pop_up_damage(target)
	_create_hit_particles(target)
	pass

func _create_hit_particles(target : Spatial):
	var hit_particles : CPUParticles = hit_particles_scene.instance()
	get_tree().root.add_child(hit_particles)
	hit_particles.init(target)
	pass

func _pop_up_damage(target : Spatial):
	var text_damage_pop = text_damage_scene.instance()
	get_tree().root.add_child(text_damage_pop)
	text_damage_pop.set_info(total_damage, is_critic, target.get_damage_pop_pos())
	pass
