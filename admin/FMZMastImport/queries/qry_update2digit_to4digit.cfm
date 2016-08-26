<!--- 
qry_update2digit_to4digit.cfm
Purpose:		Special one-off to be used after all imports are complete
				takes all of the MDX02-type and turns them into MDX2002.
				This makes it easier to split prefix from suffix when grabbing
				data from the relevant database (see datatest.cfm in the main app)
Created by:		Terry Riley
On:				14 July 2004
Calls:			nothing
Called by:		index.cfm (once!)
Notes:			special processing for year 2000
--->


<cfquery name="update99" datasource="ZMAST">
	UPDATE leagueinfo
	SET defaultleaguecode = CONCAT(LEFT(defaultleaguecode,LENGTH(defaultleaguecode)-2),'1999')
	WHERE RIGHT(defaultleaguecode,2) = '99'
</cfquery>

<cfquery name="update00" datasource="ZMAST">
	UPDATE leagueinfo
	SET defaultleaguecode = CONCAT(defaultleaguecode,'2000')
	WHERE NOT RIGHT(defaultleaguecode,2)+0 
</cfquery>

<cfquery name="update01" datasource="ZMAST">
	UPDATE leagueinfo
	SET defaultleaguecode = CONCAT(LEFT(defaultleaguecode,LENGTH(defaultleaguecode)-2),'2001')
	WHERE RIGHT(defaultleaguecode,2) = '01'
</cfquery>

<cfquery name="update02" datasource="ZMAST">
	UPDATE leagueinfo
	SET defaultleaguecode = CONCAT(LEFT(defaultleaguecode,LENGTH(defaultleaguecode)-2),'2002')
	WHERE RIGHT(defaultleaguecode,2) = '02'
</cfquery>

<cfquery name="update03" datasource="ZMAST">
	UPDATE leagueinfo
	SET defaultleaguecode = CONCAT(LEFT(defaultleaguecode,LENGTH(defaultleaguecode)-2),'2003')
	WHERE RIGHT(defaultleaguecode,2) = '03'
</cfquery>

<cfquery name="update04" datasource="ZMAST">
	UPDATE leagueinfo
	SET defaultleaguecode = CONCAT(LEFT(defaultleaguecode,LENGTH(defaultleaguecode)-2),'2004')
	WHERE RIGHT(defaultleaguecode,2) = '04'
</cfquery>


