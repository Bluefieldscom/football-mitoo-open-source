<!--- called by InclInsrtLookUp.cfm --->
		  
<cfquery name="InsrtLookUpTblName" datasource="marketplace" >
	INSERT INTO noticeboard 
	(
	Hide, 
	ShowEverywhere, 
	ShowForTheseCounties, 
	ShowForTheseLeagues, 
	Priority, 
	StartDate, 
	EndDate, 
	ImageFile, 
	AdvertTitle, 
	AdvertHTML, 
	EmailAddr, 
	ContactName, 
	TelephoneNumbers, 
	Notes
	) 
	VALUES 
	(
			<cfif StructKeyExists(form, "Hide")>
			'1'
			<cfelse>
			'0'
			</cfif>,
			<cfif StructKeyExists(form, "ShowEverywhere")>
			'1'
			<cfelse>
			'0'
			</cfif>,
			'#ShowForTheseCounties#', 
			'#ShowForTheseLeagues#', 
			'#Priority#', 
			<cfif form.StartDate IS "">
				NULL,
			<cfelse>
				#CreateODBCDate(StartDate)# ,
			</cfif>
			<cfif form.EndDate IS "">
				NULL,
			<cfelse>
				#CreateODBCDate(EndDate)# ,
			</cfif>
			'#ImageFile#', 
			'#AdvertTitle#', 
			'#AdvertHTML#', 
			'#EmailAddr#', 
			'#ContactName#', 
			'#TelephoneNumbers#', 
			'#Notes#'
	)
</cfquery>
