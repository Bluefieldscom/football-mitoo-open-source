<!--- called by RefAvailableUpdDel.cfm --->
<cftry>		  
	<cfquery name="GetRefAvailable" datasource="#request.DSN#">
		SELECT 
			ID,
			Notes
		FROM
			refavailable as RefAvailable 
		WHERE
			LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND	RefereeID = <cfqueryparam value = #URL.RefereeID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND MatchDate = #URL.Match_Date#;
	</cfquery>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" 
			source="RefAvailable" errortype="baddata">
		<cfabort>
	</cfcatch>
</cftry>