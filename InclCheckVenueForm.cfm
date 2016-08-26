<!--- called by Action.cfm --->

<cfinclude template="check_for_empty.cfm">


<cfset InputFieldsConcatenated = "#Form.LongCol##Form.MediumCol#">

<cfif FindNoCase(",", InputFieldsConcatenated) GT 0>
	<cfinclude template="ErrorMessages/Action/Commas_not_allowed.htm">
	<cfabort>
</cfif>

<cfif FindNoCase('"', InputFieldsConcatenated) GT 0>
	<cfinclude template="ErrorMessages/Action/doublequotes_not_allowed.htm">
	<cfabort>
</cfif>
