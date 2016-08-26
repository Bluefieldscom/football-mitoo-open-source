<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QAttendanceStats_query" datasource="#variables.dsn#">
	SELECT
		d.longcol as DivisionName,
		t.longcol as ClubName,
		o.longcol as OrdinalName,
		min(f.attendance) as SmallestGate,
		max(f.attendance) as BiggestGate,
		count(*) as total_home_games,
		round(avg(f.attendance)) as average_home_attendance,
		sum(f.attendance) as total_home_attendance
	FROM
		fixture f,
		constitution c,
		team t,
		ordinal o ,
		division d
	WHERE
		f.leaguecode=<cfqueryparam value = '#arguments.leaguecode#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.attendance is not null
		AND f.homeid IN  (SELECT id from constitution where DivisionID=#arguments.division_id#) 
		AND f.homeid = c.id
		AND c.teamID = t.id
		AND c.ordinalID = o.ID
		AND c.DivisionID = d.ID
	GROUP BY
		f.homeid
	ORDER BY
		average_home_attendance desc, ClubName;
</cfquery>
<cfset i=1>
<cfloop query="QAttendanceStats_query">
	<cfscript>
		QAttendanceStats[#i#] = StructNew();
		QAttendanceStats[#i#].division_name 			= #divisionName#;
		QAttendanceStats[#i#].club_name		 			= #clubName#;
		QAttendanceStats[#i#].ordinal_name				= #ordinalName#;
		QAttendanceStats[#i#].smallest_gate				= #smallestGate#;
		QAttendanceStats[#i#].biggest_gate				= #biggestGate#;
		QAttendanceStats[#i#].total_home_games			= #total_home_games#;
		QAttendanceStats[#i#].average_home_attendance 	= #average_home_attendance#;
		QAttendanceStats[#i#].total_home_attendance		= #total_home_attendance#;
		i++;
	</cfscript>
</cfloop>