<!--- called by Action.cfm --->

<cfif LEN(TRIM(Form.surname)) IS 0 >
	<cfinclude template="ErrorMessages/Action/Surname_missing.htm">
	<cfabort>
</cfif>

<cfif LEN(TRIM(Form.forename)) IS 0 >
	<cfinclude template="ErrorMessages/Action/Forename_missing.htm">
	<cfabort>
</cfif>

<cfif LEN(TRIM(Form.longcol)) IS 0 >
	<cfinclude template="ErrorMessages/Action/Position_on_Committee_missing.htm">
	<cfabort>
</cfif>

<cfset Form.title = TRIM(Form.title) >
<cfset Form.surname = TRIM(Form.surname) >
<cfset Form.forename = TRIM(Form.forename) >

<cfset InputFieldsConcatenated = "#Form.title##Form.forename##Form.surname#">

<cfif FindNoCase(",", InputFieldsConcatenated) GT 0>
	<cfinclude template="ErrorMessages/Action/Commas_not_allowed.htm">
	<cfabort>
</cfif>

<cfif FindNoCase('"', InputFieldsConcatenated) GT 0>
	<cfinclude template="ErrorMessages/Action/doublequotes_not_allowed.htm">
	<cfabort>
</cfif>
