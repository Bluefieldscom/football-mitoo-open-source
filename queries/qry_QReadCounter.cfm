<!--- Called by inclLeagueInfo.cfm --->

<cfif StructKeyExists(URL, "LeagueCode")>
	<cfset request.LeagueCode = URL.LeagueCode>
<cfelseif StructKeyExists(FORM, "LeagueCode")>
	<cfset request.LeagueCode = FORM.LeagueCode>
</cfif>

<cfquery name="QReadCounter" datasource="FMPageCount">
	SELECT SQL_NO_CACHE
		CounterValue ,
		CounterStartDateTime
	FROM
		pagecounter
	WHERE
		CounterLeagueID = #request.LeagueID#
</cfquery>

<cfif QReadCounter.RecordCount IS 0>
	<cfquery name="QInsertCounter" datasource="FMPageCount">
		INSERT INTO pagecounter
		(CounterLeagueCode, CounterValue, CounterStartDateTime	)
		VALUES
		(<cfqueryparam value = '#request.LeagueCode#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="10">, 1, Now())
	</cfquery>
	
	<cfquery name="QReadCounter" datasource="FMPageCount">
		SELECT SQL_NO_CACHE
			CounterValue,
			CounterStartDateTime
		FROM
			pagecounter
		WHERE
			CounterLeagueCode = <cfqueryparam value = '#request.LeagueCode#' 
								cfsqltype="CF_SQL_VARCHAR" maxlength="10"> 						
	</cfquery> 
</cfif>
