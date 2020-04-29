BEGIN {

	print "<body style='background-image: url(https://www.factinate.com/wp-content/uploads/2020/02/NBAinternal.jpg);background-attachment: fixed;background-repeat: no-repeat;background-size: cover;'>"
	playerOverall = 0
	gameLog = 0
	summaryStats = 0
	summarized = 0

	while (getline) {
		if (playerOverall >= 1) {
			determineSummaryStatistics($0)
		}
		if (gameLog >= 1) {
			if (monthlyDataParse == 1) {
                                monthlyDataParse = 0
				for (i = 1; i<=NF; i++) {
					print "<strong style='width: 60px; display: inline-block'>" $i "</strong>"
				}
				print "</div></center>"
                        	print "<div style='height: 20px;'></div>"
			}
			else if (NF == 13 || NF == 12 || $0 ~ /Finals/ || $0 ~ /Semifinals/ || $0 ~ /Quarterfinals/) {
				monthlyDataParse = 1
				print "<center><div style='padding: 0 30px 15px 30px; border-radius: 0 0 4px 4px; text-align: left; width: 90%; color: white; background-color: rgba(0, 0, 0, 0.6); font-size: 0.9em'>"
				if ($0 ~ /Finals/ || $0 ~ /Semifinals/ || $0 ~ /Quarterfinals/) {
					print "<strong style='width: 306px; display: inline-block'>" $1 " " $2 "</strong>"
					print "<strong style='width: 60px; display: inline-block'>" $3 "</strong>"
                                        print "<strong style='width: 80px; display: inline-block'>" $4 "</strong>"
                                        print "<strong style='width: 60px; display: inline-block'>" $5 "</strong>"
                                        print "<strong style='width: 80px; display: inline-block'>" $6 "</strong>"
                                        print "<strong style='width: 60px; display: inline-block'>" $7 "</strong>"
                                        print "<strong style='width: 80px; display: inline-block'>" $8 "</strong>"
					start = 9
                                }
				else {
					print "<strong style='width: 306px; display: inline-block'>" $1 "</strong>"
					print "<strong style='width: 60px; display: inline-block'>" $2 "</strong>"
                                	print "<strong style='width: 80px; display: inline-block'>" $3 "</strong>"
                                	print "<strong style='width: 60px; display: inline-block'>" $4 "</strong>"
                                	print "<strong style='width: 80px; display: inline-block'>" $5 "</strong>"
                                	print "<strong style='width: 60px; display: inline-block'>" $6 "</strong>"
                                	print "<strong style='width: 80px; display: inline-block'>" $7 "</strong>"
					start = 8
				}
				for (i = start; i<=NF; i++) {
                                        print "<strong style='width: 60px; display: inline-block'>" $i "</strong>"
                                }
			}
			else {
				determineGameStatistics($0)
			}
		}
		if ($0 ~ /^\s*[A-Z][a-z].*$/ && playerOverall == 0 && summarized == 0) {
                        playerOverall = 1
			summarized = 1
                }
		if ($0 ~ /Date OPP Result MIN FG FG% 3PT 3P% FT FT% REB AST BLK STL PF TO PTS/) {
			gameLog = 1
			print "<center><div style='padding: 15px 30px 0 30px; border-radius: 4px 4px 0 0; border-bottom: 1px solid white; text-align: left; width: 90%; color: white; background-color: rgba(0, 0, 0, 0.6); font-size: 0.8em;'>"
			print "<strong style='width: 100px; display: inline-block;'>DATE</strong>"
			print "<strong style='width: 100px; display: inline-block;'>OPP</strong>"
			print "<strong style='width: 100px; display: inline-block;'>RESULT</strong>"
			print "<strong style='width: 60px; display: inline-block;'>MIN</strong>"
			print "<strong style='width: 80px; display: inline-block;'>FG</strong>"
			print "<strong style='width: 60px; display: inline-block;'>FG%</strong>"
			print "<strong style='width: 80px; display: inline-block;'>3PT</strong>"
			print "<strong style='width: 60px; display: inline-block;'>3P%</strong>"
			print "<strong style='width: 80px; display: inline-block;'>FT</strong>"
			print "<strong style='width: 60px; display: inline-block;'>FT%</strong>"
			print "<strong style='width: 60px; display: inline-block;'>REB</strong>"
			print "<strong style='width: 60px; display: inline-block;'>AST</strong>"
			print "<strong style='width: 60px; display: inline-block;'>BLK</strong>"
			print "<strong style='width: 60px; display: inline-block;'>STL</strong>"
			print "<strong style='width: 60px; display: inline-block;'>PF</strong>"
			print "<strong style='width: 60px; display: inline-block;'>TO</strong>"
			print "<strong style='width: 60px; display: inline-block;'>PTS</strong>"
			print "</div></center>"
		}
		
		if ($0 ~ /Regular Season Stats/) {
			gameLog = 0
			summaryStats = 1
		}
		if ($0 ~ /Preseason/ || $0 ~ /Elias Sports Bureau/ || $0 ~ /Glossary/) {
			exit 1
		}
	}

}

