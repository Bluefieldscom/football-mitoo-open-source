<!--- called by Action.cfm --->
<cftry>
	<cfquery name="QUpdtPlayerRecord" datasource="#request.DSN#" >
		UPDATE
			player
		SET 
			LongCol = <cfqueryparam value = '#Form.LongCol#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="50">, 
			MediumCol = <cfqueryparam value = '#Form.MediumCol#' 
							cfsqltype="CF_SQL_DATE">,
			ShortCol = <cfqueryparam value = #Form.ShortCol# 
						cfsqltype="CF_SQL_INTEGER" maxlength="10">,
			<cfif Form.Notes IS "">
				Notes = ' '
			<cfelse>
				Notes = <cfqueryparam value = '#Form.Notes#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="225">
			</cfif>
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #Form.ID# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
		<cfcatch type="Database">
			<cfif cfcatch.NativeErrorCode IS "1062">
				<cfif cfcatch.detail contains "key 3">
				<!--- duplicate values on Leaguecode,LongCol(Name),MediumCol(DOB) - Check2 --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="namedob">
				<cfelse>
				<!--- duplicate values on Leaguecode,Shortcol(unique ID) - Check --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="indexno">
				</cfif>
				<cfabort>
			</cfif>
		</cfcatch>
		<cfcatch type="Any">
			<!--- for all other errors, most likely non-numeric codes --->
			<cfmodule template="../dberrorpage.cfm" 
				source="Player" errortype="baddata">
			<cfabort>
		</cfcatch>
</cftry>