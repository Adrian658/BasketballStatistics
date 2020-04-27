#!/bin/bash
echo "Content-type: text/html"
echo

echo "<a href="../project2.html">Go Back to Home Page</a>"
echo ""

lynx --dump "https://www.espn.com/nba/team/roster/_/name/gs/golden-state-warriors" | awk -f cleanRoster.awk
