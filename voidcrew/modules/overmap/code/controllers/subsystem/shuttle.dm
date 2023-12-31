/datum/controller/subsystem/shuttle/proc/create_ship(datum/map_template/shuttle/voidcrew/ship_template_to_spawn)
	RETURN_TYPE(/obj/structure/overmap/ship)

	UNTIL(!shuttle_loading)
	shuttle_loading = TRUE
	var/obj/structure/overmap/ship/ship_to_spawn = new(SSovermap.get_unused_overmap_square(tries = INFINITY), new ship_template_to_spawn)
	if(!ship_to_spawn)
		stack_trace("Unable to properly load ship [ship_template_to_spawn].")
		shuttle_loading = FALSE
		return FALSE

	SSair.can_fire = FALSE // fuck you
	var/obj/docking_port/mobile/voidcrew/loaded = action_load(ship_to_spawn.source_template)
	SSair.can_fire = TRUE
	shuttle_loading = FALSE

	if(!loaded)
		stack_trace("Unable to properly load ship template [ship_to_spawn.source_template].")
		qdel(ship_to_spawn)
		return FALSE

	loaded.current_ship = ship_to_spawn
	ship_to_spawn.name = loaded.name
	ship_to_spawn.shuttle = loaded

	SEND_SIGNAL(loaded, COMSIG_VOIDCREW_SHIP_LOADED)

	ship_to_spawn.calculate_mass()
	// assign landmarks as needed
	var/turf/safe_turf = get_safe_random_station_turf(loaded.shuttle_areas)
	new /obj/effect/landmark/blobstart(safe_turf) // Stationloving component
	new /obj/effect/landmark/observer_start(safe_turf) // Observer and Unit tests

	return ship_to_spawn

/client/add_admin_verbs()
	. = ..()
	add_verb(src, list(
		/client/proc/respawn_ship,
		/client/proc/spawn_specific_ship,
		/client/proc/initiate_jump,
		/client/proc/cancel_jump,
		/client/proc/team_panel,
		/client/proc/togglepurchasing,
		/client/proc/manage_ships
	))

/client/remove_admin_verbs()
	. = ..()
	remove_verb(src, list(
		/client/proc/respawn_ship,
		/client/proc/spawn_specific_ship,
		/client/proc/initiate_jump,
		/client/proc/cancel_jump,
		/client/proc/team_panel,
		/client/proc/togglepurchasing,
		/client/proc/manage_ships
	))

#define RESPAWN_FORCE "Force Respawn"
/client/proc/respawn_ship()
	set name = "Respawn Initial Ship"
	set category = "Overmap.Ships"
	if(SSovermap.initial_ship)
		var/resp = tgui_alert(usr, "Initial ship already exists. This can delete players and their progress", "Shits Fucked", list(RESPAWN_FORCE, "Cancel"))
		if(resp != RESPAWN_FORCE)
			return
		qdel(SSovermap.initial_ship)
	SSovermap.spawn_initial_ship()
#undef RESPAWN_FORCE

/client/proc/spawn_specific_ship()
	set name = "Spawn Specific Ship"
	set category = "Overmap.Ships"
	var/static/list/choices
	if(!choices)
		choices = list()
		for(var/ship in subtypesof(/datum/map_template/shuttle/voidcrew))
			var/datum/map_template/shuttle/voidcrew/V = ship
			choices[initial(V.name)] = V
	var/ship_to_spawn = tgui_input_list(usr, "Which ship do you want to spawn?", "Spawn Specific Ship", choices)
	if(!ship_to_spawn)
		return

	var/obj/structure/overmap/ship/spawned = SSshuttle.create_ship(choices[ship_to_spawn])
	mob.client?.admin_follow(spawned.shuttle)

/client/proc/spawn_specific_planet()
	var/static/list/choices
	if(!choices)
		choices = list()
		for(var/planet in subtypesof(/obj/structure/overmap/planet))
			var/obj/structure/overmap/planet/V = planet
			choices[initial(V.name)] = V
	var/planet_to_spawn = tgui_input_list(usr, "Which planet do you want to spawn?", "Spawn Specific Planet", choices)
	if(!planet_to_spawn)
		return
	var/final_planet = choices[planet_to_spawn]
	new final_planet(SSovermap.get_unused_overmap_square())

/client/proc/initiate_jump()
	set name = "Initiate Jump"
	set category = "Overmap.Jump"
	if(!check_rights(R_ADMIN))
		return

	var/confirm = tgui_alert(src, "Are you sure you want to initiate a bluespace jump?", "Bluespace Jump", list("Yes", "No"))
	if(confirm != "Yes")
		return

	if(SSovermap.jump_mode > BS_JUMP_IDLE)
		return

	SSovermap.request_jump()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Call Shuttle") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(usr)] admin-initiated a bluespace jump.")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] admin-initiated a bluespace jump.</span>")

/client/proc/cancel_jump()
	set name = "Cancel Jump"
	set category = "Overmap.Jump"
	if(!check_rights(0))
		return

	var/confirm = tgui_alert(src, "Are you sure you want to cancel the bluespace jump?", "Bluespace Jump", list("Yes", "No"))
	if(confirm != "Yes")
		return

	if(SSovermap.jump_mode != BS_JUMP_CALLED)
		return

	SSovermap.cancel_jump()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Cancel Shuttle") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(usr)] admin-cancelled a bluespace jump.")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] admin-cancelled a bluespace jump.</span>")

