<!---
qry_update_nulls.cfm
Purpose:	processing loop for setting empty fields (necessarily
			imported as such via CSV files) to NULL where required
Created:	14 July 2004
By:			Terry Riley
Calls:		update_nulls_fmxxxx.cfm as required
Passes:		nothing
Called by:	index3.cfm
Notes:		This will only work on Char/Text fields where an empty value will
		    be inserted as such?
--->
<cfswitch expression = #application.year#>
	<cfcase value="1999">
		<cfmodule template="update_nulls_fm1999.cfm">
	</cfcase>
	<cfcase value="2000">
		<cfmodule template="update_nulls_fm2000.cfm">
	</cfcase>
	<cfcase value="2001">
		<cfmodule template="update_nulls_fm2001.cfm">
	</cfcase>
	<cfcase value="2002">
		<cfmodule template="update_nulls_fm2002.cfm">
	</cfcase>
	<cfcase value="2003">
		<cfmodule template="update_nulls_fm2003.cfm">
	</cfcase>
	<cfcase value="2004">
		<cfmodule template="update_nulls_fm2004.cfm">
	</cfcase>				
</cfswitch>
