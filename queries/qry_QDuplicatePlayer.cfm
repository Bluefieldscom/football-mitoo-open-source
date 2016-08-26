<!--- called by LUList.cfm --->
<cfquery name="QDuplicatePlayer" datasource="#request.DSN#" >
	SELECT
		p1.surname as surname1,
		p1.MediumCol as DOB1,
		p1.forename as Forename1,
		p1.ID as PID1,
		p1.ShortCol as RegNo1,
		p1.notes as Notes1,
		p2.surname as surname2,
		p2.MediumCol as DOB2,
		p2.forename as Forename2,
		p2.ID as PID2,
		p2.ShortCol as RegNo2,
		p2.notes as Notes2
	FROM
		player p1,
		player p2
	WHERE
		p1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p1.ID = #QPairings.PID1#
		AND p2.ID = #QPairings.PID2#
</cfquery>