/client/proc/team_panel()
	set name = "Team Panel"
	set category = "Overmap.Team"
	if(!check_rights(R_ADMIN))
		return
	src.holder.check_teams()


/client/proc/togglepurchasing()
	set category = "Overmap.Ships"
	set desc="People can't purchase ships"
	set name="Toggle Ship Purchasing"
	GLOB.ship_buying = !( GLOB.ship_buying )
	if (!( GLOB.ship_buying ))
		to_chat(world, "<B>New players may no longer purchase new ships.</B>", confidential = TRUE)
	else
		to_chat(world, "<B>New players may now purchase new ships.</B>", confidential = TRUE)
	log_admin("[key_name(usr)] toggled ship purchasing.")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] toggled ship purchasing.</span>")
	world.update_status()
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Ship Purchasing", "[GLOB.ship_buying ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/manage_ships()
	set category = "Overmap.Ships"
	set desc="Ship Management Console"
	set name="Ship/Planet Management"
	if(!check_rights(R_ADMIN))
		return
	new /datum/ship_management(usr)//create the datum

/datum/ship_management
	var/client/holder //client of whoever is using this datum

/datum/ship_management/New(user) //user can either be a client or a mob
	if (istype(user,/client))
		var/client/user_client = user
		holder = user_client //if its a client, assign it to holder
	else
		var/mob/user_mob = user
		holder = user_mob.client //if its a mob, assign the mob's client to holder
	ui_interact(holder.mob)

/datum/ship_management/ui_state(mob/user)
	return GLOB.admin_state

/datum/ship_management/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		// Open UI
		ui = new(user, src, "VoidcrewManagement")
		ui.open()

/datum/ship_management/ui_data(mob/user)
	var/list/data = list()
	data["ships"] = list()
	for(var/i in SSovermap.simulated_ships)
		var/obj/structure/overmap/ship/M = i
		var/list/L = list()
		L["name"] = M.name
		L["id"] = M.shuttle.shuttle_id
		L["ref"] = REF(M)
		L["short_name"] = M.source_template.short_name
		L["status"] = M.state
		L["docked"] = M.docked
		L["locked"] = M.helm_locked
		data["ships"] += list(L)
	data["planets"] = list()
	for(var/i in SSovermap.dynamic_objects)
		var/obj/structure/overmap/planet/M = i
		var/list/L = list()
		L["name"] = M.name
		L["ref"] = REF(M)
		L["loaded"] = FALSE
		L["preserved"] = M.preserve_level
		if(M.mapzone)
			L["loaded"] = TRUE
		data["planets"] += list(L)
	return data

/datum/ship_management/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/mob/user = usr
	var/obj/docking_port/mobile/mobile_dock
	var/obj/structure/overmap/planet/planet
	var/obj/structure/overmap/ship/ship
	if(params["id"])
		for(var/i in SSshuttle.mobile_docking_ports)
			mobile_dock = i
			if(mobile_dock.shuttle_id == params["id"])
				break
	if(params["ref"])
		var/located = locate(params["ref"])
		if(istype(located, /obj/structure/overmap/ship))
			ship = located
		if(istype(located, /obj/structure/overmap/planet))
			planet = located

	switch(action)
		if("jump_to")
			if(params["type"] == "mobile")
				user.forceMove(get_turf(mobile_dock))
				return TRUE
			else
				if(planet.reserve_dock)
					user.forceMove(get_turf(planet.reserve_dock))
					return TRUE
				else
					user.forceMove(planet.loc)
					return TRUE
		if("spawn")
			if(params["type"] == "ship")
				user.client.spawn_specific_ship()
			if(params["type"] == "planet")
				user.client.spawn_specific_planet()
		if("toggle_ship_purchases")
			user.client.togglepurchasing()
		if("recalc")
			mobile_dock.recalculate_bounds()
		if("load_unload")
			if(!planet.mapzone)
				planet.load_level()
			else
				if(!planet.unload_level())
					if(tgui_alert(usr, "A ship or alive mobs have been detected, do you want to force an unload?","LIFESIGNS DETECTED", list("Yes", "No")) == "Yes")
						planet.unload_level(TRUE)
		if("preserve")
			planet.preserve_level = !planet.preserve_level
		if("dock")
			if(!ship.docked)
				var/available_overmap_planets = list()
				for(var/obj/structure/overmap/planet/planets as anything in SSovermap.dynamic_objects)
					available_overmap_planets["[planets.name] X:[planets.x] Y:[planets.y]"] = planets
				var/obj/structure/overmap/planet/option = available_overmap_planets[tgui_input_list(usr, "Select dock type", "Dock Type Selection", available_overmap_planets)]
				if(!option)
					return
				option.ship_act(usr, ship)
			else
				ship.undock()
		if("vv")
			if(ship)
				user.client.debug_variables(ship)
			if(planet)
				user.client.debug_variables(planet)
		if("lock")
			ship.helm_locked = !ship.helm_locked
		if("control")
			if(ship.helms[1])
				var/obj/machinery/computer/helm/helm_console = ship.helms[1]
				helm_console.ui_interact(usr)










