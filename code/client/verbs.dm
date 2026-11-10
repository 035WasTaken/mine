/client/
    var/character_name = ""

    verb/ooc(msg as text)
        coutput(src, "[usr] (OOC): \"[msg]\"")
    
    verb/set_character_name(name as text) // this should really turn into a customization menu option asap
        character_name = name

    verb/logout()
        var/confirmed = input(usr, "Are you sure you want to logout?") in list("yes", "no")

        if(confirmed)
            src.mob.Logout()
        else
            return