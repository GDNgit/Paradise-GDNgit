/datum/alien_cast
	/// we need this for blackbox logging or somethin.
	var/name = "you shouldn't be seeing this"
	/// A list of alien powers the alien gains based on evolution (Yes, not all of them are tied to organs...)
	var/list/alien_powers
//TODO
/datum/alien_cast/proc/add_subclass_ability(datum/antagonist/vampire/vamp)
	for(var/thing in standard_powers)
		if(vamp.bloodtotal >= standard_powers[thing])
			vamp.add_ability(thing)

/datum/vampire_subclass/proc/add_full_power_abilities(datum/antagonist/vampire/vamp)
	for(var/thing in fully_powered_abilities)
		vamp.add_ability(thing)

/datum/vampire_subclass/umbrae
	name = "umbrae"
	standard_powers = list(/obj/effect/proc_holder/spell/vampire/self/cloak = 150,
							/obj/effect/proc_holder/spell/vampire/shadow_snare = 250,
							/obj/effect/proc_holder/spell/vampire/dark_passage = 400,
							/obj/effect/proc_holder/spell/vampire/vamp_extinguish = 600)
	fully_powered_abilities = list(/datum/vampire_passive/full,
								/obj/effect/proc_holder/spell/vampire/self/eternal_darkness,
								/datum/vampire_passive/xray)

/datum/vampire_subclass/hemomancer
	name = "hemomancer"
	standard_powers = list(/obj/effect/proc_holder/spell/vampire/self/vamp_claws = 150,
							/obj/effect/proc_holder/spell/vampire/blood_tendrils = 250,
							/obj/effect/proc_holder/spell/ethereal_jaunt/blood_pool = 400,
							/obj/effect/proc_holder/spell/vampire/blood_eruption = 600)
	fully_powered_abilities = list(/datum/vampire_passive/full,
								/obj/effect/proc_holder/spell/vampire/self/blood_spill)

/datum/vampire_subclass/gargantua
	name = "gargantua"
	standard_powers = list(/obj/effect/proc_holder/spell/vampire/self/blood_swell = 150,
							/obj/effect/proc_holder/spell/vampire/self/blood_rush = 250,
							/datum/vampire_passive/blood_swell_upgrade = 400,
							/obj/effect/proc_holder/spell/vampire/self/overwhelming_force = 600)
	fully_powered_abilities = list(/datum/vampire_passive/full,
								/obj/effect/proc_holder/spell/vampire/charge)
	improved_rejuv_healing = TRUE

/datum/vampire_subclass/dantalion
	name = "dantalion"
	standard_powers = list(/obj/effect/proc_holder/spell/vampire/enthrall = 150,
							/obj/effect/proc_holder/spell/vampire/thrall_commune = 150,
							/obj/effect/proc_holder/spell/vampire/pacify = 250,
							/obj/effect/proc_holder/spell/vampire/self/decoy = 400,
							/datum/vampire_passive/increment_thrall_cap = 400,
							/obj/effect/proc_holder/spell/vampire/rally_thralls = 600,
							/datum/vampire_passive/increment_thrall_cap/two = 600)
	fully_powered_abilities = list(/datum/vampire_passive/full,
								/obj/effect/proc_holder/spell/vampire/hysteria,
								/datum/vampire_passive/increment_thrall_cap/three)


/datum/vampire_subclass/ancient
	name = "ancient"
	standard_powers = list(/obj/effect/proc_holder/spell/vampire/self/vamp_claws,
							/obj/effect/proc_holder/spell/vampire/self/blood_swell,
							/obj/effect/proc_holder/spell/vampire/self/cloak,
							/obj/effect/proc_holder/spell/vampire/enthrall,
							/obj/effect/proc_holder/spell/vampire/thrall_commune,
							/obj/effect/proc_holder/spell/vampire/blood_tendrils,
							/obj/effect/proc_holder/spell/vampire/self/blood_rush,
							/obj/effect/proc_holder/spell/vampire/shadow_snare,
							/obj/effect/proc_holder/spell/vampire/pacify,
							/obj/effect/proc_holder/spell/ethereal_jaunt/blood_pool,
							/datum/vampire_passive/blood_swell_upgrade,
							/obj/effect/proc_holder/spell/vampire/dark_passage,
							/obj/effect/proc_holder/spell/vampire/self/decoy,
							/obj/effect/proc_holder/spell/vampire/blood_eruption,
							/obj/effect/proc_holder/spell/vampire/self/overwhelming_force,
							/obj/effect/proc_holder/spell/vampire/vamp_extinguish,
							/obj/effect/proc_holder/spell/vampire/rally_thralls,
							/datum/vampire_passive/full,
							/obj/effect/proc_holder/spell/vampire/self/blood_spill,
							/obj/effect/proc_holder/spell/vampire/charge,
							/obj/effect/proc_holder/spell/vampire/self/eternal_darkness,
							/obj/effect/proc_holder/spell/vampire/hysteria,
							/obj/effect/proc_holder/spell/vampire/raise_vampires,
							/datum/vampire_passive/xray)
	improved_rejuv_healing = TRUE
	thrall_cap = 150 // can thrall high pop
