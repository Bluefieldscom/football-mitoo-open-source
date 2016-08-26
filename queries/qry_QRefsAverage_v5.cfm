<!--- called by RefsRanking.cfm --->

<CFQUERY NAME="QRefsAverage" datasource="#request.DSN#">	
	SELECT
		COALESCE(SUM(RefereeMarksH),0) + COALESCE(SUM(RefereeMarksA),0) as SumRefereeMarks,
		COUNT(RefereeMarksH) + COUNT(RefereeMarksA) as RefereeMarkedGames
	FROM
		fixture f, referee r
	WHERE
		f.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		<cfif ThisLevel IS ""><cfelseif IsNumeric(ThisLevel)>AND r.Level = #ThisLevel#<cfelse></cfif>
		<cfif ThisPCounty IS "ALL"><cfelse>AND r.ParentCounty = '#ThisPCounty#'</cfif>
		AND f.RefereeID = r.ID
	HAVING
		RefereeMarkedGames > 0 <!--- COUNT(RefereeMarksH + RefereeMarksA) > 0 --->
</CFQUERY>		
