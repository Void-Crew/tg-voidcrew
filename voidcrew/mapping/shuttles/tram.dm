/datum/map_template/shuttle/voidcrew/tram
	name = "Advanced Freight Vessel"
	suffix = "tram"
	short_name = "Advanced Freight Vessel"
	part_cost = 3

	job_slots = list(
		list(
			name = "Captain",
			officer = TRUE,
			outfit = /datum/outfit/job/captain,
			slots = 1,
		),
		list(
			name = "Quartermaster",
			outfit = /datum/outfit/job/quartermaster,
			slots = 1,
		),
		list(
			name = "Medical Doctor",
			outfit = /datum/outfit/job/doctor,
			slots = 1,
		),
		list(
			name = "Station Engineer",
			outfit = /datum/outfit/job/engineer,
			slots = 1,
		),
		list(
			name = "Shaft Miner",
			outfit = /datum/outfit/job/miner,
			slots = 2,
		),
		list(
			name = "Assistant",
			outfit = /datum/outfit/job/assistant,
			slots = 3,
		),
	)

/// DOCKING PORT ///

/obj/docking_port/mobile/voidcrew/tram
	name = "Advanced Freight Vessel"
	area_type = /area/shuttle/voidcrew/tram
	port_direction = 8
	preferred_direction = 4

/// AREAS ///

/// Command ///

/area/shuttle/voidcrew/tram/bridge
	name = "Bridge"
	icon_state = "bridge"

/// Engineering ///
/area/shuttle/voidcrew/tram/engineering
	name = "Engineering"
	icon_state = "engine"

/area/shuttle/voidcrew/tram/atmos
	name = "Life Support"
	icon_state = "atmos"

/// Medbay ///

/area/shuttle/voidcrew/tram/medbay
	name = "Medbay"
	icon_state = "medbay"

/// Cargo ///

/area/shuttle/voidcrew/tram/cargo
	name = "Cargo Bay"
	icon_state = "cargo_bay"

/area/shuttle/voidcrew/tram/loading
	name = "Exterior Loading Bay"
	icon_state = "cargo_bay"

/// Service ///

/area/shuttle/voidcrew/tram/dorms
	name = "Dormitories"
	icon_state = "dorms"

/area/shuttle/voidcrew/tram/cafe
	name = "Cafeteria"
	icon_state = "cafeteria"

/// Hallways ///

/area/shuttle/voidcrew/tram/hallway/tram
	name = "Tram Shaft"
	icon_state = "centralhall"

/area/shuttle/voidcrew/tram/hallway/port
	name = "Port Hallway"
	icon_state = "centralhall"

/area/shuttle/voidcrew/tram/hallway/starboard
	name = "Starboard Hallway"
	icon_state = "centralhall"

/area/shuttle/voidcrew/tram/airlock/port
	name = "Port Airlock"
	icon_state = "porthall"

/area/shuttle/voidcrew/tram/airlock/starboard
	name = "Starboard Airlock"
	icon_state = "starboardmaint"
