<!---
qry_checkTarget.cfm
Purpose:	verify that the MySQL database in question is registered with CF Admin
Created:	14 July 2004
By:			Terry Riley
Called by:	index.cfm
Notes:		cfcatch creates variable that is read in dsp_process_stage2.cfm
--->
<cfset variables.targetexists = 1>

<cftry>
	<cfquery name="checkMySQL" datasource="#application.DSN#">
		SELECT max(ID) FROM Constitution
	</cfquery>
	<cfcatch>
		<cfset variables.targetexists = 0>
	</cfcatch>
</cftry>
