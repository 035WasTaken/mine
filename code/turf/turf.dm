#define DOOR_CLOSE_TICK_DELAY 60

/turf
    start
        icon = 'icons/turf/floor/detail/detail_skull.dmi'
    
    
    door
        icon = 'icons/turf/door.dmi'
        icon_state = "closed"
        density = 1 // doors are INITIALLY unwalkable

        var/delay_to_close = DOOR_CLOSE_TICK_DELAY
        var/closes_automatically = TRUE
        var/closed = TRUE

        proc/open(opener as mob)
            src.icon_state = "open"
            src.density = 0
            src.closed = FALSE

            if(src.closes_automatically)
                spawn(delay_to_close) close() // we want to close it automatically after some delay
        
        proc/close(closer as mob)
            src.icon_state = "closed"
            src.density = 1
            src.closed = TRUE