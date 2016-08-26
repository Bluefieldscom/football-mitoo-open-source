<!--- called by InclSpecifyWinner.cfm --->

<cfquery name="QUpdtConstit2" datasource="#request.DSN#" >
	UPDATE
		constitution 
	SET
		ThisMatchNoID = <cfqueryparam value = #QGetBlank.ID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		NextMatchNoID = <cfqueryparam value = #QGetBlank.ID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND 
			<cfif TypeOfWin IS "Home">
				ID = <cfqueryparam value = #QSW1.AwayID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
			<cfelse>
				ID = <cfqueryparam value = #QSW1.HomeID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
			</cfif>
</CFQUERY>
