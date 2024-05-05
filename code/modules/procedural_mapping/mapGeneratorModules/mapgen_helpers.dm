//Helper Modules


// Helper to repressurize the area in case it was run in space
/datum/mapGeneratorModule/bottomLayer/repressurize
	spawnableAtoms = list()
	spawnableTurfs = list()

/datum/mapGeneratorModule/bottomLayer/repressurize/generate()
	SSair.synchronize(CALLBACK(src, TYPE_PROC_REF(/datum/mapGeneratorModule/bottomLayer/repressurize, generate_sync)))

/datum/mapGeneratorModule/bottomLayer/repressurize/proc/generate_sync()
	// Any proc that wants MILLA to be synchronous should not sleep.
	SHOULD_NOT_SLEEP(TRUE)

	if(!mother)
		return
	var/list/map = mother.map
	for(var/turf/simulated/T in map)
		var/datum/gas_mixture/air = T.get_air()
		air.set_oxygen(T.oxygen)
		air.set_nitrogen(T.nitrogen)
		air.set_carbon_dioxide(T.carbon_dioxide)
		air.set_toxins(T.toxins)
		air.set_sleeping_agent(T.sleeping_agent)
		air.set_agent_b(T.agent_b)
		air.set_temperature(T.temperature)

//Only places atoms/turfs on area borders
/datum/mapGeneratorModule/border
	clusterCheckFlags = MAP_GENERATOR_CLUSTER_CHECK_NONE

/datum/mapGeneratorModule/border/generate()
	if(!mother)
		return
	var/list/map = mother.map
	for(var/turf/T in map)
		if(is_border(T))
			place(T)

/datum/mapGeneratorModule/border/proc/is_border(turf/T)
	for(var/direction in list(SOUTH,EAST,WEST,NORTH))
		if(get_step(T,direction) in mother.map)
			continue
		return 1
	return 0
