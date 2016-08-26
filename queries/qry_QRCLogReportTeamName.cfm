<!--- called by RCLogReport.cfm --->
<cfquery name="QRCLogReportTeamName" datasource="#request.DSN#" >
	SELECT
		CONCAT(t.LongCol," ",IFNULL(o.LongCol,"")) as OutputText 
	FROM 
		team t, ordinal o
	WHERE 
		t.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND t.ID = #QUpdateHistory.ID1# 
		AND o.ID = #QUpdateHistory.ID2# 
</cfquery>

