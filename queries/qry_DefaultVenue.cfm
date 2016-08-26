<!--- called by Unsched.cfm --->
<cfquery name="QDefaultVenue" datasource="#request.DSN#">
	SELECT
		v.longcol, 
		v.id as VID, 
		pn.ID as PNID
	FROM 
		teamdetails td, 
		venue v ,
		pitchno pn 
	WHERE
		td.leaguecode=<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND td.TeamID=#ThisTeamID# 
		AND td.OrdinalID=#ThisOrdinalID# 
		AND td.venueid=v.id
		AND td.PitchNoID=pn.id
</cfquery>
