//File where we keep all the organs for aliens
/obj/item/organ/internal/alien
	origin_tech = "biotech=5"
	icon_state = "xgibmid2"
	var/list/alien_powers = list()
	tough = TRUE
	sterile = TRUE

///can be changed if aliens get an update.. OH MY BROTHER IN CHRIST TODAY WILL BE A GOOD DAY
/obj/item/organ/internal/alien/insert(mob/living/carbon/M, special = 0)
	..()
	for(var/P in alien_powers)
		M.spells |= P

/obj/item/organ/internal/alien/remove(mob/living/carbon/M, special = 0)
	for(var/P in alien_powers)
		M.spells -= P
	. = ..()

/obj/item/organ/internal/alien/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("sacid", 10)
	return S

//ALIEN ORGANS

/obj/item/organ/internal/alien/plasmavessel
	name = "alien plasma vessel"
	icon_state = "plasma"
	w_class = WEIGHT_CLASS_NORMAL
	origin_tech = "biotech=5;plasmatech=4"
	parent_organ = "chest"
	slot = "plasmavessel"
	alien_powers = list(/obj/effect/proc_holder/spell/alien/plant_weeds, /obj/effect/proc_holder/spell/alien/transfer_plasma)

	//Handles how much plasma we got stored, can store, how much we get in a life tick on weeds
	var/stored_plasma = 0
	var/max_plasma = 500
	var/plasma_rate = 10
	//How much we heal per life tick on weeds
	var/heal_rate = 5

/obj/item/organ/internal/alien/plasmavessel/prepare_eat()
	var/obj/S = ..()
	S.reagents.add_reagent("plasma", stored_plasma/10)
	return S

/obj/item/organ/internal/alien/plasmavessel/queen
	name = "bloated alien plasma vessel"
	icon_state = "plasma_large"
	origin_tech = "biotech=6;plasmatech=4"
	stored_plasma = 200
	max_plasma = 500
	plasma_rate = 25

/obj/item/organ/internal/alien/plasmavessel/drone
	name = "large alien plasma vessel"
	icon_state = "plasma_large"
	stored_plasma = 200
	max_plasma = 500

/obj/item/organ/internal/alien/plasmavessel/sentinel
	stored_plasma = 100
	max_plasma = 250

/obj/item/organ/internal/alien/plasmavessel/hunter
	name = "small alien plasma vessel"
	icon_state = "plasma_tiny"
	stored_plasma = 100
	max_plasma = 150

/obj/item/organ/internal/alien/plasmavessel/larva
	name = "tiny alien plasma vessel"
	icon_state = "plasma_tiny"
	max_plasma = 100


/obj/item/organ/internal/alien/plasmavessel/on_life()
	//If there are alien weeds on the ground then heal if needed or give some plasma
	if(locate(/obj/structure/alien/weeds) in owner.loc)
		if(owner.health >= owner.maxHealth)
			owner.adjustPlasma(plasma_rate)
		else
			var/heal_amt = heal_rate
			if(!isalien(owner))
				heal_amt *= 0.2
			owner.adjustPlasma(plasma_rate*0.5)
			owner.adjustBruteLoss(-heal_amt)
			owner.adjustFireLoss(-heal_amt)
			owner.adjustOxyLoss(-heal_amt)
			owner.adjustCloneLoss(-heal_amt)

/obj/item/organ/internal/alien/plasmavessel/insert(mob/living/carbon/M, special = 0)
	..()
	if(isalien(M))
		var/mob/living/carbon/alien/A = M
		A.updatePlasmaDisplay()

/obj/item/organ/internal/alien/plasmavessel/remove(mob/living/carbon/M, special = 0)
	. =..()
	if(isalien(M))
		var/mob/living/carbon/alien/A = M
		A.updatePlasmaDisplay()


/obj/item/organ/internal/alien/acidgland
	name = "alien acid gland"
	icon_state = "acid"
	parent_organ = "head"
	slot = "acid"
	origin_tech = "biotech=5;materials=2;combat=2"
	alien_powers = list(/obj/effect/proc_holder/spell/alien/corrosive_acid)


/obj/item/organ/internal/alien/hivenode
	name = "alien hive node"
	icon_state = "hivenode"
	parent_organ = "head"
	slot = "hivenode"
	origin_tech = "biotech=5;magnets=4;bluespace=3"
	w_class = WEIGHT_CLASS_TINY
	alien_powers = list(/obj/effect/proc_holder/spell/alien/whisper)

/obj/item/organ/internal/alien/hivenode/insert(mob/living/carbon/M, special = 0)
	..()
	M.faction |= "alien"
	M.add_language("Hivemind")
	M.add_language("Alien hivemind")
	ADD_TRAIT(M, TRAIT_ALIEN_IMMUNE, "alien immune")

/obj/item/organ/internal/alien/hivenode/remove(mob/living/carbon/M, special = 0)
	M.faction -= "alien"
	M.remove_language("Hivemind")
	M.remove_language("Alien hivemind")
	REMOVE_TRAIT(M, TRAIT_ALIEN_IMMUNE, "alien immune")
	. = ..()

/obj/item/organ/internal/alien/neurotoxin
	name = "alien neurotoxin gland"
	icon_state = "neurotox"
	parent_organ = "head"
	slot = "neurotox"
	origin_tech = "biotech=5;combat=5"
	alien_powers = list(/obj/effect/proc_holder/spell/alien/neurotoxin)
	//I dunno how I feel about this being tied to the organ, but it's uh, probably fine?
	var/neurotoxin_cooldown = FALSE
	var/neurotoxin_cooldown_time = 5 SECONDS

/obj/item/organ/internal/alien/resinspinner
	name = "alien resin organ"//...there tiger.... //Chief what the fuck does this mean -GDN.
	parent_organ = "mouth"
	icon_state = "liver-x"
	slot = "spinner"
	origin_tech = "biotech=5;materials=4"
	alien_powers = list(/obj/effect/proc_holder/spell/alien/resin_build)

/obj/item/organ/internal/alien/eggsac
	name = "alien egg sac"
	icon_state = "eggsac"
	parent_organ = "groin"
	slot = "eggsac"
	w_class = WEIGHT_CLASS_BULKY
	origin_tech = "biotech=6"
	alien_powers = list(/obj/effect/proc_holder/spell/alien/queen/lay_egg)
