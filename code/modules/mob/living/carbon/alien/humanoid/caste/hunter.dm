/mob/living/carbon/alien/humanoid/hunter
	name = "alien hunter"
	caste = "h"
	maxHealth = 125
	health = 125
	icon_state = "alienh_s"
	alien_movement_delay = -0.5 //hunters are faster than normal xenomorphs, and people
	var/leap_on_click = FALSE

/mob/living/carbon/alien/humanoid/hunter/Initialize(mapload)
	. = ..()
	name = "alien hunter ([rand(1, 1000)])"
	real_name = name

/mob/living/carbon/alien/humanoid/hunter/get_caste_organs()
	. = ..()
	. += /obj/item/organ/internal/alien/plasmavessel/hunter


/mob/living/carbon/alien/humanoid/hunter/handle_environment()
	if(m_intent == MOVE_INTENT_RUN || IS_HORIZONTAL(src))
		..()
	else
		add_plasma(-heal_rate)

/mob/living/carbon/alien/humanoid/hunter/proc/toggle_leap(message = 1)
	leap_on_click = !leap_on_click
	leap_icon.icon_state = "leap_[leap_on_click ? "on":"off"]"
	update_icons()
	if(message)
		to_chat(src, "<span class='noticealien'>You will now [leap_on_click ? "leap at":"slash at"] enemies!</span>")

/mob/living/carbon/alien/humanoid/hunter/ClickOn(atom/A, params)
	face_atom(A)
	if(leap_on_click)
		leap_at(A)
	else
		..()

#define MAX_ALIEN_LEAP_DIST 7

/mob/living/carbon/alien/humanoid/hunter/proc/leap_at(atom/A)
	if(leaping) //Leap while you leap, so you can leap while you leap
		return

	if(IS_HORIZONTAL(src))
		return

	leaping = 1
	update_icons()
	Immobilize(15 SECONDS, TRUE)
	throw_at(A, MAX_ALIEN_LEAP_DIST, 1.5, spin = 0, diagonals_first = 1, callback = CALLBACK(src, PROC_REF(leap_end)))

/mob/living/carbon/alien/humanoid/hunter/proc/leap_end()
	leaping = 0
	SetImmobilized(0, TRUE)
	update_icons()

/mob/living/carbon/alien/humanoid/hunter/throw_impact(atom/A)
	if(!leaping)
		return ..()

	if(isliving(A))
		var/mob/living/L = A
		var/blocked = 0
		if(ishuman(A))
			var/mob/living/carbon/human/H = A
			if(H.check_shields(src, 0, "the [name]", attack_type = LEAP_ATTACK))
				blocked = 1
		if(!blocked)
			L.visible_message("<span class ='danger'>[src] pounces on [L]!</span>", "<span class ='userdanger'>[src] pounces on you!</span>")
			if(ishuman(L))
				var/mob/living/carbon/human/H = L
				H.apply_effect(10 SECONDS, KNOCKDOWN, H.run_armor_check(null, MELEE))
				H.adjustStaminaLoss(40)
			else
				L.Weaken(10 SECONDS)
			sleep(2)//Runtime prevention (infinite bump() calls on hulks)
			step_towards(src,L)
		else
			Weaken(1 SECONDS, TRUE)
			..()

		toggle_leap(0)
	else if(A.density && !A.CanPass(src))
		visible_message("<span class ='danger'>[src] smashes into [A]!</span>", "<span class ='alertalien'>[src] smashes into [A]!</span>")
		Weaken(1 SECONDS, TRUE)
		playsound(get_turf(src), 'sound/effects/bang.ogg', 50, 0, 0) // owwie
		..()
	if(leaping)
		leaping = 0
		update_icons()


/mob/living/carbon/alien/humanoid/hunter/update_icons()
	..()
	if(leap_on_click && !leaping)
		icon_state = "alien[caste]_pounce"
	if(leaping)
		if(alt_icon == initial(alt_icon))
			var/old_icon = icon
			icon = alt_icon
			alt_icon = old_icon
		icon_state = "alien[caste]_leap"
		pixel_x = -32
		pixel_y = -32

/mob/living/carbon/alien/humanoid/float(on)
	if(leaping)
		return
	..()
