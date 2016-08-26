<!---
qry_getmdbs.cfm
Purpose:	creates list of mdbs already imported
			and list of relevant mdbs available in the data directory
			and provides filtered (not-imported) list - MBList
Created:	14 July 2004
Called by:	index2.cfm and dsp_process_stage2.cfm
Calls:		header.cfm
			footer.cfm
Links to:	index.cfm (on error)			
By:			Terry Riley
Notes:		none
--->
<cftry>
	<cfquery name="GetImported" datasource="#application.DSN#">
		SELECT DISTINCT LeagueCode FROM Constitution
	</cfquery>
	<cfcatch type="Database">
		<cfinclude template="../header.cfm">
		<strong>Error!</strong>
		<p>
		Either <cfoutput>#application.DSN#</cfoutput> has not been created and registered with CFAdmin,
		<br />or its Constitution table is missing
		</p>
		<p>
		<a href="index.cfm">Return to Index page</a>
		</p>
		<cfinclude template="../footer.cfm">
		<cfabort>
	</cfcatch>
</cftry>
<cfset ImportedList = ValueList(Getimported.LeagueCode)>

<cfset yearfilter = RIGHT(application.year,2)>
<cfif yearfilter IS '00'>
	<cfset yearfilter = ''>
</cfif>

<cfoutput>
<cfdirectory action="LIST" 
	directory="#application.dataroot#" 
	name="GetMDBs" 
	filter="*#yearfilter#.mdb">
</cfoutput>

<cfif yearfilter IS ''>
	<cfset MDBList = ''>
	<cfloop query="GetMDBs">
		<cfif Find('99', Name) OR Find('01', Name) OR Find('02',Name) OR Find('03', Name) OR Find('04', Name) OR Find('ZMAST', Name) OR Find('db', Name)>
		<!--- do nothing --->
		<cfelse>
			<cfset MDBList = ListAppend(MDBList, Name)><!--- includes '.mdb' --->
		</cfif>
	</cfloop>
<cfelse>
	<cfset MDBList = ValueList(GetMDBs.Name)><!--- includes '.mdb' --->
</cfif>

<cfset variables.FilteredList = ''>
<cfset variables.NumberToImport = 0>
<cfloop list="#MDBList#" index="i">
	<cfif RIGHT(application.year,2) IS '00'>
		<cfif NOT ListFindNoCase(ImportedList, Replace(UCASE(TRIM(i)), '.MDB', ''))>
			<cfset variables.FilteredList = ListAppend(variables.FilteredList, UCASE(ListGetAt(i,1,'.')))>
			<!--- <cfset variables.NumberToImport = variables.NumberToImport+1> --->
		</cfif>
	<cfelse>
		<cfif NOT ListFindNoCase(ImportedList, Replace(UCASE(TRIM(i)), RIGHT(application.year,2) & '.MDB', ''))>
			<cfset variables.FilteredList = ListAppend(variables.FilteredList, UCASE(ListGetAt(i,1,'.')))>
			<!--- <cfset variables.NumberToImport = variables.NumberToImport+1> --->
		</cfif>
	</cfif>
</cfloop>

<cfset variables.NumberToImport = ListLen(variables.FilteredList)>

