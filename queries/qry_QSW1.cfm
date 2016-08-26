<!--- called by InclSpecifyWinner.cfm --->

<CFQUERY NAME="QSW1" datasource="#request.DSN#">
	SELECT
		c.NextMatchNoID,	<!--- here's the NextMatchNoID for the team that's won --->
		f.HomeID,
		f.AwayID,
		f.MatchNumber,
		m1.LongCol as ThisMatchInfo,
		m2.LongCol as NextMatchInfo
	FROM
		constitution AS c,
		fixture AS f,
		matchno AS m1,
		matchno AS m2
	WHERE
		f.ID = <cfqueryparam value = #id# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
					<!--- Look at the Fixture just updated --->
					<!--- Look at who has won, say it was "Arsenal" at home --->
		AND c.ID = 
			<cfif TypeOfWin IS "Home">
				f.HomeID
			<cfelse>
				f.AwayID
			</cfif> 
		AND m1.ID = c.ThisMatchNoID 
		AND m2.ID = c.NextMatchNoID
</CFQUERY>
