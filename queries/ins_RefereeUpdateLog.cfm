<!--- called by Action.cfm --->
<cfquery name="InsertRefereeUpdateLog" datasource="#request.DSN#" >
	INSERT INTO updatelog 
		(SortOrder,
		TableName, 
		ID1,
		ID2,
		Date1,
		FieldName, 
		BeforeValue, 
		AfterValue, 
		LeagueCode,
		SecurityLevel	)
	VALUES
		(2,
		'referee', 
		#ThisRefereeID#,
		NULL,
		NULL, 
		'#ThisFieldName#',
		<cfif ThisFieldName IS 'DateOfBirth'>
			'#DateFormat(BeforeValue,'DD-MM-YYYY')#',
		<cfelse>
			'#BeforeValue#',
		</cfif>
		<cfif ThisFieldName IS 'DateOfBirth'>
			'#DateFormat(AfterValue,'DD-MM-YYYY')#',
		<cfelse>
			'#AfterValue#',
		</cfif>
		'#request.filter#',
		'#SecurityLevel#' )
</cfquery>

