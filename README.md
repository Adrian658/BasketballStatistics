# BasketballStatistics

#So the html file has one button that when clicked links to cgi script 'getPlayers.cgi'

#This scripts then uses the following command
#lynx --dump "https://www.espn.com/nba/team/roster/_/name/gs/golden-state-warriors" | awk -f cleanRoster.awk
#to get the data and pipe it into 'cleanRoster.awk' which handles the data cleaning and formatting and stuff


#Then when the player name is clicked on it runs the 'getGamelog.cgi' script and sends it the player ID in GET request
#Which the cgi script uses to create a new url that will display game data, and then sends the data to another awk script which cleans and formats data
