<!--- called from MoveToMisc.cfm --->
<cfquery name="Qfixturenotes" datasource="#request.DSN#" >
	SELECT 
		fixturenotes 
	FROM
		fixture 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #Form.FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<cfif Qfixturenotes.fixturenotes IS NOT "">
	<cfquery name="QUpdtMisc007" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET
			HomeID = <cfqueryparam value = #QGetIDMisc003.NewID#    cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			AwayID = <cfqueryparam value = #QGetIDMisc005.NewID#    cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			FixtureNotes = CONCAT('Moved from #Form.DivisionName# to Miscellaneous. #Form.ReasonForMove#<br>', FixtureNotes)
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #Form.FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
<cfelse>
	<cfquery name="QUpdtMisc007" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET
			HomeID = <cfqueryparam value = #QGetIDMisc003.NewID#    cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			AwayID = <cfqueryparam value = #QGetIDMisc005.NewID#    cfsqltype="CF_SQL_INTEGER" maxlength="8">,
			FixtureNotes = 'Moved from #Form.DivisionName# to Miscellaneous. #Form.ReasonForMove#'
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #Form.FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
</cfif>



