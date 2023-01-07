/mob/living/carbon/alien/larva
	name = "alien larva"
	real_name = "alien larva"
	icon_state = "larva0"
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL

	maxHealth = 25
	health = 25
	density = FALSE

	var/amount_grown = 0
	var/max_grown = 200
	var/time_of_birth
	var/already_transfering = FALSE
	death_message = "lets out a waning high-pitched cry."
	death_sound = null

//This is fine right now, if we're adding organ specific damage this needs to be updated
/mob/living/carbon/alien/larva/Initialize(mapload)
	. = ..()
	if(name == "alien larva")
		name = "alien larva ([rand(1, 1000)])"
	real_name = name
	regenerate_icons()
	add_language("Xenomorph")
	add_language("Hivemind")
	AddSpell(new /obj/effect/proc_holder/spell/alien_spell/evolve_larva)

/mob/living/carbon/alien/larva/get_caste_organs()
	. = ..()
	. += /obj/item/organ/internal/alien/plasmavessel/larva


/mob/living/carbon/alien/larva/Stat()
	..()
	stat(null, "Progress: [amount_grown]/[max_grown]")

/mob/living/carbon/alien/larva/add_plasma(amount)
	if(stat != DEAD && amount > 0)
		amount_grown = min(amount_grown + 1, max_grown)
	..(amount)

/mob/living/carbon/alien/larva/proc/cast_larva()
	if(already_transfering)
		to_chat(src, "<span class='noticealien'>You stop transfering plasma.</span>" )
		already_transfering = FALSE
		return
	to_chat(src, "<span class='noticealien'>You prepare to transfer plasma.</span>")
	already_transfering = TRUE


/mob/living/carbon/alien/larva/ex_act(severity)
	..()

	var/brute_loss = null
	var/fire_loss = null
	switch(severity)
		if(1.0)
			gib()
			return
		if(2.0)
			brute_loss += 60
			fire_loss += 60
			AdjustEarDamage(30, 120)
		if(3.0)
			brute_loss += 30
			if(prob(50))
				Paralyse(2 SECONDS)
			AdjustEarDamage(15, 60)

	adjustBruteLoss(brute_loss)
	adjustFireLoss(fire_loss)
	updatehealth()

//can't equip anything
/mob/living/carbon/alien/larva/attack_ui(slot_id)
	return

/mob/living/carbon/alien/larva/restrained()
	return FALSE

/mob/living/carbon/alien/larva/var/temperature_resistance = T0C+75

// new damage icon system
// now constructs damage icon for each organ from mask * damage field


/mob/living/carbon/alien/larva/show_inv(mob/user as mob)
	return

/mob/living/carbon/alien/larva/start_pulling(atom/movable/AM, state, force = pull_force, show_message = FALSE)
	return FALSE

