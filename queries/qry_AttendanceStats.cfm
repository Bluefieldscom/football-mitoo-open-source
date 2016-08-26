<!--- called from AttendanceStats.cfm --->

<CFQUERY NAME="AttendanceStats" datasource="#request.DSN#">
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
		f.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.attendance is not null
		AND f.homeid IN  (SELECT id from constitution where DivisionID=#DivisionID#) 
		AND f.homeid = c.id
		AND c.teamID = t.id
		AND c.ordinalID = o.ID
		AND c.DivisionID = d.ID
	GROUP BY
		f.homeid
	ORDER BY
		average_home_attendance desc, ClubName;
</CFQUERY>
