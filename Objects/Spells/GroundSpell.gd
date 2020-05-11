extends "res://Objects/Spells/Spell.gd"

export var spell_range : float = 0
export var area_effect : float = 0

func initialize():
	.initialize()
	spell_info_data = SpellInfo.new(spell_range, area_effect)
	pass
