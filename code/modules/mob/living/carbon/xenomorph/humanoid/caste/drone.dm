/mob/living/carbon/xenomorph/humanoid/drone
	name = "xenomorph drone"
	caste = "d"
	maxHealth = 100
	health = 100
	icon_state = "xenomorphd_s"

/mob/living/carbon/xenomorph/humanoid/drone/Initialize(mapload)
	. = ..()
	if(src.name == "xenomorph drone")
		src.name = "xenomorph drone ([rand(1, 1000)])"
	src.real_name = src.name

/mob/living/carbon/xenomorph/humanoid/drone/get_caste_organs()
	. = ..()
	. += list(
		/obj/item/organ/internal/xenos/plasmavessel/drone,
		/obj/item/organ/internal/xenos/acidgland,
		/obj/item/organ/internal/xenos/resinspinner,
	)


//Drones use the same base as generic humanoids.
//Drone verbs

/mob/living/carbon/xenomorph/humanoid/drone/verb/evolve() // -- TLE
	set name = "Evolve (500)"
	set desc = "Produce an interal egg sac capable of spawning children. Only one queen can exist at a time."
	set category = "Xenomorph"

	if(powerc(500))
		// Queen check
		var/no_queen = 1
		for(var/mob/living/carbon/xenomorph/humanoid/queen/Q in GLOB.alive_mob_list)
			if(!Q.key && Q.get_int_organ(/obj/item/organ/internal/brain/))
				continue
			no_queen = 0

		if(no_queen)
			adjustPlasma(-500)
			to_chat(src, "<span class='noticexenomorph'>You begin to evolve!</span>")
			for(var/mob/O in viewers(src, null))
				O.show_message(text("<span class='alertxenomorph'>[src] begins to twist and contort!</span>"), 1)
			var/mob/living/carbon/xenomorph/humanoid/queen/new_xeno = new(loc)
			mind.transfer_to(new_xeno)
			new_xeno.mind.name = new_xeno.name
			qdel(src)
		else
			to_chat(src, "<span class='notice'>We already have an alive queen.</span>")
	return
