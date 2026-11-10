#define DIRECTION_KEY_NORTH "W"
#define DIRECTION_KEY_EAST "D"
#define DIRECTION_KEY_SOUTH "S"
#define DIRECTION_KEY_WEST "A"

#define MOVEMENT_KEY_SPRINT "SHIFT"

/client/
    var/list/keys_held = list()
    var/list/directions = list(NORTH, EAST, SOUTH, WEST)

    var/sprinting = FALSE

    New()
        ..()
        winset(src, "input", "focus=false")

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

        print("[usr] states, \"[msg]\"")

    verb/admintools()
        set hidden = TRUE
        set name = ".admintools"
        set instant = TRUE