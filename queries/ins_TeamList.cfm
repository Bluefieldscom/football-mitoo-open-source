<!--- called from UpdateTeamList.cfm --->

<cftry>
	<cfquery datasource="#request.DSN#">
	INSERT INTO
		appearance
		(FixtureID, HomeAway, PlayerID,	GoalsScored, Card, StarPlayer, Activity, LeagueCode)
	VALUES
		(
		<cfqueryparam value = #FID# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		<cfqueryparam value = '#form.HA#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="1">,
		<cfqueryparam value = #PID# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		<cfqueryparam value = #GoalsScored# 
			cfsqltype="CF_SQL_INTEGER" maxlength="2">,
		<cfqueryparam value = #CardValue# 
			cfsqltype="CF_SQL_INTEGER" maxlength="1">,
		<cfqueryparam value = #StarPlayer# 
			cfsqltype="CF_SQL_INTEGER" maxlength="1">,
		<cfqueryparam value = #ActivityVal# cfsqltype="CF_SQL_INTEGER" maxlength="1">,
		<cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		)
	</cfquery>
	<cfcatch type="Database">
		<cfif cfcatch.NativeErrorCode IS "1062">
			<!--- duplicate values for FixtureID,PlayerID,HomeAway --->
			<cfmodule template="../dberrorpage.cfm" source="TeamList" errortype="duplicatekey">
			<cfabort>
		</cfif>
	</cfcatch>
	<cfcatch type="Any">
		<!--- for all other errors, most likely non-numeric codes --->
		<cfmodule template="../dberrorpage.cfm" source="TeamList" errortype="baddata">
		<cfabort>
	</cfcatch>
</cftry>
