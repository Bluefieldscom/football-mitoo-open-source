<!--- called by queries upd_TeamDetails.cfm --->
<cfquery name="InsertTeamDetailsUpdateLog" datasource="#request.DSN#" >
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
		(1,
		'teamdetails', 
		#ThisTeamID#,
		#ThisOrdinalID#,
		NULL,
		'#ThisFieldName#', 
		'#BeforeValue#',
		'#AfterValue#',
		'#request.filter#',
		'#SecurityLevel#'
		 )
</cfquery>

