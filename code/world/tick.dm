world/

    Tick()
        ..()
        for(var/client/C)
            var/mob/M = C.mob

            if(M)
                M.process_movement()
    
    /// Broadcast output to the world
    proc/boutput(msg as text)
        world << msg
        world.log << msg