/client/
    var/list/keys_held = list()
    var/list/directions = list(NORTH, EAST, SOUTH, WEST)

    var/sprinting = FALSE

    New()
        ..()
        winset(src, "input", "focus=false")
        winset(src, "mappane.map1", "focus=true")

    verb/keydown(key as text)
        set hidden = TRUE
        set name = ".keydown"
        set instant = TRUE

        key = uppertext(key)

        if(key in keys_held)
            return
        
        keys_held.Add(key)
        
    
    verb/keyup(key as text)
        set hidden = TRUE
        set name = ".keyup"
        set instant = TRUE

        key = uppertext(key)

        if(key in keys_held)
            keys_held.Remove(key)

    
    verb/say(msg as text)
        set name = ".say"

        world.boutput("[usr] states, \"[msg]\"")

    verb/ooc(msg as text)
        set name = ".ooc"
        set instant = TRUE

        world.boutput("[usr] (OOC): [msg]")

    verb/admintools()
        set hidden = TRUE
        set name = ".admintools"
        set instant = TRUE