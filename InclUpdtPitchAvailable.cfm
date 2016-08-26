<!--- called by Action.cfm --->
<!--- 
<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfinclude template="queries/qry_QPitchAvailable2.cfm">
 --->
 
<!--- if there is no change in key fields --->
<!--- 
<cfif
	QPitchAvailable2.TeamID IS Form.TeamID AND
	QPitchAvailable2.OrdinalID IS Form.OrdinalID AND
	QPitchAvailable2.PitchNoID IS Form.PitchNoID >
	<!--- don't bother to check for duplicates --->
<cfelse>
<!--- If there's been a change in TeamID, OrdinalID or DivisionID
Check to see if this combination is already in the Constitution --->
	<cfinclude template="queries/qry_QCheckDuplicateHG.cfm">
	<cfif QCheckDuplicateHG.RecordCount IS NOT "0">	
		<cfoutput query="QCheckDuplicateHG">
			<cfif PitchName IS "">
				<span class="pix24boldred">#TeamName# #OrdinalName# is already using this Home Ground<BR><BR></span>
			<cfelse> 
				<span class="pix24boldred">#TeamName# #OrdinalName# is already using pitch #PitchName# as its Home Ground<BR><BR></span>
			</cfif>
		</cfoutput>
		<CFABORT>
	</cfif>
</cfif>
--->

<cfinclude template="queries/upd_PitchAvailable.cfm">

