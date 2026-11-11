world
	fps = 30
	icon_size = 16
	view = 6		

mob/step_size = 8

obj/step_size = 8

/// Output text to a specific client
proc/coutput(c, msg as text)
	c << output(msg, "mainwindow.output")

var/static/regex/whitespace_trim = regex(@"^\s+|\s+$", "g")