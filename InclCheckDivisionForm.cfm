<!--- called by Action.cfm --->

<cfinclude template="check_for_empty.cfm">
<cfinclude template="check_for_commas_and_quotes.cfm">



<cfset Form.Notes = TRIM(Form.Notes) >

<cfif FindNoCase("No Replays", Form.Notes) GT 0>
	<cfinclude template="ErrorMessages/Action/No_Replays_not_allowed.htm">
	<cfabort>
</cfif>
<cfif FindNoCase("NoReplays", Form.Notes) GT 0 AND FindNoCase("MatchNumbers", Form.Notes) IS 0 AND FindNoCase("KO", Form.Notes) IS 0>
	<cfinclude template="ErrorMessages/Action/NoReplays_only_with_matchnumbers.htm">
	<cfabort>
</cfif>

<cfif FindNoCase('"', Form.Notes) GT 0>
	<cfinclude template="ErrorMessages/Action/doublequotes_not_allowed.htm">
	<cfabort>
</cfif>
<cfif FindNoCase('HideDivision', Form.Notes) GT 0 AND FindNoCase('HideGoals', Form.Notes) GT 0>
	<cfinclude template="ErrorMessages/Action/HideDivision_HideGoals_not_allowed.htm">
	<cfabort>
</cfif>
<cfif FindNoCase('HideDivision', Form.Notes) GT 0 AND FindNoCase('HideGoalDiff', Form.Notes) GT 0>
	<cfinclude template="ErrorMessages/Action/HideDivision_HideGoalDiff_not_allowed.htm">
	<cfabort>
</cfif>
