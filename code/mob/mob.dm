#define MOB_MAX_STAMINA 200
#define MOB_START_STAMINA 0

#define PLAYER_ICON_STATE_SOUTH "south"
#define PLAYER_ICON_STATE_NORTH "north"
#define PLAYER_ICON_STATE_EAST "east"
#define PLAYER_ICON_STATE_WEST "west"

mob
    icon = 'icons/mob/player.dmi'
    icon_state = PLAYER_ICON_STATE_SOUTH // initialize facing south

    var/current_stamina = MOB_START_STAMINA;
    var/max_stamina = MOB_MAX_STAMINA
    
    Login()
        src.loc = locate(/turf/start)
        src.client.check_permissions_level(src.client)
        
        ..()