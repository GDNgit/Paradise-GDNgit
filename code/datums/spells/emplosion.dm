/datum/spell/emplosion
	name = "Emplosion"
	desc = "This spell emplodes an area."

	var/emp_heavy = 2
	var/emp_light = 3

	action_icon_state = "emp"

/datum/spell/emplosion/create_new_targeting()
	return new /datum/spell_targeting/self

/datum/spell/emplosion/cast(list/targets, mob/user = usr)

	for(var/mob/living/target in targets)
		empulse(target.loc, emp_heavy, emp_light, TRUE)

	return
