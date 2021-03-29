extends Node

enum CollectableType {COIN, GEM, LAST}

class Collectable:
	var type : int = CollectableType.LAST

class Item:
	var name : String = "Placeholder"
	var level : int = 0
	
	func _init(item_name, item_level):
		name = item_name
		level = item_level
		pass
