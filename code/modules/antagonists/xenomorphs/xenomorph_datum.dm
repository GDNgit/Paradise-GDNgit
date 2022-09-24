/datum/antagonist/xenomorph
	name = "Xenomorph"
	antag_hud_type = ANTAG_HUD_XENOMORPH
	antag_hud_name = "hudxenomorph"
	special_role = SPECIAL_ROLE_XENOMORPH
	wiki_page_name = "Xenomorph"
	var/total_plasma = 0
	//what do we have in our right hand?
	var/obj/item/r_store = null
	//what do we have in our left hand?
	var/obj/item/l_store = null
	//What cast are we apart of?
	var/datum/xenomorph_cast/cast
	//used to switch between the two xenomorph icon files.
	var/alt_icon = 'icons/mob/xenomorphleap.dmi'
	//Used for xenomorph actions
	var/next_attack = 0
	var/pounce_cooldown = 0
	var/pounce_cooldown_time = 30
	var/leap_on_click = 0
	//admin fuckery options
	var/custom_pixel_x_offset = 0
	var/custom_pixel_y_offset = 0
	//The disarm intent damage xenomorphs deal
	var/xenomorph_disarm_damage = 30
	//The harm intent damage an xenomorph deals
	var/xenomorph_slash_damage = 0
	//This can be + or -, how fast an xenomorph moves
	var/xenomorph_movement_delay = 0
	/// list of available powers from xenomorph organs
	var/list/powers = list()



/datum/antagonist/xenomorph/Destroy(force, ...)
	QDEL_NULL(cast)
	QDEL_LIST(powers)
	return ..()


/datum/antagonist/xenomorph/proc/force_add_ability(path) //You can force spells, but for the love of god, just give them the damn organ...
	var/spell = new path(owner)
	if(istype(spell, /obj/effect/proc_holder/spell))
		owner.AddSpell(spell)
	if(istype(spell, /datum/xenomorph_passive))
		var/datum/xenomorph_passive/passive = spell
		passive.owner = owner.current
	powers += spell
	owner.current.update_sight() // Life updates conditionally, so we need to update sight here in case the xenomorph gets you know, thermals

/datum/antagonist/xenomorph/proc/get_ability(path)
	for(var/datum/power as anything in powers)
		if(power.type == path)
			return power
	return null

/datum/antagonist/xenomorph/proc/add_ability(path)
	if(!get_ability(path))
		force_add_ability(path)

/datum/antagonist/xenomorph/proc/remove_ability(ability)
	if(ability && (ability in powers))
		powers -= ability
		owner.spell_list.Remove(ability)
		qdel(ability)
		owner.current.update_sight() // Thermals tax cuz life is wacccck.

/datum/antagonist/xenomorph/remove_innate_effects(mob/living/old_body) //this might come up, doubt it though -GDN
	var/mob/living/L = old_body || owner.current
	for(var/P in powers)
		remove_ability(P)
	var/datum/hud/hud = L.hud_used
	if(hud?.xenomorph_plasma_display)
	REMOVE_TRAITS_IN(owner.current, "xenomorph")
	return ..()

/datum/antagonist/xenomorph/on_removal()
	SSticker.mode.xenomorph -= owner
	owner.current.create_log(CONVERSION_LOG, "Removed_From_Xenomorph_Role")
	..()

/datum/antagonist/xenomorph/on_gain()
	SSticker.mode.xenomorph += owner
	..()


/datum/antagonist/xenomorph/vv_edit_var(var_name, var_value)
	. = ..()
	check_xenomorph_upgrade(TRUE)

/datum/antagonist/xenomorph/give_objectives() //for adminbus
	add_objective(/datum/objective/murderize)

/datum/antagonist/xenomorph/greet()
	var/dat
	SEND_SOUND(owner.current, sound('sound/ambience/antag/xenomorphalert.ogg'))
	dat = "<span class='danger'>You are a Xenomorph!</span><br>"
	dat += {"You are a dangerous creature seeking to grow your nest! An xenomorph queen is able to lay the eggs that you need to spread. You and your hive must infect those who wish to stop your spread!
		You are weak to burn damage, have a resistance against brute damage, and can use xenomorph weeds to heal."}
	to_chat(owner.current, dat)

/datum/hud/proc/remove_xenomorph_hud()
	static_inventory -= xenomorph_plasma_display
	QDEL_NULL(xenomorph_plasma_display)
