<!--- called by UploadLeagueDocs_XLS.cfm --->
<cfquery name="InsrtLeaguedocs" datasource="zmast" >
	INSERT INTO leaguedocs 
		(LeagueCodePrefix, Description, FileName, Extension, GroupName)
	VALUES 
		('#LeagueCodePrefix#', '#form.Description#', '#cffile.clientFileName#', 'xls', '999999')	
</cfquery>
