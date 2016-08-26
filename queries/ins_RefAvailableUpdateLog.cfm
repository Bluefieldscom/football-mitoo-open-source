<!--- called by queries ins_RefAvailable.cfm, upd_RefAvailable and del_RefAvailable.cfm --->
<cfquery name="InsertRefAvailableUpdateLog" datasource="#request.DSN#" >
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
		(3,
		'refavailable', 
		NULL,
		#ThisRefereeID#,
		'#DateFormat(ThisMatchDate,"YYYY-MM-DD")#',		
		'#ThisFieldName#', 
		'#BeforeValue#',
		'#AfterValue#',
		'#request.filter#',
		'#SecurityLevel#')
</cfquery>

