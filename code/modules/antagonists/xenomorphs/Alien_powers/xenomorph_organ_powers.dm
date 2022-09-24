//Where all the xenomorph spells/powers from xenomorph organs are kept

//Plant weeds

//Transfer plasma

//Corrosive Acid

//Whisper

//Resin object builder


//Neurotoxin spit
/obj/effect/proc_holder/spell/xenomorph/neurotoxin_spit
	name = "Neurotoxin Spit"
	desc = "Allows you to spit neurotoxin at a target. Deals 40 stamina damage and knocks down for 10 seconds."

	base_cooldown = 5
	clothes_req = FALSE

	selection_activated_message		= "<span class='notice'>Your prepare to spit neurotoxin! <B>Left-click to spit at a target!</B></span>"
	selection_deactivated_message	= "<span class='notice'>You swallow your prepared neurotoxin.</span>"
	required_plasma = 50
	//So you can change the spit type to something silly like a bola
	var/neurotoxin_spit_type = /obj/item/projectile/bullet/neurotoxin
	action_icon_state = "neurotoxin_spit0"
	sound = 'sound/magic/fireball.ogg'

	active = FALSE

/obj/effect/proc_holder/spell/xenomorph/neurotoxin_spit/create_new_targeting()
	var/datum/spell_targeting/clicked_atom/C = new()
	C.range = 20
	return C

/obj/effect/proc_holder/spell/xenomorph/neurotoxin_spit/update_icon_state()
	if(!action)
		return
	action.button_icon_state = "neurotoxin_spit[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/spell/xenomorph/neurotoxin_spit/cast(list/targets, mob/living/user = usr)
	//Only one target for neurotoxin spit
	var/target = targets[1]
	var/turf/T = user.loc
	// Get the tile infront of the move, based on their direction
	var/turf/U = get_step(user, user.dir)
	if(!isturf(U) || !isturf(T))
		return FALSE

	var/obj/item/projectile/magic/xenomorph/neurotoxin_spit/NS = new neurotoxin_spit_type(user.loc)
	NS.current = get_turf(user)
	NS.original = target
	NS.firer = user
	NS.preparePixelProjectile(target, get_turf(target), user)
	NS.fire()
	user.newtonian_move(get_dir(U, T))

	return TRUE


//Egg laying

