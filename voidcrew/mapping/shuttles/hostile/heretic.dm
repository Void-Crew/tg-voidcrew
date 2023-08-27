/datum/map_template/shuttle/voidcrew/heretic
	name = "Valor-class Hijacked Vessel"
	suffix = "hostile_heretic"
	short_name = "Valor-Class"
	faction_prefix = HOSTILE_SHIP
	part_cost = 5

	enabled = FALSE
	antag_datum = /datum/antagonist/heretic

	job_slots = list(
		list(
			name = "Heretic Leader",
			officer = TRUE,
			outfit = /datum/outfit/job/captain/western,
			slots = 1,
		),
		list(
			name = "Heretic",
			outfit = /datum/outfit/job/assistant,
			slots = 8,
		),
	)

/// DOCKING PORT ///

/obj/docking_port/mobile/voidcrew/heretic
	name = "Valor-class Hijacked Vessel"
	area_type = /area/shuttle/voidcrew/heretic
	port_direction = 8
	preferred_direction = 4


/// AREAS ///

/// Command ///

/area/shuttle/voidcrew/heretic/bridge
	name = "Bridge"
	icon_state = "bridge"

/// Security ///

/area/shuttle/voidcrew/heretic/equipment
	name = "Equipment Room"
	icon_state = "station"

/// Medbay ///

/area/shuttle/voidcrew/heretic/medbay
	name = "Medbay"
	icon_state = "medbay"


/// Chemistry ///
/area/shuttle/voidcrew/heretic/medbay/chemistry
	name = "Bioweapons Research"
	icon_state = "chem"

/// Engineering ///

/area/shuttle/voidcrew/heretic/engineering
	name = "Engineering"
	icon_state = "engine"

/area/shuttle/voidcrew/heretic/kitchen
	name = "Kitchen"
	icon_state = "kitchen"

/area/shuttle/voidcrew/heretic/hydroponics
	name = "Hydroponics"
	icon_state = "hydro"

/area/shuttle/voidcrew/heretic/dorms
	name = "Dormitories"
	icon_state = "dorms"

/area/shuttle/voidcrew/heretic/armory
	name = "Operations Center"
	icon_state = "armory"

/area/shuttle/voidcrew/heretic/eva
	name = "EVA Storage"
	icon_state = "eva"
