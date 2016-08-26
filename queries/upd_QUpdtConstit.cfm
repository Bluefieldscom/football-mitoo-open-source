<!--- called by InclSpecifyWinner.cfm --->

<cfquery name="QUpdtConstit" datasource="#request.DSN#" >
	UPDATE
		constitution 
	SET
		ThisMatchNoID = <cfqueryparam value = #QSW00.ThisMatchNoID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		NextMatchNoID = <cfqueryparam value = #QSW00.NextMatchNoID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = 
			<cfif TypeOfWin IS "Home">
				<cfqueryparam value = #QSW1.HomeID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
			<cfelse>
				<cfqueryparam value = #QSW1.AwayID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
			</cfif>
</CFQUERY>
