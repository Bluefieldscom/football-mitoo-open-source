<!--- secretwordcheck --->

<cfscript>
	/*arguments.startdate = dateformat(Now(),'YYYY-mm-dd');
	arguments.enddate = dateformat(Now(),'YYYY-mm-dd');
	arguments.leaguecode = 'MDX';
	arguments.team_id = 1234;
	arguments.secretWord = 'HLX222NA4';*/
</cfscript>

<!---<cfset request.filter = arguments.leaguecode>
<cfset request.DSN    = variables.dsn>--->

<!--- required in listing page, not here 
<cfinclude template="QgetAllTeamsOneLeague.cfm">
--->

<!--- 
this query can create a selection list 
The selected team name gives access to the id
for the crosscheck below
--->

<cfinclude template="QgetLeagueYearFromDates.cfm">

<cfquery name="QgetOneTeam" datasource="#variables.dsn#">
	SELECT 
		id, longCol, shortCol 
	FROM 
		team 
	WHERE
		id = <cfqueryparam value = #arguments.team_id#
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<cfif QgetOneTeam.recordCount GT 0>

	<cfif QgetOneTeam.shortCol IS NOT "Guest">
		<cfset secretWord = QgetOneTeam.longCol >
		<cfset secretID = QgetOneTeam.id >
		<cfinclude template="../InclSecretWordCreation.cfm">
	</cfif>
	
	<cfif secretWord EQ #arguments.password_club#>
		<cfset password_club_correct = 1>
	</cfif>
<cfelse>
	No such team
</cfif>
