/// Output text to a specific client
proc/coutput(c, msg as text) // maybe this would be better as a client proc?
	c << output(msg, "mainwindow.output")