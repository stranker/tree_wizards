extends "res://Objects/Spells/Spell.gd"

func initialize():
	.initialize()
	spell_type = SpellManager.SpellType.Ground
	spell_data["spell_type"] = spell_type
	pass
