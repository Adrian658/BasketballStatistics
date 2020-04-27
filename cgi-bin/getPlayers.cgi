#! /usr/bin/awk -f
BEGIN {
        print "Content-type: text/html\n"
        print "<a href='../project2.html'>Go Back to Home Page</a>"
	
        split(ENVIRON["QUERY_STRING"], queries, /=/)
	team_len = split(queries[2], team_name, /+/)
	team_region = find_region(team_name[team_len])

	system("lynx -dump 'https://www.espn.com/nba/team/roster/_/name/" team_region "/" format_name(team_name, team_len)  "' | awk -f cleanRoster.awk")
}

function find_region(team_name) {
	team_map["Celtics"] = "bos"
	team_map["Nets"] = "bkn"
	team_map["Knicks"] = "ny"
	team_map["76ers"] = "phi"
	team_map["Raptors"] = "tor"
	team_map["Warriors"] = "gs"
	team_map["Clippers"] = "lac"
	team_map["Lakers"] = "lal"
	team_map["Suns"] = "phx"
	team_map["Kings"] = "sac"
	team_map["Bulls"] = "chi"
	team_map["Cavaliers"] = "cle"
	team_map["Pistons"] = "det"
	team_map["Pacers"] = "ind"
	team_map["Bucks"] = "mil"
	team_map["Hawks"] = "atl"
	team_map["Hornets"] = "cha"
	team_map["Heat"] = "mia"
	team_map["Magic"] = "orl"
	team_map["Wizards"] = "wsh"
	team_map["Nuggets"] = "den"
	team_map["Timberwolves"] = "min"
	team_map["Thunder"] = "okc"
	team_map["Blazers"] = "por"
	team_map["Jazz"] = "utah"
	team_map["Mavericks"] = "dal"
	team_map["Rockets"] = "hou"
	team_map["Grizzlies"] = "mem"
	team_map["Pelicans"] = "no"
	team_map["Spurs"] = "sa"
	
	return team_map[team_name]
}

function format_name(team_name, temp) {
	name = ""
	for (i = 1; i <= temp; i++) {
		if (i == 1) {
			name = tolower(team_name[i]) 
		}
		else {
			name = name "-" tolower(team_name[i])
		}
	}
	return name
}
