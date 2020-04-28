BEGIN {
	#Get the coaches name
	#while (getline) {
	#	if ($0 ~ /Coach: /){
	#		print $0
	#	}
	#}

	#Get the players and their summary statistics and print out links to more in depth statistics page
	

	roster = 0
	playerID = 0

	print "<body style='background-image: url(https://usatftw.files.wordpress.com/2015/06/6796457-golden-state-warriors-wallpaper.jpg);background-attachment: fixed;background-repeat: no-repeat;background-size: cover;'>"

	#Print the team name	
	gsub("+", " ", team_name)
	print "<center><h1>"
	print team_name
	print "</h1></center>"

	print "<div style='margin-top: 20px;'>"
        print "<strong style='width: 110px; display: inline-block;'></strong>"
        print "<strong style='width: 180px; display: inline-block;'>Name</strong>"
        print "<strong style='width: 80px; display: inline-block;'>Position</strong>"
        print "<strong style='width: 80px; display: inline-block;'>Age</strong>"
        print "<strong style='width: 80px; display: inline-block;'>Height</strong>"
        print "<strong style='width: 100px; display: inline-block;'>Weight</strong>"
        print "<strong style='width: 120px; display: inline-block;'>Salary</strong>"
        print "<strong style='width: 400px; display: inline-block;'>School</strong>"
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
				if ($3 !~ /[A-Z][A-Z]$/ && $3 !~ /\s*C\s*/ && $3 !~ /\s*F\s*/) {
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
				print "<div style='width: 400px; display: inline-block;'>" school "</div>"
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
	print "</body>"
}
