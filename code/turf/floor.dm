/turf/floor
    icon = 'icons/turf/floor/floor.dmi'
    
    var/floor_type = "metal" // string value for now, will figure out DMs weird, fucked up namespaces later

/turf/floor/grass
    icon = 'icons/turf/floor/floor_grass.dmi'

    floor_type = "grass"

/turf/floor/detail/skull
    icon = 'icons/turf/floor/detail/detail_skull.dmi'

    floor_type = "under" // for now, this just means take the sound of whatever is under it. no idea if this is a good implementation. we'll find out, i suppose.