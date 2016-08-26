<cfquery name="QAllClubs_query" datasource="ZMAST">
	SELECT 	
		ti.fmTeamID as mitoo_team_id,
		ci.id as mitoo_club_id,
		ci.ClubName as mitoo_club_name
	FROM 
		teaminfo ti
	INNER JOIN
		clubinfo ci ON ci.id=ti.ClubInfoID
</cfquery>
<cfset i=1>
<cfloop query="QAllClubs_query">
	<cfscript>
		QAllClubs[#i#] = StructNew();
		QAllClubs[#i#].mitoo_club_id 	= #mitoo_club_id#;
		QAllClubs[#i#].mitoo_team_id 	= #mitoo_team_id#;
		QAllClubs[#i#].mitoo_club_name	= #mitoo_club_name#;
		i++;
	</cfscript>
</cfloop>