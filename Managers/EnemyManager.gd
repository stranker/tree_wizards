extends Node

enum EnemyType {GOBLIN, MAGE, LAST}

signal _on_enemy_killed()

var goblins_killed = 0

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_1:
			goblins_killed += 1
			_update_enemies()
		if event.scancode == KEY_2:
			goblins_killed -= 1
			if goblins_killed <= 0:
				goblins_killed = 0
			_update_enemies()
	pass

func check_enemy_killed(enemy_type, count):
	match enemy_type:
		EnemyType.GOBLIN: _check_goblins_killed(count)
	pass

func get_enemy_name(enemy_type):
	match enemy_type:
		EnemyType.GOBLIN: return "Goblin"
	pass

func _check_goblins_killed(value):
	if goblins_killed > value:
		print("completado")
	else:
		print("icnompleto")
	pass

func _update_enemies():
	emit_signal("_on_enemy_killed")
	pass
