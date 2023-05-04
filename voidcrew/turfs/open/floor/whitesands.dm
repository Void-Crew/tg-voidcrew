/turf/open/misc/asteroid/whitesands
	name = "salted sand"
	baseturfs = /turf/open/misc/asteroid/whitesands
	icon = 'voidcrew/icons/turf/floors/whitesands/ws_floors.dmi'
	icon_state = "sand"
	planetary_atmos = TRUE
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/// Drops itemstack when dug and changes icon

/turf/open/misc/asteroid/whitesands/dried
	name = "dried sand"
	baseturfs = /turf/open/misc/asteroid/whitesands/dried
	icon_state = "dried_up"

/turf/open/misc/asteroid/whitesands/remove_air(amount)
	return return_air()

/turf/open/floor/plating/grass/whitesands
