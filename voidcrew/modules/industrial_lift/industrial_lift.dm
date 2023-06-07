/obj/structure/industrial_lift/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	lift_master_datum.specific_lift_id = "[port.shuttle_id]_[lift_master_datum.specific_lift_id]"


/obj/structure/industrial_lift/afterShuttleMove(turf/oldT, list/movement_force, shuttle_dir, shuttle_preferred_direction, move_dir, rotation)
	. = ..()
	set_movement_registrations()
