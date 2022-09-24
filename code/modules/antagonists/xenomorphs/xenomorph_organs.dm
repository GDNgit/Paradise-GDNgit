//File where we keep all the organs for xenomorphs
/obj/item/organ/internal/xenomorph
	origin_tech = "biotech=5"
	icon_state = "xgibmid2"
	var/list/xenomorph_powers = list()
	tough = TRUE
	sterile = TRUE

///can be changed if xenomorphs get an update.. OH MY BROTHER IN CHRIST TODAY WILL BE A GOOD DAY
/obj/item/organ/internal/xenomorph/insert(mob/living/carbon/M, special = 0)
	..()
	for(var/P in xenomorph_powers)
		M.spells |= P

/obj/item/organ/internal/xenomorph/remove(mob/living/carbon/M, special = 0)
	for(var/P in xenomorph_powers)
		M.spells -= P
	. = ..()

/obj/item/organ/internal/xenomorph/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("sacid", 10)
	return S

//xenomorph ORGANS

/obj/item/organ/internal/xenomorph/plasmavessel
	name = "xenomorph plasma vessel"
	icon_state = "plasma"
	w_class = WEIGHT_CLASS_NORMAL
	origin_tech = "biotech=5;plasmatech=4"
	parent_organ = "chest"
	slot = "plasmavessel"
	xenomorph_powers = list(/obj/effect/proc_holder/spell/xenomorph/plant_weeds, /obj/effect/proc_holder/spell/xenomorph/transfer_plasma)

	//Handles how much plasma we got stored, can store, how much we get in a life tick on weeds
	var/stored_plasma = 0
	var/max_plasma = 500
	var/plasma_rate = 10
	//How much we heal per life tick on weeds
	var/heal_rate = 5

/obj/item/organ/internal/xenomorph/plasmavessel/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("plasma", stored_plasma/10)
	return S

/obj/item/organ/internal/xenomorph/plasmavessel/queen
	name = "bloated xenomorph plasma vessel"
	icon_state = "plasma_large"
	origin_tech = "biotech=6;plasmatech=4"
	stored_plasma = 200
	max_plasma = 500
	plasma_rate = 25

/obj/item/organ/internal/xenomorph/plasmavessel/drone
	name = "large xenomorph plasma vessel"
	icon_state = "plasma_large"
	stored_plasma = 200
	max_plasma = 500

/obj/item/organ/internal/xenomorph/plasmavessel/sentinel
	stored_plasma = 100
	max_plasma = 250

/obj/item/organ/internal/xenomorph/plasmavessel/hunter
	name = "small xenomorph plasma vessel"
	icon_state = "plasma_tiny"
	stored_plasma = 100
	max_plasma = 150

/obj/item/organ/internal/xenomorph/plasmavessel/larva
	name = "tiny xenomorph plasma vessel"
	icon_state = "plasma_tiny"
	max_plasma = 100


/obj/item/organ/internal/xenomorph/plasmavessel/on_life()
	//If there are xenomorph weeds on the ground then heal if needed or give some plasma
	if(locate(/obj/structure/xenomorph/weeds) in owner.loc)
		if(owner.health >= owner.maxHealth)
			owner.adjustPlasma(plasma_rate)
		else
			var/heal_amt = heal_rate
			if(!isxenomorph(owner))
				heal_amt *= 0.2
			owner.adjustPlasma(plasma_rate*0.5)
			owner.adjustBruteLoss(-heal_amt)
			owner.adjustFireLoss(-heal_amt)
			owner.adjustOxyLoss(-heal_amt)
			owner.adjustCloneLoss(-heal_amt)

/obj/item/organ/internal/xenomorph/plasmavessel/insert(mob/living/carbon/M, special = 0)
	..()
	if(isxenomorph(M))
		var/mob/living/carbon/xenomorph/A = M
		A.updatePlasmaDisplay()

/obj/item/organ/internal/xenomorph/plasmavessel/remove(mob/living/carbon/M, special = 0)
	. =..()
	if(isxenomorph(M))
		var/mob/living/carbon/xenomorph/A = M
		A.updatePlasmaDisplay()


/obj/item/organ/internal/xenomorph/acidgland
	name = "xenomorph acid gland"
	icon_state = "acid"
	parent_organ = "head"
	slot = "acid"
	origin_tech = "biotech=5;materials=2;combat=2"
	xenomorph_powers = list(/obj/effect/proc_holder/spell/xenomorph/corrosive_acid)


/obj/item/organ/internal/xenomorph/hivenode
	name = "xenomorph hive node"
	icon_state = "hivenode"
	parent_organ = "head"
	slot = "hivenode"
	origin_tech = "biotech=5;magnets=4;bluespace=3"
	w_class = WEIGHT_CLASS_TINY
	xenomorph_powers = list(/obj/effect/proc_holder/spell/xenomorph/whisper)

/obj/item/organ/internal/xenomorph/hivenode/insert(mob/living/carbon/M, special = 0)
	..()
	M.faction |= "xenomorph"
	M.add_language("Hivemind")
	M.add_language("Xenomorph hivemind")
	ADD_TRAIT(M, TRAIT_XENOMORPH_IMMUNE, "xenomorph immune")

/obj/item/organ/internal/xenomorph/hivenode/remove(mob/living/carbon/M, special = 0)
	M.faction -= "xenomorph"
	M.remove_language("Hivemind")
	M.remove_language("Xenomorph hivemind")
	REMOVE_TRAIT(M, TRAIT_XENOMORPH_IMMUNE, "xenomorph immune")
	. = ..()

/obj/item/organ/internal/xenomorph/neurotoxin
	name = "xenomorph neurotoxin gland"
	icon_state = "neurotox"
	parent_organ = "head"
	slot = "neurotox"
	origin_tech = "biotech=5;combat=5"
	xenomorph_powers = list(/obj/effect/proc_holder/spell/xenomorph/neurotoxin)
	//I dunno how I feel about this being tied to the organ, but it's uh, probably fine?
	var/neurotoxin_cooldown = FALSE
	var/neurotoxin_cooldown_time = 5 SECONDS

/obj/item/organ/internal/xenomorph/resinspinner
	name = "xenomorph resin organ"//...there tiger.... //Chief what the fuck does this mean -GDN.
	parent_organ = "mouth"
	icon_state = "liver-x"
	slot = "spinner"
	origin_tech = "biotech=5;materials=4"
	xenomorph_powers = list(/obj/effect/proc_holder/spell/xenomorph/resin_build)

/obj/item/organ/internal/xenomorph/eggsac
	name = "xenomorph egg sac"
	icon_state = "eggsac"
	parent_organ = "groin"
	slot = "eggsac"
	w_class = WEIGHT_CLASS_BULKY
	origin_tech = "biotech=6"
	xenomorph_powers = list(/obj/effect/proc_holder/spell/xenomorph/queen/lay_egg)
