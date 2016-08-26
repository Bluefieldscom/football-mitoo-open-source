<!--- called by UploadLeaguePics_JPG.cfm --->
<cfquery name="InsrtLeaguepics" datasource="zmast" >
	INSERT INTO leaguepics 
		(LeagueCodePrefix, Description, FileName, Extension)
	VALUES 
		('#LeagueCodePrefix#', '#form.Description#', '#cffile.clientFileName#', 'jpg')	
</cfquery>
