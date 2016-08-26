<!--- called by UploadLeagueDocs_PDF.cfm --->
<cfquery name="InsrtLeaguedocs" datasource="zmast" >
	INSERT INTO leaguedocs 
		(LeagueCodePrefix, Description, FileName, Extension, GroupName)
	VALUES 
		('#LeagueCodePrefix#', '#form.Description#', '#cffile.clientFileName#', 'pdf', '999999')	
</cfquery>
