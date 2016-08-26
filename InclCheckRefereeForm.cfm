<!--- called by Action.cfm --->

<cfinclude template="check_for_empty.cfm">
<cfinclude template="check_for_commas_and_quotes.cfm">
<!---
<cfif LEN(TRIM(Form.surname)) IS 0 >
	<cfinclude template="ErrorMessages/Action/Player_Surname_is_missing.htm">
	<cfabort>
</cfif>

<cfif LEN(TRIM(Form.forename)) IS 0 >
	<cfinclude template="ErrorMessages/Action/Player_Forename_is_missing.htm">
	<cfabort>
</cfif>
--->

<cfset datestring = "#form.DOB_YYYY##form.DOB_MM##form.DOB_DD#" >

<cfif LEN(TRIM(datestring)) IS 0 >
	<cfset form.DateOfBirth = "">
<cfelse>
	<cfif LEN(TRIM(form.DOB_DD)) IS 0 >
		<cfinclude template="ErrorMessages/Action/Date_of_Birth_format.htm">
		<cfabort>
	</cfif>
	<cfif LEN(TRIM(form.DOB_MM)) IS 0 >
		<cfinclude template="ErrorMessages/Action/Date_of_Birth_format.htm">
		<cfabort>
	</cfif>
	<cfif LEN(TRIM(form.DOB_YYYY)) IS 0 >
		<cfinclude template="ErrorMessages/Action/Date_of_Birth_format.htm">
		<cfabort>
	</cfif>

	<cfset form.DateOfBirth = "#form.DOB_YYYY#-#form.DOB_MM#-#form.DOB_DD#" >
</cfif>



<cfif LEN(Form.DateOfBirth) GT 0 AND NOT IsDate(form.DateOfBirth)>
	<cfinclude template="ErrorMessages/Action/Date_of_Birth_format.htm">
	<cfabort>
</cfif>

<!---
<cfif LEN(TRIM(Form.ShortCol)) IS 0 >
	<cfinclude template="ErrorMessages/Action/Player_Registration_Number_is_missing.htm">
	<cfabort>
</cfif>
<cfif NOT IsNumeric(Form.ShortCol)  >
	<cfinclude template="ErrorMessages/Action/Player_Registration_Number_must_be_numeric.htm">
	<cfabort>
</cfif>
--->

<cfset Form.surname = TRIM(Form.surname) >
<cfset Form.forename = TRIM(Form.forename) >

<cfset InputFieldsConcatenated = "#Form.surname##Form.forename#">

<cfif FindNoCase(",", InputFieldsConcatenated) GT 0>
	<cfinclude template="ErrorMessages/Action/Commas_not_allowed.htm">
	<cfabort>
</cfif>

<cfif FindNoCase('"', InputFieldsConcatenated) GT 0>
	<cfinclude template="ErrorMessages/Action/doublequotes_not_allowed.htm">
	<cfabort>
</cfif>
