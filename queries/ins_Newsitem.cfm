<!--- called by Action.cfm --->

<cfquery name="QInsrtNewsitemRecord" datasource="#request.DSN#" >
	INSERT INTO 
		newsitem 
	(LongCol, MediumCol, ShortCol, Notes, LeagueCode)
	VALUES 
		(
		'#ThisLongcol#',
		<cfif ThisMediumCol IS "">
			NULL ,
		<cfelse>
			#ThisMediumcol# , <!--- NULL or numeric between 1 and 99 --->
		</cfif>
		<cfif ThisShortcol IS "">
			NULL ,
		<cfelse>
			'#ThisShortcol#',
		</cfif>
		
		<cfif Form.Notes IS "">
			NULL ,
		<cfelse>
			'#TRIM(Form.Notes)#',
		</cfif>
	
		<cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		)
</cfquery>
