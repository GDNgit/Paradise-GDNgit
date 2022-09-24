/mob/living/silicon/ai/attack_xenomorph(mob/living/carbon/xenomorph/humanoid/M)
	if(!SSticker)
		to_chat(M, "You cannot attack people before the game has started.")
		return
	..()

/mob/living/silicon/ai/attack_slime(mob/living/simple_animal/slime/user)
	return //immune to slimes
