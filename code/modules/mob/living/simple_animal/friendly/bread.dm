/mob/living/simple_animal/bread
	name = "bread"
	real_name = "bread"
	desc = "It looks a bit half baked."
	icon_state = "bread"
	icon_dead = "bread"
	speak_chance = 0
	turns_per_move = 5
	maxHealth = 1
	health = 1
	butcher_results = list(/obj/item/reagent_containers/food/snacks/breadslice = 5)
	response_help  = "pokes"
	response_disarm = "flips"
	response_harm   = "kicks"
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	mob_size = MOB_SIZE_TINY
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0) //bread doesn't breath
	minbodytemp = 0		//cold bread
	maxbodytemp = 510	//temp to bake bread at
	holder_type = /obj/item/holder/bread
	can_collar = TRUE //bread on the go
	del_on_death = TRUE


/mob/living/simple_animal/bread/attack_hand(mob/living/carbon/human/M)
	if(M.a_intent == INTENT_HELP)
		get_scooped(M, TRUE)
	..()

	/mob/living/carbon/human/proc/makeBread()
	to_chat(src, "<span class='danger'>Everything looks a bit grainy.</span>")
	M.change_mob_type( /mob/living/carbon/alien/humanoid/hunter , null, null, delmob, 1 )
	if(mind)
		mind.assigned_role = "Bread"
