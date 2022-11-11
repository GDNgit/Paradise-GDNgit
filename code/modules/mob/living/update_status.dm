/mob/living/update_blind_effects()
	if(!has_vision(information_only=TRUE))
		overlay_fullscreen("blind", /obj/screen/fullscreen/blind)
		throw_alert("blind", /obj/screen/alert/blind)
		return 1
	else
		clear_fullscreen("blind")
		clear_alert("blind")
		return 0

/mob/living/update_blurry_effects()
	var/atom/movable/plane_master_controller/game_plane_master_controller = hud_used?.plane_master_controllers[PLANE_MASTERS_GAME]
	if(!game_plane_master_controller)
		return
	if(AmountEyeBlurry())
		game_plane_master_controller.add_filter("eye_blur", 1, gauss_blur_filter(clamp(AmountEyeBlurry() * EYE_BLUR_TO_FILTER_SIZE_MULTIPLIER, 0.6, MAX_EYE_BLURRY_FILTER_SIZE)))
	else
		game_plane_master_controller.remove_filter("eye_blur")

/mob/living/update_druggy_effects()
	if(AmountDruggy())
		overlay_fullscreen("high", /obj/screen/fullscreen/high)
		throw_alert("high", /obj/screen/alert/high)
		sound_environment_override = SOUND_ENVIRONMENT_DRUGGED
	else
		clear_fullscreen("high")
		clear_alert("high")
		sound_environment_override = SOUND_ENVIRONMENT_NONE

/mob/living/update_nearsighted_effects()
	if(HAS_TRAIT(src, TRAIT_NEARSIGHT))
		overlay_fullscreen("nearsighted", /obj/screen/fullscreen/impaired, 1)
	else
		clear_fullscreen("nearsighted")

/mob/living/update_sleeping_effects(no_alert = FALSE)
	if(IsSleeping())
		if(!no_alert)
			throw_alert("asleep", /obj/screen/alert/asleep)
	else
		clear_alert("asleep")

// Querying status of the mob

// Whether the mob can hear things
/mob/living/can_hear()
	. = !HAS_TRAIT(src, TRAIT_DEAF)

// Whether the mob is able to see
// `information_only` is for stuff that's purely informational - like blindness overlays
// This flag exists because certain things like angel statues expect this to be false for dead people
/mob/living/has_vision(information_only = FALSE)
	return (information_only && stat == DEAD) || !(AmountBlinded() || HAS_TRAIT(src, TRAIT_BLIND) || stat)

// Whether the mob is capable of talking
/mob/living/can_speak()
	if(HAS_TRAIT(src, TRAIT_MUTE))
		return FALSE
	if(is_muzzled())
		var/obj/item/clothing/mask/muzzle/M = wear_mask
		if(M.mute >= MUZZLE_MUTE_MUFFLE)
			return FALSE
	return TRUE

// Whether the mob is capable of standing or not
/mob/living/proc/cannot_stand()
	return HAS_TRAIT(src, TRAIT_FLOORED)

// Whether the mob is capable of actions or not
/mob/living/incapacitated(ignore_restraints = FALSE, ignore_grab = FALSE, list/extra_checks = list(), use_default_checks = TRUE)
	// By default, checks for weakness and stunned get added to the extra_checks list.
	// Setting `use_default_checks` to FALSE means that you don't want it checking for these statuses or you are supplying your own checks.
	if(use_default_checks)
		extra_checks += CALLBACK(src, TYPE_PROC_REF(/mob/living, IsWeakened))
		extra_checks += CALLBACK(src, TYPE_PROC_REF(/mob/living, IsStunned))

	if(stat || HAS_TRAIT_NOT_FROM(src, TRAIT_HANDS_BLOCKED, TRAIT_RESTRAINED) || (!ignore_restraints && restrained()) || check_for_true_callbacks(extra_checks))
		return TRUE

/mob/living/proc/update_stamina()
	return

/mob/living/vv_edit_var(var_name, var_value)
	. = ..()
	switch(var_name)
		if("maxHealth")
			updatehealth("var edit")
		if("resize")
			update_transform()
