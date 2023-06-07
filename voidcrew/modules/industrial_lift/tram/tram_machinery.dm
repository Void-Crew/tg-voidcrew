/obj/machinery/computer/tram_controls/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	var/new_id = "[port.shuttle_id]_[specific_lift_id]"
	GLOB.tram_landmarks[new_id] = GLOB.tram_landmarks[specific_lift_id]
	GLOB.tram_landmarks.Remove(specific_lift_id)
	specific_lift_id = new_id
	find_tram()



/obj/machinery/button/tram/connect_to_shuttle(mapload, obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	lift_id = "[port.shuttle_id]_[lift_id]"
	. = ..()

