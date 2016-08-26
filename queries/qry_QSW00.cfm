<!--- called by InclSpecifyWinner.cfm --->

<cfquery name="QSW00" datasource="#request.DSN#" >
	<!--- Find the Constitution record which has its "This" equal to the "Next" MatchNoID just found
	 say, for example, it points to "Winners of Match ppp" --->
	SELECT
		c.ID, <!--- We'll be using this ID in the query named "QSW2" --->
		c.ThisMatchNoID, <!--- We'll be using this in the query named "QUpdtConstit" --->
		c.NextMatchNoID, <!--- We'll be using this in the query named "QUpdtConstit" --->
		m.LongCol
	FROM
		constitution AS c,
		matchno AS m
	WHERE
		c.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND c.DivisionID = <cfqueryparam value = #DivisionID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c.ThisMatchNoID = <cfqueryparam value = #QSW1.NextMatchNoID# 
								cfsqltype="CF_SQL_INTEGER" maxlength="8">  
								<!--- using NextMatchNoID as key --->
		AND m.ID = c.ThisMatchNoID 
		AND m.LongCol IS NOT NULL <!--- Ignore "Blank" Next matches --->
</CFQUERY>
