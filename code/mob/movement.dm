#define MOVEMENT_TICK_DELAY 3

mob/
    var/ticks_since_last_move = MOVEMENT_TICK_DELAY

    proc/process_movement()
        if(!src.client)
            return
        
        var/movement_direction = handle_wasd_movement(src.client.keys_held)
        src.ticks_since_last_move++

        if(!movement_direction)
            return

        if(src.ticks_since_last_move < MOVEMENT_TICK_DELAY)
            return

        var/newLoc = get_step(src, movement_direction) // this is a surprise tool that'll help us later
        
        if(try_slide_movement(movement_direction, newLoc))
            src.ticks_since_last_move = 0


    proc/try_slide_movement(mdir, newLoc)
        if(src.Move(newLoc, mdir))
            return TRUE
        
        var/northsouth = mdir & (NORTH | SOUTH) // check if NORTH or SOUTH are in our current movement direction
        var/eastwest = mdir & (EAST | WEST)  // same as above, but for EAST and WEST

        // we want to preserve movement direction when we're not moving orthogonally and into a wall. if we're traveling southeast and hit an east wall, we should keep heading south 
        if(northsouth && eastwest)
            if(src.Move(get_step(src, eastwest), eastwest))
                return TRUE

            if(src.Move(get_step(src, northsouth), northsouth))
                return TRUE
        
        // we don't reset our tick counter on a failure for uh... because i said so, ok?
        return FALSE
    
    proc/handle_wasd_movement(held_keys)
        var/dir = 0
        
        if(DIRECTION_KEY_NORTH in held_keys) dir |= NORTH
        if(DIRECTION_KEY_SOUTH in held_keys) dir |= SOUTH
        if(DIRECTION_KEY_EAST in held_keys) dir |= EAST
        if(DIRECTION_KEY_WEST in held_keys) dir |= WEST

        return dir