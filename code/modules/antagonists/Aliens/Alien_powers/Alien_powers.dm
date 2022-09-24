//This holds the parent spell for aliens, thank the lord hal 9000 did this before me or I'd be clueless
/obj/effect/proc_holder/spell/alien
	panel = "Alien"
	school = "Alien"
	action_background_icon_state = "bg_alien"
	//Aliens are carbons, not humans
	human_req = FALSE
	clothes_req = FALSE
	/// Plasma my beloved. Tracks how much plasma is required to cast, and if that plasma is deducted
	var/required_plasma
	var/deduct_plasma_on_cast = TRUE

/obj/effect/proc_holder/spell/alien/create_new_handler()
	var/datum/spell_handler/alien/H = new
	H.required_plasma = required_plasma
	H.deduct_plasma_on_cast = deduct_plasma_on_cast
	return H

/obj/effect/proc_holder/spell/alien/self/create_new_targeting()
	return new /datum/spell_targeting/self
