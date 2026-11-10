#define MOB_MAX_STAMINA 200
#define MOB_START_STAMINA 0

mob
    icon = 'icons/mob/player.dmi'

    var/current_stamina = MOB_START_STAMINA;
    var/max_stamina = MOB_MAX_STAMINA
    
    Login()
        src.loc = locate(/turf/start)
        ..()