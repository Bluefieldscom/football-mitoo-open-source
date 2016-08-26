<!---
<cfquery name="DelBanned" datasource="zmast">
	DELETE FROM 
		banned
	WHERE 
		CountyID = 1
</cfquery>
--->

<cfquery Name="QBanned" datasource="rule12">
	SELECT
		Surname,
		Forename,
		DateOfBirth,
		StartDate,
		Address,
		npd
	FROM
		thistable
</cfquery>

<cfoutput query="QBanned">
	<cfquery Name="InsertBanned"  datasource="zmast">
		INSERT INTO banned (CountyID, Surname, Forename, DateOfBirth, StartDate, Address, npd)
			values
				(1,
				'#Surname#',
				'#Forename#',
				<cfif IsDate(DateOfBirth)>'#DateOfBirth#'<cfelse>NULL</cfif>,
				<cfif IsDate(StartDate)>'#StartDate#'<cfelse>NULL</cfif>,
				'#Address#',
				#npd#)
	</cfquery>
</cfoutput>

