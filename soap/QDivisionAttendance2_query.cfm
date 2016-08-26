<!--- called from getFixturesByDivisionIDAndDate method of webServices.cfc --->

<cfinclude template="QgetLeagueYearFromDates2.cfm">


<cfquery name="QDivisionAttendance_query" datasource="#variables.dsn#">
	
	SELECT
		t.longcol as ClubName,
		lc.id as team_id,
		min(f.attendance) as SmallestGate,
		max(f.attendance) as BiggestGate,
		count(*) as total_home_games,
		round(avg(f.attendance)) as average_home_attendance,
		sum(f.attendance) as total_home_attendance
	FROM
		fm#getLeagueYear.leagueCodeYear#.fixture f

	INNER JOIN zmast.lk_division ld ON ld.id='#arguments.division_id#'
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.constitution c ON f.homeid=c.ID
	INNER JOIN fm#getLeagueYear.leagueCodeYear#.team t ON t.ID=c.TeamID
	LEFT JOIN zmast.lk_constitution lc ON lc.#getLeagueYear.leagueCodeYear#id=c.ID

	WHERE
		f.attendance is not null
		AND f.homeid IN  (SELECT id from fm#getLeagueYear.leagueCodeYear#.constitution where DivisionID=ld.#getLeagueYear.leagueCodeYear#id) 

	GROUP BY
		f.homeid
	ORDER BY
		average_home_attendance desc, ClubName;
	
	

</cfquery>
<cfset i=1>
<cfloop query="QDivisionAttendance_query">
	<cfscript>
		QDivisionAttendance[#i#] 							= StructNew();
		QDivisionAttendance[#i#].team_id 					= #team_id#;
		QDivisionAttendance[#i#].team_name 					= #ClubName#;
		QDivisionAttendance[#i#].smallest_gate		 		= #SmallestGate#;
		QDivisionAttendance[#i#].biggest_gate				= #BiggestGate#;
		QDivisionAttendance[#i#].total_home_games			= #total_home_games#;
		QDivisionAttendance[#i#].average_home_attendance	= #average_home_attendance#;
		QDivisionAttendance[#i#].total_home_attendance		= #total_home_attendance#;

		i++;				
	</cfscript>
</cfloop>
