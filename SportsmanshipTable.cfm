<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfset SportsTable = "Yes">  <!--- a switch to tell the Heading in Toolbar2 that it's a Sportsmanship Table --->

<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">
<cfset SortOrder = "HighAtTop">
<cfif StructKeyExists(url, "Order")>
	<cfif URL.Order IS "LowAtTop">
		<cfset SortOrder = "LowAtTop">
	</cfif>
</cfif>

<cfinclude template = "queries/qry_QSportsmanshipTable1.cfm">

<cfinclude template = "queries/qry_QSportsmanshipTable2.cfm">

<cfif QSportsmanshipTable2.RecordCount IS 0>
	<cfoutput>
		<span class="pix13">
			<b><BR>Sportsmanship marks have not been awarded to any team.</b>
		</font>
	</cfoutput>
	
<cfelse>

	<cfoutput>
		<BR>
		<table border="1" cellspacing="2" cellpadding="2" align="CENTER">
			<tr>
				<td><span class="pix13">&nbsp;</span></td>
				<td align="CENTER"><span class="pix13bold">Team</span></td>
				<td align="CENTER"><span class="pix13bold">Number of<BR>Marked Games</span></td>
				<td align="CENTER"><span class="pix13bold">Average<BR>Marks</span></td>
			</tr>
	</cfoutput>
	
	<cfoutput query="QSportsmanshipTable2">
			<tr>
				<td <cfif session.fmTeamID IS TeamID >class="bg_highlight"</cfif> ><span class="pix13bold">#CurrentRow#</span></td>
				<td <cfif session.fmTeamID IS TeamID >class="bg_highlight"</cfif> align="Left"><span class="pix13">#TeamName# #OrdinalName#</span></td>
				<td <cfif session.fmTeamID IS TeamID >class="bg_highlight"</cfif> align="CENTER"><span class="pix13">#NumberFormat(TotalMarkedGames, "999")#</span></td>
				<td <cfif session.fmTeamID IS TeamID >class="bg_highlight"</cfif> align="CENTER"><span class="pix13">#NumberFormat(SportsmanshipMarks, "99.99")#</span></td>
			</tr>
	</cfoutput>

		</table>
</cfif>
