/client/
    var/list/keys_held = list()
    var/list/directions = list(NORTH, EAST, SOUTH, WEST)

    New()
        ..()
        winset(src, "input", "focus=false")
        winset(src, "mappane.map1", "focus=true")

    verb/keydown(key as text)
        set hidden = TRUE
        set instant = TRUE

        key = uppertext(key)

        if(key in keys_held)
            return
        
        keys_held.Add(key)
        
    
    verb/keyup(key as text)
        set hidden = TRUE
        set instant = TRUE

        key = uppertext(key)

        if(key in keys_held)
            keys_held.Remove(key)

    
    verb/say(msg as text)
        world.boutput("[usr] states, \"[msg]\"")

    verb/ooc(msg as text)
        set instant = TRUE

        world.boutput("[usr] (OOC): [msg]")

    verb/admintools()
        set hidden = TRUE
        set instant = TRUE

        if(src.permissions_level < 1)
            coutput(src, "Only administrators can use that command!")
            return
        
        coutput(src, "Permission granted to user [src.ckey]")