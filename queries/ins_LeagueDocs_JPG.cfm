<!--- called by UploadLeagueDocs_JPG.cfm --->
<cfquery name="InsrtLeaguedocs" datasource="zmast" >
	INSERT INTO leaguedocs 
		(LeagueCodePrefix, Description, FileName, Extension, GroupName)
	VALUES 
		('#LeagueCodePrefix#', '#form.Description#', '#cffile.clientFileName#', 'jpg', '999999')	
</cfquery>
