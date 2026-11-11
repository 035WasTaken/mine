client/

    var/permissions_level = 0 // 0 is default. no extra permissions besides playing the game.

    proc/check_permissions_level(var/client/C)
        src.permissions_level = 0

        var/list/lines = splittext(file2text(ADMINISTRATORS_LIST), "\n")

        for(var/line in lines)
            line = trimtext(line)
            if(!line)
                continue

            var/list/parts = splittext(line, " - ")
            if(parts.len < 2)
                continue

            var/name = ckey(trimtext(parts[1]))
            var/role = lowertext(trimtext(parts[2]))

            if(name == ckey(C.key))
                if(role == "head developer")
                    src.permissions_level = PERMISSIONS_HEAD_DEVELOPER
                return