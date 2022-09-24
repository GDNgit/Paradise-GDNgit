/mob/living/simple_animal/hostile/xenomorph
	name = "xenomorph hunter"
	desc = "Hiss!"
	icon = 'icons/mob/xenomorph.dmi'
	icon_state = "xenomorphh_running"
	icon_living = "xenomorphh_running"
	icon_dead = "xenomorphh_dead"
	icon_gib = "syndicate_gib"
	gender = FEMALE
	response_help = "pokes"
	response_disarm = "shoves"
	response_harm = "hits"
	speed = 0
	butcher_results = list(/obj/item/reagent_containers/food/snacks/monstermeat/xenomeat= 3, /obj/item/stack/sheet/animalhide/xeno = 1)
	maxHealth = 125
	health = 125
	harm_intent_damage = 5
	obj_damage = 60
	melee_damage_lower = 25
	melee_damage_upper = 25
	attacktext = "slashes"
	speak_emote = list("hisses")
	bubble_icon = "xenomorph"
	a_intent = INTENT_HARM
	attack_sound = 'sound/weapons/bladeslice.ogg'
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	heat_damage_per_tick = 20
	faction = list("xenomorph")
	status_flags = CANPUSH
	minbodytemp = 0
	see_in_dark = 8
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	gold_core_spawnable = NO_SPAWN
	death_sound = 'sound/voice/hiss6.ogg'
	deathmessage = "lets out a waning guttural screech, green blood bubbling from its maw..."
	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/hostile/xenomorph/xenobio
	maxHealth = 60
	health = 60
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/xenomorph/drone
	name = "xenomorph drone"
	icon_state = "xenomorphd_running"
	icon_living = "xenomorphd_running"
	icon_dead = "xenomorphd_dead"
	melee_damage_lower = 15
	melee_damage_upper = 15
	var/plant_cooldown = 30
	var/plants_off = 0

/mob/living/simple_animal/hostile/xenomorph/drone/xenobio
	maxHealth = 60
	health = 60
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/xenomorph/drone/handle_automated_action()
	if(!..()) //AIStatus is off
		return
	plant_cooldown--
	if(AIStatus == AI_IDLE)
		if(!plants_off && prob(10) && plant_cooldown<=0)
			plant_cooldown = initial(plant_cooldown)
			SpreadPlants()

/mob/living/simple_animal/hostile/xenomorph/sentinel
	name = "xenomorph sentinel"
	icon_state = "xenomorphs_running"
	icon_living = "xenomorphs_running"
	icon_dead = "xenomorphs_dead"
	health = 150
	maxHealth = 150
	melee_damage_lower = 15
	melee_damage_upper = 15
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5
	projectiletype = /obj/item/projectile/neurotox
	projectilesound = 'sound/weapons/pierce.ogg'


/mob/living/simple_animal/hostile/xenomorph/sentinel/xenobio
	health = 75
	maxHealth = 75
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/xenomorph/queen
	name = "xenomorph queen"
	icon_state = "xenomorphq_running"
	icon_living = "xenomorphq_running"
	icon_dead = "xenomorphq_dead"
	health = 250
	maxHealth = 250
	melee_damage_lower = 15
	melee_damage_upper = 15
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5
	move_to_delay = 4
	butcher_results = list(/obj/item/reagent_containers/food/snacks/monstermeat/xenomeat= 4, /obj/item/stack/sheet/animalhide/xeno = 1)
	projectiletype = /obj/item/projectile/neurotox
	projectilesound = 'sound/weapons/pierce.ogg'
	status_flags = 0
	var/sterile = 1
	var/plants_off = 0
	var/egg_cooldown = 30
	var/plant_cooldown = 30

/mob/living/simple_animal/hostile/xenomorph/queen/xenobio
	health = 100
	maxHealth = 100
	gold_core_spawnable = HOSTILE_SPAWN

/mob/living/simple_animal/hostile/xenomorph/queen/handle_automated_action()
	if(!..())
		return
	egg_cooldown--
	plant_cooldown--
	if(AIStatus == AI_IDLE)
		if(!plants_off && prob(10) && plant_cooldown<=0)
			plant_cooldown = initial(plant_cooldown)
			SpreadPlants()
		if(!sterile && prob(10) && egg_cooldown<=0)
			egg_cooldown = initial(egg_cooldown)
			LayEggs()

/mob/living/simple_animal/hostile/xenomorph/proc/SpreadPlants()
	if(!isturf(loc) || isspaceturf(loc))
		return
	if(locate(/obj/structure/xenomorph/weeds/node) in get_turf(src))
		return
	visible_message("<span class='alertxenomorph'>[src] has planted some xenomorph weeds!</span>")
	new /obj/structure/xenomorph/weeds/node(loc)

/mob/living/simple_animal/hostile/xenomorph/proc/LayEggs()
	if(!isturf(loc) || isspaceturf(loc))
		return
	if(locate(/obj/structure/xenomorph/egg) in get_turf(src))
		return
	visible_message("<span class='alertxenomorph'>[src] has laid an egg!</span>")
	new /obj/structure/xenomorph/egg(loc)

/mob/living/simple_animal/hostile/xenomorph/queen/large
	name = "xenomorph empress"
	icon = 'icons/mob/xenomorphlarge.dmi'
	icon_state = "queen_s"
	icon_living = "queen_s"
	icon_dead = "queen_dead"
	bubble_icon = "xenomorphroyal"
	move_to_delay = 4
	maxHealth = 400
	health = 400
	butcher_results = list(/obj/item/reagent_containers/food/snacks/monstermeat/xenomeat= 10, /obj/item/stack/sheet/animalhide/xeno = 2)
	mob_size = MOB_SIZE_LARGE

/obj/item/projectile/neurotox
	name = "neurotoxin"
	damage = 30
	icon_state = "toxin"

/mob/living/simple_animal/hostile/xenomorph/maid
	name = "lusty xenomorph maid"
	melee_damage_lower = 0
	melee_damage_upper = 0
	a_intent = INTENT_HELP
	friendly = "caresses"
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	gold_core_spawnable = HOSTILE_SPAWN
	icon_state = "maid"
	icon_living = "maid"
	icon_dead = "maid_dead"

/mob/living/simple_animal/hostile/xenomorph/maid/AttackingTarget()
	if(ismovable(target))
		if(istype(target, /obj/effect/decal/cleanable))
			visible_message("<span class='notice'>\The [src] cleans up \the [target].</span>")
			qdel(target)
			return TRUE
		var/atom/movable/M = target
		M.clean_blood()
		visible_message("<span class='notice'>\The [src] polishes \the [target].</span>")
		return TRUE
