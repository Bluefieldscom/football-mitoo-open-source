<!--- called by InclSpecifyWinner.cfm --->

<cfquery name="QSW2Away" datasource="#request.DSN#" >
	UPDATE                 <!--- UPDATING FIXTURE --->
		fixture
	SET
		AwayID = 
			<cfif TypeOfWin IS "Home">
				<cfqueryparam value = #QSW1.HomeID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
			<cfelse>
				<cfqueryparam value = #QSW1.AwayID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
			</cfif>
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND AwayID = <cfqueryparam value = #QSW00.ID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
