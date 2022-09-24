//This holds the parent spell for xenomorphs, thank the lord hal 9000 did this before me or I'd be clueless
/obj/effect/proc_holder/spell/xenomorph
	panel = "Xenomorph"
	school = "Xenomorph"
	action_background_icon_state = "bg_xenomorph"
	//Xenomorphs are carbons, not humans
	human_req = FALSE
	clothes_req = FALSE
	/// Plasma my beloved. Tracks how much plasma is required to cast, and if that plasma is deducted
	var/required_plasma
	var/deduct_plasma_on_cast = TRUE

/obj/effect/proc_holder/spell/xenomorph/create_new_handler()
	var/datum/spell_handler/xenomorph/H = new
	H.required_plasma = required_plasma
	H.deduct_plasma_on_cast = deduct_plasma_on_cast
	return H

/obj/effect/proc_holder/spell/xenomorph/self/create_new_targeting()
	return new /datum/spell_targeting/self
