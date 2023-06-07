
/obj/effect/landmark/tram/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	specific_lift_id = "[port.shuttle_id]_[specific_lift_id]"

/*
/obj/effect/landmark/lift_id/Initialize()
	var/area/shuttle/voidcrew/landmark_area = get_area(src)
	if(landmark_area.shuttle_port)
		specific_lift_id = "[landmark_area.shuttle_port.shuttle_id]_[specific_lift_id]"
	return ..()
/obj/effect/landmark/lift_id/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	specific_lift_id = "[port.shuttle_id]_[specific_lift_id]"
*/

