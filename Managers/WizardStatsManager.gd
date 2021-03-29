extends Node

enum WizardStats {Damage, Health, MagicCritic, MovementSpeed, CdReduction, Last}

export var base_damage : int = 50
export var base_health : int = 250
export var base_magic_critic : float = 1.2
export var base_movement_speed : float = 5
export var base_cd_reduction : float = 0 

export var damage_increment : int = 5
export var health_increment : int = 20
export var magic_critic_increment : float = 0.05
export var movement_speed_increment : float = 0.01
export var cd_reduction_increment : float = 0.01

const magic_critic_chance : float = 0.2

signal on_level_up()


func _level_up_damage():
	base_damage += damage_increment
	pass

func _level_up_health():
	base_health += health_increment
	pass

func _level_up_magic_critic():
	base_magic_critic += magic_critic_increment
	pass

func _level_up_movement_speed():
	base_movement_speed += movement_speed_increment
	pass

func _level_up_cd_reduction():
	base_cd_reduction += cd_reduction_increment
	pass

func _on_level_up():
	var random_ability = randi() % WizardStats.Last
	match random_ability:
		WizardStats.Damage: _level_up_damage()
		WizardStats.Health: _level_up_health()
		WizardStats.MagicCritic: _level_up_magic_critic()
		WizardStats.MovementSpeed: _level_up_movement_speed()
		WizardStats.CdReduction: _level_up_cd_reduction()
	emit_signal("on_level_up")
	pass
