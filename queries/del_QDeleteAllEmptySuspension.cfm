<!--- called from SuspendPlayer.cfm --->

<cftry>

	<cfquery name="QDeleteAllEmptySuspension" datasource="#request.DSN#" >
		DELETE FROM suspension 
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND FirstDay IS NULL 
			AND LastDay IS NULL
	</cfquery>
	<cfif QLeagueCode.LeagueCodeYear GE 2010 > <!--- 2010 was when Match Bans were introduced, so don't bother with earlier seasons --->
		<cfquery name="QDeleteAllEmptySuspension2" datasource="#request.DSN#" >
			DELETE FROM suspension 
			WHERE 
				LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
				AND NumberOfMatches > 0
				AND id NOT IN (SELECT suspensionid from matchbanheader WHERE LeagueCode = '#request.filter#')
		</cfquery>
	</cfif>
	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Suspension"><cfabort>
	</cfcatch>
	
</cftry>	
