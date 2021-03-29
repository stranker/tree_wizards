extends Node

signal on_quest_finished()
signal on_new_quest()

var quests : Array = []
var quests_actived : Array = []

class Quest:
	signal _quest_completed()
	
	var id : int = -1
	var desc : String = ""
	var reward : int = ItemManager.CollectableType.LAST
	var func_ref : FuncRef = FuncRef.new()
	var args : Array = []
	
	func _init(_id, _desc, _reward, _func_ref, _func_obj, _args):
		id = _id
		desc = _desc
		reward = _reward
		func_ref.set_function(_func_ref)
		func_ref.set_instance(_func_obj)
		args = _args
		pass
	
	func _check_completion():
		func_ref.call_funcv(args)
		pass

func _ready():
	_create_quest()
	EnemyManager.connect("_on_enemy_killed", self, "_check_quests")
	pass

func _kill_type_quest(reward, kill_count, enemy_type):
	var desc = "Matar " + str(kill_count) + EnemyManager.get_enemy_name(enemy_type)
	var quest : Quest = Quest.new(quests.size(), desc, reward, "check_enemy_killed", EnemyManager, [enemy_type, kill_count])
	quests.append(quest)
	pass

func _create_quest():
	_kill_type_quest(ItemManager.CollectableType.COIN, 10, EnemyManager.EnemyType.GOBLIN)
	pass

func _check_quests():
	for quest in quests:
		quest._check_completion()
	pass
