<!--- called by Action.cfm --->
<cfif UCASE(TRIM(Form.longcol)) IS "NOTICE" >
	<!--- do not add if there is already a NOTICE for this league --->
	<cfif form.Operation IS "Add" OR form.Operation IS "Add Many">
		<cfinclude template="queries/qry_NOTICENewsitem.cfm">	
		<cfif QNOTICENewsitem.RecordCount GT 0>
			<cfinclude template="ErrorMessages/Action/Only_one_NOTICE_NewsItem_is_allowed.htm">
			<cfabort>
		</cfif>
	<cfelseif form.Operation IS "Update" >
		<cfinclude template="queries/qry_NOTICENewsitem.cfm">	
		<cfif QNOTICENewsitem.RecordCount GT 1>
			<cfinclude template="ErrorMessages/Action/Only_one_NOTICE_NewsItem_is_allowed.htm">
			<cfabort>
		</cfif>
	</cfif>
	<cfset ThisLongcol = "NOTICE" >
	<cfset ThisMediumcol = "">
	<cfset ThisShortcol = "">
	<cfif Form.Notes IS "">
	<cfelse>
		<cfset Form.Notes = '#REReplace(Form.Notes, "<[^>]*>", "", "All")#'>
	</cfif>
<cfelse>
	<cfif LEN(TRIM(Form.longcol)) IS 0 >
		<cfinclude template="ErrorMessages/Action/Headline_missing.htm">
		<cfabort>
	</cfif>
	<cfset ThisLongcol = TRIM(Form.longcol) >
	<cfset ThisLongcol = REReplace(ThisLongcol, "<[^>]*>", "", "All")>
	
	<cfif LEN(TRIM(Form.mediumcol)) IS 0 >
		<cfinclude template="ErrorMessages/Action/SortOrder_missing.htm">
		<cfabort>
	</cfif>
	<cfset ThisMediumcol = TRIM(Form.mediumcol) >
	<cfif NOT IsNumeric(ThisMediumcol) >
		<cfinclude template="ErrorMessages/Action/SortOrder_error.htm">
		<cfabort>
	</cfif>
	

	<cfif ThisMediumcol GT 0 AND ThisMediumcol LT 100 ><!--- must be in range 1 to 99 --->
	<cfelse>
		<cfinclude template="ErrorMessages/Action/SortOrder_error.htm">
		<cfabort>
	</cfif>
	
	<cfif LEN(TRIM(Form.shortcol)) IS 0 >
		<cfset ThisShortcol = "">
	<cfelseif UCASE(TRIM(Form.shortcol)) IS "HIDE">
		<cfset ThisShortcol = "HIDE">
	<cfelse>
		<cfinclude template="ErrorMessages/Action/Shortcol_error.htm">
		<cfabort>
	</cfif>
	
	
</cfif>


