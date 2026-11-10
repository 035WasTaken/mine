/*
	These are simple defaults for your project.
 */

world
	fps = 30		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default
	view = 6		// show up to 6 tiles outward from center (13x13 view)

mob/step_size = 8

obj/step_size = 8

proc/print(msg as text)
	world << msg

/// Output text to a specific client
proc/coutput(c, msg as text)
	c << output(msg, "mainwindow.output")