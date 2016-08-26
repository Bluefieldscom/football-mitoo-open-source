<!---
qry_import.cfm
Purpose:	The main loop to process Access databases
Created:	14 July 2004
By:			Terry Riley
Calls:		qry_import_process.cfm as a module
Passes:		item from FilteredList, which equates to a CF Admin DSN
Called by:	index3.cfm
Notes:		none
--->

<cfloop list="#variables.FilteredList#" index="i">
	<cfmodule template="qry_import_process.cfm" source=#i#>
</cfloop>
