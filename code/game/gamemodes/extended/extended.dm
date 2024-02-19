/datum/game_mode/extended
	name = "extended"
	config_tag = "extended"
	required_players = 0
	single_antag_positions = list()

/datum/game_mode/announce()
	to_chat(world, "<B>The current game mode is - Extended Role-Playing!</B>")
	to_chat(world, "<B>Just have fun and role-play!</B>")

/datum/game_mode/extended/pre_setup()
	return TRUE

/datum/game_mode/extended/post_setup()
	..()
