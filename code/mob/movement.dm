// TODO: im pretty sure this is all done sequentially, per mob.
// meaning in large servers, this code would start to stutter
// and lag all mobs over time. proooobably should fix that.

mob/
    var/ticks_since_last_move = MOVEMENT_TICK_DELAY
    var/ticks_since_last_walk = SOUND_WALK_TICK_DELAY

    var/is_crouching = FALSE
    var/is_sprinting = FALSE

    Bump(atom/A)
        ..()

        if(istype(A, /turf/door))
            var/turf/door/D = A
            if(D.closed)
                D.open()

    /// Handles all underlying player movement logic per tick. Any direct movement modifications should be added to helper procs, then applied here.
    proc/process_movement()
        if(!src.client)
            return
        
        var/movement_direction = handle_wasd_movement(src.client.keys_held)
        var/facing_direction = handle_facing_direction(src.client.keys_held)

        if(facing_direction) // we can use IJKL to make our player face different directions
            src.dir = facing_direction

        // saturated counters so we don't have to worry about eventual overflow
        src.ticks_since_last_move = src.ticks_since_last_move >= MOVEMENT_TICK_DELAY ? MOVEMENT_TICK_DELAY : src.ticks_since_last_move + 1
        src.ticks_since_last_walk = src.ticks_since_last_walk >= SOUND_WALK_TICK_DELAY ? SOUND_WALK_TICK_DELAY : src.ticks_since_last_walk + 1

        if(!movement_direction) // if they aren't moving why would we do anything
            return

        if(src.ticks_since_last_move < MOVEMENT_TICK_DELAY) // can't move if our tick counter hasn't saturated
            return

        var/new_loc = get_step(src, movement_direction) // this is a surprise tool that'll help us later
        
        if(!handle_move(movement_direction, new_loc)) // try to move. if we don't, exit out and run this next tick.
            return
        
        src.ticks_since_last_move = 0

        if(src.ticks_since_last_walk >= SOUND_WALK_TICK_DELAY)
            world.boutput("DEBUG: Trying to trigger sound") // let's move this to an actual logger at some point. it seems kinda reasonable at this rate.
            play_walk_sound(src, src.loc)
            src.ticks_since_last_walk = 0


    /// Handles normal player movement while allowing for sliding on walls
    proc/handle_move(mdir, new_loc)
        if(src.Move(new_loc, mdir))
            return TRUE
        
        var/northsouth = mdir & (NORTH | SOUTH) // check if NORTH or SOUTH are in our current movement direction
        var/eastwest = mdir & (EAST | WEST)  // same as above, but for EAST and WEST

        // we want to preserve movement direction when we're not moving orthogonally and into a wall. if we're traveling southeast and hit an east wall, we should keep heading south 
        if(northsouth && eastwest)
            if(src.Move(get_step(src, eastwest), eastwest))
                return TRUE

            if(src.Move(get_step(src, northsouth), northsouth))
                return TRUE
        
        // we don't reset our tick counter on a failure. this means failing to move won't force you to wait another MOVEMENT_TICK_DELAY ticks before you can. more responsive.
        return FALSE
    

    /// Returns the direction to move, based on what keys are being pressed
    proc/handle_wasd_movement(held_keys)
        var/dir = 0
        
        if(DIRECTION_KEY_NORTH in held_keys) dir |= NORTH
        if(DIRECTION_KEY_SOUTH in held_keys) dir |= SOUTH
        if(DIRECTION_KEY_EAST in held_keys) dir |= EAST
        if(DIRECTION_KEY_WEST in held_keys) dir |= WEST

        return dir

    /// Returns the new direction to face, based on what key is being pressed
    proc/handle_facing_direction(held_keys)
        var/dir = 0

        if(FACING_DIRECTION_KEY_NORTH in held_keys) dir |= NORTH
        if(FACING_DIRECTION_KEY_SOUTH in held_keys) dir |= SOUTH
        if(FACING_DIRECTION_KEY_EAST in held_keys) dir |= EAST
        if(FACING_DIRECTION_KEY_WEST in held_keys) dir |= WEST

        return dir
    
    /// Set player state in regards to crouching. Returns a boolean based on whether state was successfully updated.
    proc/do_crouch()
        if(src.is_crouching)
            return FALSE
        
        if(src.is_sprinting)
            src.is_sprinting = FALSE
        
        return src.is_crouching = TRUE
        
    /// Set player state in regards to sprinting. Returns a boolean based on whether state was successfully updated.
    proc/do_sprint()
        if(src.is_sprinting)
            return FALSE
        
        if(src.is_crouching)
            src.is_crouching = FALSE
        
        return src.is_sprinting = TRUE
    
    /// Unset player state in regards to crouching. Returns a boolean based on whether state was successfully updated.
    proc/stop_crouch()
        if(!src.is_crouching)
            return FALSE
        
        src.is_crouching = FALSE

        return TRUE

    /// Unset player state in regards to sprinting. Returns a boolean based on whether state was successfully updated.
    proc/stop_sprint()
        if(!src.is_sprinting)
            return FALSE
        
        src.is_sprinting = FALSE

        return TRUE
    
    /// Checks what turf to play sound on, and what sound to play. Then attempts to play that sound. Returns a boolean based on whether sound *should* be playing or not.
    proc/play_walk_sound(mob/M, turf/T)
        // we're going to do a really simple, nothingburger implementation first just to see if i can even get the sound to play
        T << sound(SOUND_WALK_GRASS_1, FALSE, TRUE, volume = 15)