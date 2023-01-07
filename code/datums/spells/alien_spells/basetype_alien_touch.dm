/obj/effect/proc_holder/spell/touch/alien_spell
	name = "Basetype Alien spell"
	desc = "You should not see this in game, if you do file a github report!"
	hand_path = "/obj/item/melee/touch_attack/alien"
	/// Extremely fast cooldown, only present so the cooldown system doesn't explode
	base_cooldown = 1
	action_background_icon_state = "bg_alien"
	clothes_req = FALSE
	create_attack_logs = FALSE
	/// Every alien spell creates only logs, no attack messages on someone placing weeds, but you DO get attack messages on neurotoxin and corrosive acid
	create_only_logs = TRUE
	/// We want a special on remove message, so we got this variable to do so
	on_remove_message = FALSE
	/// How much plasma it costs to use this
	var/plasma_cost = 0
	action_icon_state = "gib"

/obj/effect/proc_holder/spell/touch/alien_spell/Initialize(mapload)
	. = ..()
	if(plasma_cost)
		name = "[name] ([plasma_cost])"

/obj/effect/proc_holder/spell/touch/alien_spell/Click(mob/user = usr)
	if(attached_hand)
		to_chat(user, "<span class='noticealien'>You withdraw your [src].</span>")
	..()

/obj/effect/proc_holder/spell/touch/alien_spell/cast(list/targets, mob/living/carbon/user)
	user.add_plasma(plasma_cost)
	..()

/obj/effect/proc_holder/spell/touch/alien_spell/create_new_handler()
	var/datum/spell_handler/alien/H = new
	H.plasma_cost = plasma_cost
	return H

/obj/item/melee/touch_attack/alien
	name = "Basetype Alien touch_attack"
	desc = "You should not see this in game, if you do file a github report!"
	/// Alien spells don't have catchphrases
	has_catchphrase = FALSE
	/// Beepsky shouldn't be arresting you over this
	needs_permit = FALSE
	var/continue_cast = TRUE

/obj/item/melee/touch_attack/alien/attack_alien(mob/user) // Can be picked up by aliens... if it got on the ground somehow
	return attack_hand(user)

/obj/item/melee/touch_attack/alien/proc/plasma_check(plasma, mob/living/carbon/user)
	var/plasma_current = user.get_plasma()
	if(plasma_current < plasma)
		attached_spell.attached_hand = null
		qdel(src)
		continue_cast = FALSE
		return
	return
