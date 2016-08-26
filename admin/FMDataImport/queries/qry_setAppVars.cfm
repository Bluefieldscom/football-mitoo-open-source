<!---
qry_setAppVArs.cfm
Purpose:	set user-definable application vars
			and reset the failed list
Created:	14 July 2004
By:			Terry Riley
Called by:	index.cfm
Notes:		none
--->

<cflock scope="application" type="exclusive" timeout="10">
	<cfscript>
		application.DSN = 'FM'&'#TRIM(form.to_year)#';
		application.year = '#TRIM(form.from_year)#';
		application.newyear = '#TRIM(form.to_year)#';
		application.failedlist = '';
	</cfscript>
</cflock>
