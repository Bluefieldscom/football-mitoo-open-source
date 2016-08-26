<!--- called from action --->

<cfif TblName IS "Player">
	<cfif StructKeyExists(Form,"Surname") AND TRIM(Form.Surname) IS "">
		<!--- Never allow an empty "Surname" field  --->
		<cfinclude template="ErrorMessages/Action/Empty_first_field_not_allowed.htm">
		<CFABORT>
	</cfif>
<cfelseif TblName is "Referee" >
	<cfif StructKeyExists(Form,"Surname") AND TRIM(Form.Surname) IS "">
		<!--- Never allow an empty "Surname" field  --->
		<cfinclude template="ErrorMessages/Action/Empty_first_field_not_allowed.htm">
		<CFABORT>
	</cfif>
<cfelseif TblName is "Committee" >
	<cfif StructKeyExists(Form,"Surname") AND TRIM(Form.Surname) IS "">
		<!--- Never allow an empty "Surname" field  --->
		<cfinclude template="ErrorMessages/Action/Empty_first_field_not_allowed.htm">
		<CFABORT>
	</cfif>
<cfelseif TblName is "Division" >
	<cfif StructKeyExists(Form,"LongCol") AND TRIM(Form.LongCol) IS "">
		<!--- Never allow an empty "LongCol" field (except players) --->
		<cfinclude template="ErrorMessages/Action/Empty_first_field_not_allowed.htm">
		<CFABORT>
	</cfif>
	<cfif StructKeyExists(Form,"MediumCol") AND TRIM(Form.MediumCol) IS "">
		<cfinclude template="ErrorMessages/Action/Empty_second_field_not_allowed.htm">
		<CFABORT>
	</cfif>
	<cfif StructKeyExists(Form,"ShortCol") AND TRIM(Form.ShortCol) IS "">
		<cfinclude template="ErrorMessages/Action/Empty_third_field_not_allowed.htm">
		<CFABORT>
	</cfif>
<cfelse>
	<cfif StructKeyExists(Form,"LongCol") AND TRIM(Form.LongCol) IS "">
		<!--- Never allow an empty "LongCol" field (except players) --->
		<cfinclude template="ErrorMessages/Action/Empty_first_field_not_allowed.htm">
		<CFABORT>
	</cfif>
</cfif>
