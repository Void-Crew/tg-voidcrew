//Computer

/obj/item/circuitboard/computer/cloning/prototype
	name = "Prototype Cloning"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/cloning/prototype

/obj/item/circuitboard/computer/cloning
	name = "Cloning"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/computer/cloning
	var/list/records = list()

//Machinery

/obj/item/circuitboard/machine/clonepod
	name = "clone pod"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/clonepod
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/reagent_containers/cup/beaker = 2)

/obj/item/circuitboard/machine/clonepod/experimental
	name = "experimental clone pod"
	build_path = /obj/machinery/clonepod/experimental

/obj/item/circuitboard/machine/clonescanner
	name = "cloning scanner"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/dna_scannernew
	req_components = list(
		/obj/item/stock_parts/scanning_module = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/cable_coil = 2)


