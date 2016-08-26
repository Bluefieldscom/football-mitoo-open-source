<!--- called by Action.cfm --->

<cfquery name="QUpdtNewsitemRecord" datasource="#request.DSN#" >
	UPDATE
		newsitem 
	SET 
		LongCol = '#ThisLongcol#',
		<cfif ThisMediumCol IS "">
			MediumCol = NULL ,
		<cfelse>
			MediumCol = #ThisMediumcol# , <!--- NULL or numeric between 1 and 99 --->
		</cfif>
		<cfif ThisShortcol IS "">
			ShortCol = NULL ,
		<cfelse>
			ShortCol = '#ThisShortcol#',
		</cfif>
		
		<cfif Form.Notes IS "">
			Notes = NULL 
		<cfelse>
			Notes = '#TRIM(Form.Notes)#'
		</cfif>
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
