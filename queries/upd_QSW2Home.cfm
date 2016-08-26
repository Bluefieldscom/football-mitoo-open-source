<!--- called by InclSpecifyWinner.cfm --->

<cfquery name="QSW2Home" datasource="#request.DSN#" >
	UPDATE                 <!--- UPDATING FIXTURE --->
		fixture
	SET
	<!--- So, "Arsenal" v "Winners of Match qqq" INSTEAD OF "Winners of Match ppp" v "Winners of Match qqq" --->
		HomeID = 
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
		AND HomeID = <cfqueryparam value = #QSW00.ID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
