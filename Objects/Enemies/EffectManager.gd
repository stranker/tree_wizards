extends Spatial

enum SpellEffect {STUN, ICE, BURN, LAST}

var active_effects : Array = []

signal on_start_ice_effect()
signal on_end_ice_effect()
signal on_start_burn_effect()
signal on_end_burn_effect()
signal on_start_stun_effect()
signal on_end_stun_effect()

func add_effect(effect : Spatial):
	check_active_effects(effect)
	pass

func check_active_effects(effect):
	var effect_found : bool = false
	for active_effect in active_effects:
		if effect_found:
			return
		if active_effect.spell_effect == effect.spell_effect:
			active_effect.restart()
			effect_found = true
	if !effect_found:
		active_effects.append(effect)
		effect.connect("on_end_effect",self , "_on_end_effect")
		_apply_effect(effect)
	pass

func remove_effect(effect : Spatial):
	active_effects.erase(effect)
	end_effect(effect)
	effect.disconnect("on_end_effect",self, "_on_end_effect")
	effect.call_deferred("queue_free")
	pass

func end_effect(effect : Spatial):
	match effect.spell_effect:
		SpellEffect.ICE:
			emit_signal("on_end_ice_effect")
		SpellEffect.BURN:
			emit_signal("on_end_burn_effect")
		SpellEffect.STUN:
			emit_signal("on_end_stun_effect")
	pass

func _on_end_effect(effect : Spatial):
	remove_effect(effect)
	pass

func _apply_effect(effect : Spatial):
	effect.apply_effect(self)
	pass

func freeze():
	emit_signal("on_start_ice_effect")
	pass

func stun():
	emit_signal("on_start_stun_effect")
	pass

func burn():
	emit_signal("on_start_burn_effect")
	pass
