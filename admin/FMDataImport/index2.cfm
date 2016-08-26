<!---
index2.cfm
Purpose:	Set application variables and list settings from index.cfm
Created:	14 July 2004
By:			Terry Riley
Called by:	link from index.cfm
Calls:		queries/qry_getmdbs.cfm
			header.cfm
			footer.cfm
Links to:	index.cfm
			and either index3.cfm (if there are imports)
			or queries/qry_truncatedb.cfm (which truncates and returns to index.cfm)
Notes:		Lists databases to be imported (10 across)
			by comparing the contents of ImportedList with the directory listing 
			for the year in process
			Optionally, if there are no more imports, allows for truncation of the
			MySQL database and restart
--->

<!--- this creates FilteredList of importable mdbs for the set year 
and a listcount --->
<cfinclude template="queries/qry_getmdbs.cfm">

<cfinclude template="header.cfm">

<p>
<a href="index.cfm">Return to re-set variables</a>
</p>

<cfset itemcount = 0>

<div>
<table width="600px" border=0>
<cfif variables.NumberToImport GT 0>
	<tr>
		<td colspan=10>
		<cfoutput>
			Access MDBs available for import from year <strong>#application.year#</strong> to <strong>#application.DSN#</strong>
<br />(if it's not here, it has already been imported!).
		</cfoutput>
		</td>
	</tr>
	<tr>
		<td colspan=10>
			If you want to zap the <cfoutput><strong>#application.DSN#</strong></cfoutput> database and start again, click <a href="queries/qry_truncatedb.cfm"><em><strong>here</strong></em></a>
		</td>
	</tr>
	<tr>
		<td colspan=10>
			The mdbs listed below will be imported when you click <a href="index3.cfm"><em><strong>here</strong></em></a>
		</td>
	</tr>
	<tr><td colspan=10>&nbsp;</td></tr>
	<tr>
	<cfloop list="#variables.filteredlist#" index="i">
		<td><cfoutput><strong>#i#</strong></cfoutput></td>
			<cfset itemcount = itemcount+1>
	<cfif itemcount MOD 10 IS 0>
	</tr>
	</cfif>
	</cfloop>
	</tr>
<cfelse>
	<tr>
		<td colspan=10>
			No further MDBs available for the import from year <cfoutput><strong>#application.year#</strong></cfoutput> to <cfoutput><strong>#application.DSN#</strong></cfoutput>
		</td>
	</tr>
	<tr>
		<td colspan=10>
			If you want to zap the <cfoutput><strong>#application.DSN#</strong></cfoutput> database and start again, click <a href="queries/qry_truncatedb.cfm"><em><strong>here</strong></em></a>
		</td>
	</tr>
</cfif>
</table>
</div>

<cfinclude template="footer.cfm">	
