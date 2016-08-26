<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=RefAvailability.xls">
<cfset ThisColSpan = 4 >
<cfoutput>
	<table border="1">
		<tr> <td width="100%" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top" bgcolor="silver"><strong>#LeagueName#</strong></td></tr>
		<tr> <td width="100%"  colspan="#ThisColSpan#" align="center" valign="top"><strong>Referee Availability #DateFormat(MDate,'DDDD, DD MMMM YYYY')#</strong></td></tr>
	</table>
</cfoutput>
<cfset SortSeq = "Name">
<cfinclude template="queries/qry_RefAvailability.cfm">

	<cfoutput>
		<table border="1">
			<tr bgcolor="silver">
				<td>Level</td>
				<td>RefsName</td>
				<td>Availability</td>
				<td>Details</td>
				
			</tr>
	</cfoutput>

		<cfoutput query="RefAvailability">
			<tr>
				<td valign="top"><span class="pix13">#Level#</span></td>
				<td valign="top"><span class="pix13">#RefsName#</span></td>
				<td valign="top"><span class="pix13"><cfif AvailabilityNotes IS "">Unknown<cfelse>#AvailabilityNotes#</cfif></span></td>
				<td valign="top"><span class="pix13">#RefDetails#</span></td>
			</tr>
		</cfoutput>
</table>