function determineGameStatistics(data) {
        if (gameLog == 1) {
		if (data ~ /FINALS/ || data ~ /ROUND/ || data ~ /STAR/) {
			gamelog = 0
			print "<center><div style='background-color: rgba(0,0,0,0.6); padding: 0 30px 5px 30px; text-align: left; width: 90%; color: whitesmoke;'>" $0 "</div></center>"
			return
		}
                gameData[0] = $1 ", " $2 #Date
        }
        if (gameLog == 2) {
                gameData[1] = $1 #Opponent
        }
        if (gameLog == 4) {
                gameData[2] = $1 #Outcome
        }
        if (gameLog == 5) {
		
		counter = 0

		if ($2 == "OT") {
                        counter = 1
                }

		print "<center>"
                print "<div style='padding: 0 30px 0 30px; text-align: left; width: 90%; color: whitesmoke; background-color: rgba(0, 0, 0, 0.6); font-size: 0.9em;'>"
                print "<div style='width: 100px; display: inline-block;'>" gameData[0] "</div>"
		print "<div style='width: 100px; display: inline-block;'>vs " gameData[1] "</div>"
		if ($2 == "OT") {
                        counter = 1
			print "<div style='width: 100px; display: inline-block;'>" gameData[2] " " $1 " (OT)" "</div>"
                }
		else {
			print "<div style='width: 100px; display: inline-block;'>" gameData[2] " " $1 "</div>"
		}		

		print "<div style='width: 60px; display: inline-block;'>" $(2+counter) "</div>"
                print "<div style='width: 80px; display: inline-block;'>" $(3+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(4+counter) "</div>"
                print "<div style='width: 80px; display: inline-block;'>" $(5+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(6+counter) "</div>"
                print "<div style='width: 80px; display: inline-block;'>" $(7+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(8+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(9+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(10+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(11+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(12+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(13+counter) "</div>"
		print "<div style='width: 60px; display: inline-block;'>" $(14+counter) "</div>"
                print "<div style='width: 60px; display: inline-block;'>" $(15+counter) "</div>"
		print "</div>"
		print "</center>"

                gameLog=0
        }
        gameLog = gameLog + 1
}

function determineSummaryStatistics(data) {
	if (playerOverall == 1) {
                playerData[0] = data #Name
	}
	else if (playerOverall == 5) {
		playerData[15] = data #Team
	}
	else if (playerOverall == 7) {
		sub(/*/, "", data)
                playerData[1] = data #Number
	}
        else if (playerOverall == 8) {
		sub(/*/, "", data)
                playerData[2] = data #Position
        }
        else if (playerOverall == 12) {
		split(data, temp, ",") #Physical Attributes
		playerData[3] = temp[1]
		playerData[4] = temp[2]
        }
        else if (playerOverall == 14) {
		split(data, temp, " ")
		playerData[5] = temp[1]
                playerData[6] = temp[2] #Age
        }
        else if (playerOverall == 16) {
		sub(/\[[0-9]*\]/, "", data)
                playerData[7] = data #College
        }
        else if (playerOverall == 18) {
                playerData[8] = data #Draft info
        }
        else if (playerOverall == 20) {
                playerData[9] = data #Status
        }
        else if (playerOverall == 22) {
                playerData[10] = data #Season
        }
        else if (playerOverall == 24) {
                playerData[11] = data #Player Pts
        }
        else if (playerOverall == 26) {
                if (data ~ /[0-9]*[0-9]/) {
			playerData[12] = data #Player Reb
		}
		else {
			return
		}
        }
        else if (playerOverall == 28) {
		if (data ~ /[0-9]*[0-9]/) {
                        playerData[13] = data #Player Ast
                }
                else {
                        return
                }
        }
	else if (playerOverall == 30) {
		if (data ~ /[0-9]*[0-9]/) {
                        playerData[14] = data #Player Per
                }
                else {
			return
                }

		print "<center>"
		print "<div style='margin-top: 30px; padding: 30px; width: 80%; background-color: rgba(0, 0, 0, 0.6); color: white;'>"
		print "<div style='text-align: center;'>"
		print "<div style='font-size: 4em;'>" playerData[0] "</div>"
		print "<span style='font-size: 1.5em'>" playerData[15] " | " playerData[1] "</span>"
		print "<span style='font-size: 1.5em'> | " playerData[2]  "</span>"
		print "</div>"

		print "<div style='margin-left: 20%; margin-top: 25px; text-align: left;'>"
		print "<div><span style='width: 100px; display: inline-block;'>Height: </span>" "<span style='width: 396px; display: inline-block'>" playerData[3] "</span>" "<strong>" playerData[10] "</strong></div>"
		print "<div><span style='width: 100px; display: inline-block;'>Weight: </span>" "<span style='width: 400px; display: inline-block'>" playerData[4] "</span>" "<span>PTS - " playerData[11] "</span></div>"
		print "<div><span style='width: 100px; display: inline-block;'>DOB/Age: </span>" "<span style='width: 400px; display: inline-block'>" playerData[5] " " playerData[6] "</span>" "<span>REB - " playerData[12] "</span></div>"
		print "<div><span style='width: 100px; display: inline-block;'>College: </span>" "<span style='width: 400px; display: inline-block'>" playerData[7] "</span>" "<span>AST - " playerData[13] "</span></div>"
		if (playerData[8] ~ /[0-9][0-9][0-9][0-9]:*/) {
			print "<div><span style='width: 100px; display: inline-block;'>Draft Info: </span>" "<span style='width: 400px; display: inline-block'>" playerData[8] "</span>" "<span>PER - " playerData[14] "</span></div>"
			print "<div><span style='width: 96px; display: inline-block;'>Status: </span><span>" playerData[9] "</span></div>"
		}
		else {
			print "<div><span style='width: 100px; display: inline-block'>Status: </span>" "<span style='width: 400px; display: inline-block'>" playerData[8] "</span>" "<span>PER - " playerData[14] "</span></div>"
			print "<div><span style='width: 96px; display: inline-block'>Experience: </span><span>" playerData[9] "</span></div>"
		}
		print "</div></div></center>"

		print "<center><div style='padding-top: 30px; padding-bottom: 20px; color: white; font-size: 2.5em;'>Game Statistics</div></center>"
	
                playerOverall = -1
        }
	playerOverall = playerOverall + 1
}
END {

	print "<center><div style='padding: 15px 30px 15px 30px; text-align: left; width: 90%; color: white; background-color: rgba(0, 0, 0, 0.6)'>"
	print "<div style='text-align: center; margin-bottom: 10px;'>Glossary</div>"
	print "<div><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>3P%: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>3-Point Field Goal Percentage</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>FG%: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Field Goal Percentage</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>PTS: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Points</span></div>"
	print "<div><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>3PT: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>3-Point Field Goals Made-Attempted</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>FT: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Free Throws Made-Attempted</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>REB: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Rebounds</span></div>"
	print "<div><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>AST: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Assists</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>FT%: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Free Throw Percentage</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>STL: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Steals</span></div>"
	print "<div><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>BLK: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Blocks</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>MIN: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Minutes</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>TO</strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Turnovers</span></div>"
	print "<div><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>FG: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Field Goals Made-Attempted</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>PF: </strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Fouls</span><strong style='width: 40px; display: inline-block; font-size: 0.9em;'>PER</strong><span style='width: 300px; display: inline-block; font-size: 0.9em;'>Player Efficiency Rating</span></div>"
	print "</div></center>"

	print "</body>"
}
