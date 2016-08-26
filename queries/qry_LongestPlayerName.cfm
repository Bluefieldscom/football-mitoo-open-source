<!--- called by RegisteredList1.cfm and RegisteredList2.cfm--->

<cfquery name="QLongestPlayerName" dbtype="query">
	SELECT
		MAX(NameLength) as LengthOfLongestPlayerName
	FROM
		QThisClubsRegisteredPlayers
</cfquery>


<!--- CONCAT(surname, ' ', forename) as LongestPlayerName --->