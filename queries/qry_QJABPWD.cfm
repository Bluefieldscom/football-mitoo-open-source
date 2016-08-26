<!--- called by SecurityCheck.cfm --->
<cfquery name="QPWDJulian" datasource="zmast" > <!--- Julian's --->
	SELECT pwd FROM identity WHERE leaguecodeprefix IS NULL and Name = 'Julian';
</cfquery>
<cfset JABPWD = TRIM(QPWDJulian.pwd) >

