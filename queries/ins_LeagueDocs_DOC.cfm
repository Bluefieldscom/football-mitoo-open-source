<!--- called by UploadLeagueDocs_DOC.cfm --->
<cfquery name="InsrtLeaguedocs" datasource="zmast" >
	INSERT INTO leaguedocs 
		(LeagueCodePrefix, Description, FileName, Extension, GroupName)
	VALUES 
		('#LeagueCodePrefix#', '#form.Description#', '#cffile.clientFileName#', 'doc', '999999')	
</cfquery>
