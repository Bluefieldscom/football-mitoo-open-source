<!--- called by LUList.cfm --->
<!--- Get rid of any suppressed warnings if the player registration numbers are not to be found in the player table --->

<cfquery name="QPlayerDuplicateNoWarnings1" datasource="#request.DSN#" >
	SELECT
		ID,
		RegNo1,
		RegNo2,
		Reason
	 FROM
		playerduplicatenowarnings
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</cfquery>

<cfoutput query="QPlayerDuplicateNoWarnings1">
	<cfquery name="QShortColA" datasource="#request.DSN#" >
		SELECT ID FROM player WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ShortCol = #QPlayerDuplicateNoWarnings1.RegNo1#
	</cfquery>
	<cfif QShortColA.RecordCount IS 0>
		<cfquery name="DeletePlayerDuplicateNoWarningsA" datasource="#request.DSN#" >
			DELETE FROM playerduplicatenowarnings WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ID = #QPlayerDuplicateNoWarnings1.ID#
		</cfquery>
	</cfif>
	<cfquery name="QShortColB" datasource="#request.DSN#" >
		SELECT ID FROM player WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ShortCol = #QPlayerDuplicateNoWarnings1.RegNo2#
	</cfquery>
	<cfif QShortColB.RecordCount IS 0>
		<cfquery name="DeletePlayerDuplicateNoWarningsB" datasource="#request.DSN#" >
			DELETE FROM playerduplicatenowarnings WHERE LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> AND ID = #QPlayerDuplicateNoWarnings1.ID#
		</cfquery>
	</cfif>
</cfoutput>

