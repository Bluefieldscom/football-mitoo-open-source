<!--- called by action.cfm --->

<!--- Never allow commas in any field, it messes up lists --->
<cfif TblName IS "Player">
	<cfset InputFieldsConcatenated = "#Form.Surname##Form.Forename##Form.MediumCol##Form.ShortCol#">
<cfelseif TblName IS "Referee"> 
	<cfset InputFieldsConcatenated = "#Form.Surname##Form.Forename#">
<cfelseif TblName IS "Committee"> 
	<cfset InputFieldsConcatenated = "#Form.Surname##Form.Forename#">
<cfelse>
	<cfset InputFieldsConcatenated = 
	"#Form.LongCol##Form.MediumCol##Form.ShortCol#">
</cfif>

<cfif FindNoCase(",", InputFieldsConcatenated) GT 0>
	<cfinclude template="ErrorMessages/Action/Commas_not_allowed.htm">
	<CFABORT>
</cfif>

<cfif FindNoCase('"', InputFieldsConcatenated) GT 0>
	<cfinclude template="ErrorMessages/Action/doublequotes_not_allowed.htm">
	<CFABORT>
</cfif>
