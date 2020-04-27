#! /usr/bin/awk -f
BEGIN {
	print "Content-type: text/html\n"
	
	split(ENVIRON["QUERY_STRING"], queries, /=/)
	playerID = queries[2]

	system("lynx -dump 'https://www.espn.com/nba/player/gamelog/_/id/" playerID "' | awk -f displayPlayerStats.awk")
}
