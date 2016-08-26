<!--- called by LUList.cfm.cfm --->
<cfquery name="InsrtClubInfo" datasource="#request.DSN#" >
	INSERT INTO 
		player 
		(mediumCol, shortCol, notes, LeagueCode, surname, forename)
	 VALUES 
		(NULL, 0, 'OwnGoal', '#request.filter#', 'OwnGoal', '')
</cfquery>

