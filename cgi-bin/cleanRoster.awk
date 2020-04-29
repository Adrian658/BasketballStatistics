BEGIN {
	
	roster = 0
	playerID = 0

	print "<style>#tweet-container > ::-webkit-scrollbar {width: 0px; background: transparent;}</style>"
	print "<body style='background-image: url(https://www.factinate.com/wp-content/uploads/2020/02/NBAinternal.jpg);background-attachment: fixed;background-repeat: no-repeat;background-size: cover;'>"

	#Print the team name	
	gsub("+", " ", team_name)
	print "<center><h1 style='margin-top: 30px; color: white; font-size: 4em;'>"
	print team_name
	print "</h1></center>"

	print "<div style='display: table; clear: both; width: 100%;'>"
	print "<div style='float: left; width: 73%; padding-left: 25px;'>"
	print "<div style='margin-top: 20px; color: white;'>"
        print "<strong style='width: 110px; display: inline-block;'></strong>"
        print "<strong style='width: 180px; display: inline-block;'>Name</strong>"
        print "<strong style='width: 80px; display: inline-block;'>Position</strong>"
        print "<strong style='width: 80px; display: inline-block;'>Age</strong>"
        print "<strong style='width: 80px; display: inline-block;'>Height</strong>"
        print "<strong style='width: 100px; display: inline-block;'>Weight</strong>"
        print "<strong style='width: 120px; display: inline-block;'>Salary</strong>"
        print "<strong style='width: 225px; display: inline-block;'>School</strong>"
        print "</div>"

	while (getline) {
		if (roster == 1) {
			if ($0 ~ /https:./) {
				print "<hr>"
				print "<div style='background-color: rgba(0,0,0,0.6); color: white'>"
				print "<img src='" $0 "' style='height: 80px; width: 110px; display: inline-block;'>"
				gsub(/[^0-9]/, "", $0)
				playerID = $0
			}
			else if ($0 ~ /^\s*\[[[0-9][0-9]\]/ ) {
				field_extend = 0
				name = $1 " "  $2
				if ($3 !~ /[A-Z][A-Z]$/ && $3 !~ /\s*[A-Z]\s*$/) {
					name = name " " $3
					field_extend = 1
				}
				gsub(/[0-9]/, "", name)
				sub(/\[/, "", name)
				sub(/\]/, "", name)
				position = $(3+field_extend)
				age = $(4+field_extend)
				height = $(5+field_extend) $(6+field_extend)
				sub(/"/, "", height)
				weight = $(7+field_extend) " " $(8+field_extend)
				school = ""
				for (i = 9+field_extend; i < NF; i++) {
                                        school = school " " $i
                                }
				salary = $NF
				
				print "<div style='display: inline-block'>"
				print "<form method='GET' action='getGamelog.cgi'>"
				print "<div style='text-decoration: underline; position: absolute; width: 180px;'>" name "</div>"
				print "<input name='PlayerID' type='submit' value='" playerID "' style='width: 180px; cursor: pointer; opacity: 0'>"
				print "</form>"
				print "</div>"
				#print "<a href='test.cgi' style='width: 180px; display: inline-block;'>" name "</a>"
				print "<div style='width: 80px; display: inline-block;'>" position "</div>"
				print "<div style='width: 80px; display: inline-block;'>" age "</div>"
				print "<div style='width: 80px; display: inline-block;'>" height "</div>"
				print "<div style='width: 100px; display: inline-block;'>" weight "</div>"
				print "<div style='width: 120px; display: inline-block;'>" salary "</div>"
				print "<div style='width: 225px; display: inline-block;'>" school "</div>"
				print "</div>"
			}
		}
		if ($0 ~ /Team Roster/){
                        roster = 1
                }
		if ($0 ~ /Coach: /){
			roster = 0
		}
	}
}
END {
	print "</div>"
	print "<div id='tweet-container' style='float: left; width: 25%; position: sticky; top: 0; padding-top: 55px;'>"
	print "<div style='overflow: auto; height: 90vh; padding: 0 25px 0 25px;'>"
	print "<a class='twitter-timeline' href='https://twitter.com/" find_twitter_handle(team_name)  "?ref_src=twsrc%5Etfw'>Tweets by NBA</a> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script>"
	print "</div>"
	print "</div>"
	print "</body>"
}

function find_twitter_handle(team) {
	team_map["Boston Celtics"] = "celtics"
        team_map["Brooklyn Nets"] = "BrooklynNets"
        team_map["New York Knicks"] = "nyknicks"
        team_map["Philadelphia 76ers"] = "sixers"
        team_map["Toronto Raptors"] = "Raptors"
        team_map["Golden State Warriors"] = "warriors"
        team_map["LA Clippers"] = "LAClippers"
        team_map["Los Angeles Lakers"] = "Lakers"
        team_map["Phoenix Suns"] = "Suns"
        team_map["Sacramento Kings"] = "SacramentoKings"
        team_map["Chicago Bulls"] = "chicagobulls"
        team_map["Cleveland Cavaliers"] = "cavs"
        team_map["Detroit Pistons"] = "DetroitPistons"
        team_map["Indiana Pacers"] = "Pacers"
        team_map["Milwaukee Bucks"] = "Bucks"
        team_map["Atlanta Hawks"] = "ATLHawks"
        team_map["Charlotte Hornets"] = "hornets"
        team_map["Miami Heat"] = "MiamiHEAT"
        team_map["Orlando Magic"] = "OrlandoMagic"
        team_map["Washington Wizards"] = "WashWizards"
        team_map["Denver Nuggets"] = "nuggets"
        team_map["Minnesota Timberwolves"] = "Timberwolves"
        team_map["Oklahoma City Thunder"] = "okcthunder"
        team_map["Portland Trail Blazers"] = "trailblazers"
        team_map["Utah Jazz"] = "utahjazz"
        team_map["Dallas Mavericks"] = "dallasmavs"
        team_map["Houston Rockets"] = "HoustonRockets"
        team_map["Memphis Grizzlies"] = "memgrizz"
        team_map["New Orleans Pelicans"] = "PelicansNBA"
        team_map["San Antonio Spurs"] = "spurs"

        return team_map[team_name]
}
