<!---
index3.cfm
Purpose:	final processing page, which calls all other loops
			and displays success (and failed imports)
Created:	14 July 2004
By:			Terry Riley
Called by:	link from index2.cfm
Calls:		queries/qry_getmdbs.cfm
			queries/qry_import.cfm (the main import loop)
			queries/qry_update_nulls.cfm
			header.cfm
			footer.cfm
Links to:	index.cfm
Notes:		Lists unimported databases (usually unregistered with CFAdmin)
--->

<cfinclude template="queries/qry_getmdbs.cfm">

<cftry>
	<cfinclude template="queries/qry_add_temp_fields.cfm">
	<cfcatch>
		<!--- with no action, it will ignore the error if fields already in place --->
	</cfcatch>
</cftry>

<cfinclude template="queries/qry_import.cfm">

<cfinclude template="queries/qry_update_nulls.cfm">

<cftry>
	<cfinclude template="queries/qry_delete_temp_fields.cfm">
	<cfcatch>
		Oh, Bugger!! Delete temp fields failed
		<cfabort>
	</cfcatch>
</cftry>

<cfinclude template="header.cfm">

<p><a href="index.cfm">Back to Main Page</a></p>

<p><strong><span class="textred">Transfers Complete!</span></strong>
<cfif ListLen(application.failedlist)>
<br /><br />
The following mdbs were NOT imported, possibly because they are not registered with CF Administrator:
<br /><br />
<cfoutput>#application.failedlist#</cfoutput>
<br /><br />
If they should be imported, ensure they are listed as datasources, then run this again.
</cfif>
</p>

<cfinclude template="footer.cfm">