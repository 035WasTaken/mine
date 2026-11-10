world/
    Tick()
        ..()
        for(var/mob/M)
            if(!M.client) // if the mob isn't a connected player we probably don't need to process their movement
                continue

            M.process_movement()