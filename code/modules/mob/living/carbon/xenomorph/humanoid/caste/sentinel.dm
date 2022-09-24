/mob/living/carbon/xenomorph/humanoid/sentinel
	name = "xenomorph sentinel"
	caste = "s"
	maxHealth = 150
	health = 150
	icon_state = "xenomorphs_s"

//These are unused LMAO
/mob/living/carbon/xenomorph/humanoid/sentinel/large
	name = "xenomorph praetorian"
	icon = 'icons/mob/xenomorphlarge.dmi'
	icon_state = "prat_s"
	pixel_x = -16
	maxHealth = 200
	health = 200
	large = 1

/mob/living/carbon/xenomorph/humanoid/sentinel/praetorian
	name = "xenomorph praetorian"
	maxHealth = 200
	health = 200
	large = 1

/mob/living/carbon/xenomorph/humanoid/sentinel/large/update_icons()
	overlays.Cut()
	if(stat == DEAD)
		icon_state = "prat_dead"
	else if(stat == UNCONSCIOUS || IS_HORIZONTAL(src))
		icon_state = "prat_sleep"
	else
		icon_state = "prat_s"

	for(var/image/I in overlays_standing)
		overlays += I

/mob/living/carbon/xenomorph/humanoid/sentinel/Initialize(mapload)
	. = ..()
	if(name == "xenomorph sentinel")
		name = "xenomorph sentinel ([rand(1, 1000)])"
	real_name = name

/mob/living/carbon/xenomorph/humanoid/sentinel/get_caste_organs()
	. = ..()
	. += list(
		/obj/item/organ/internal/xenos/plasmavessel,
		/obj/item/organ/internal/xenos/acidgland,
		/obj/item/organ/internal/xenos/neurotoxin,
	)

//Toally unused stuff here BTW, I'll look to get this in working order...
/*
/mob/living/carbon/xenomorph/humanoid/sentinel/verb/evolve() // -- TLE
	set name = "Evolve (250)"
	set desc = "Become a Praetorian, Royal Guard to the Queen."
	set category = "Xenomorph"

	if(powerc(250))
		adjustToxLoss(-250)
		to_chat(src, "<span class=notice'>You begin to evolve!</span>")
		for(var/mob/O in viewers(src, null))
			O.show_message(text("<span class='alertxenomorph'>[src] begins to twist and contort!</span>"), 1)
		var/mob/living/carbon/xenomorph/humanoid/sentinel/praetorian/new_xeno = new(loc)
		if(mind)
			mind.transfer_to(new_xeno)
		else
			new_xeno.key = key
		new_xeno.mind.name = new_xeno.name
		qdel(src)
	return
*/
