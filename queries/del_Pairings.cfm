<!--- called by LUList.cfm --->
<cfquery name="DeletePairings1" datasource="#request.DSN#" >
	SELECT PID FROM playerduplicatepairings WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>
<cfset DelPIDList=ValueList(DeletePairings1.PID)>
<cfif ListLen(DelPIDList) GT 0>
	<cfquery name="DeletePairings2" datasource="#request.DSN#" >
		DELETE FROM
			playerduplicatepairings
		WHERE
			PID IN (#DelPIDList#)
	</cfquery>
</cfif>
