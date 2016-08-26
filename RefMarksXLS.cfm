<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfsetting enablecfoutputonly="yes">
<CFCONTENT type="application/msexcel">
<cfheader name="Content-Disposition" value="filename=Fixtures.xls">
<cfset ThisColSpan = 13 >
<cfoutput>
<table border="1">
	<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>#SeasonName#</strong></td></tr>
	<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>#LeagueName#</strong></td></tr>
	<tr> <td height="30" colspan="#ThisColSpan#" align="center" valign="top"><strong>Period from #DateFormat(Date01, 'DD MMMM YYYY')# to #DateFormat(Date02, 'DD MMMM YYYY')#</strong></td></tr>

	<tr> 
		<td  height="20" colspan="1" rowspan="2" align="center" valign="top">Parent County</td>
		<td  height="20" colspan="1" rowspan="2" align="center" valign="top">Referee</td>
		<td height="20" colspan="2" align="center" valign="top">Marks</td>
		<td height="20" colspan="2" align="center" valign="top">Sports</td>
		<td  height="20" colspan="1" rowspan="2" align="center" valign="top">Date</td>
		<td  height="20" colspan="1" rowspan="2" align="center" valign="top">Competition</td>
		<td  height="20" colspan="1" rowspan="2" align="center" valign="top">Round</td>
		<td height="20" colspan="2" align="center" valign="top"><strong>Home</strong></td>
		<td height="20" colspan="2" align="center" valign="top"><strong>Away</strong></td>
	</tr>
	<tr>
		<td>Home</td>
		<td>Away</td>
		<td>Home</td>
		<td>Away</td>
		<td>Team</td>
		<td>Goals</td>
		<td>Team</td>
		<td>Goals</td>
	</tr>
</table>
</cfoutput>
<cfinclude template="queries/qry_QFixtures_v13.cfm">
	<cfset TotalHMarks = 0 >
	<cfset TotalAMarks = 0 >
	<cfset Denominator = 0>
<cfoutput>
<table border="1">

</cfoutput>
<cfoutput query="QFixtures" group="RefsName">
	<cfoutput >
	<tr>
		<td>#ParentCounty#</td>
		<td><cfif LTRIM(RTRIM(RefsName)) IS "">&nbsp;<cfelse>#RefsName#</cfif></td>
		<td align="center" <cfif IsNumeric(RefereeMarksH)><cfelse>bgcolor="red"</cfif> >#RefereeMarksH#</td>
		<td align="center" <cfif IsNumeric(RefereeMarksA)><cfelse>bgcolor="red"</cfif> >#RefereeMarksA#</td>
		
		<td align="center" bgcolor="##FFFFCC">#HomeSportsmanshipMarks#</td> 
		<td align="center" bgcolor="##FFFFCC">#AwaySportsmanshipMarks#</td> 
		<td>#DateFormat( FixtureDate , "DD/MM/YYYY")#</td>
		<td >#DivName#</td>
		<td>#RoundName#</td> 
		<td>#HomeTeam# #HomeOrdinal#</td>
		<cfif Result IS "H" >
			<td align="center" bgcolor="##FF66CC">H</td>
		<cfelseif Result IS "A" >
			<td align="center" bgcolor="##FF66CC">-</td>
		<cfelseif Result IS "D" >
			<td align="center" bgcolor="##FF66CC">D</td>
		<cfelseif Result IS "P" >
			<td align="center" bgcolor="##FF66CC">P</td>
		<cfelseif Result IS "Q" >
			<td align="center" bgcolor="##FF66CC">Aban</td>
		<cfelseif Result IS "W" >
			<td align="center" bgcolor="##FF66CC">Void</td>
		<cfelseif Result IS "T" >
			<td align="center" bgcolor="##FF66CC">TEMP</td>
		<cfelse>
			<td align="center">#HomeGoals#</td>
		</cfif>
		<td>#AwayTeam# #AwayOrdinal#</td>
		<cfif Result IS "H" >
			<td align="center" bgcolor="##FF66CC">-</td>
		<cfelseif Result IS "A" >
			<td align="center" bgcolor="##FF66CC">A</td>
		<cfelseif Result IS "D" >
			<td align="center" bgcolor="##FF66CC">D</td>
		<cfelseif Result IS "P" >
			<td align="center" bgcolor="##FF66CC">P</td>
		<cfelseif Result IS "Q" >
			<td align="center" bgcolor="##FF66CC">Aban</td>
		<cfelseif Result IS "W" >
			<td align="center" bgcolor="##FF66CC">Void</td>
		<cfelseif Result IS "T" >
			<td align="center" bgcolor="##FF66CC">TEMP</td>
		<cfelse>
			<td align="center">#AwayGoals#</td>
		</cfif>
	</tr>
		<cfif IsNumeric(RefereeMarksH)>
			<cfset TotalHMarks = TotalHMarks + RefereeMarksH>
			<cfset Denominator = Denominator + 1>
		</cfif> 
		<cfif IsNumeric(RefereeMarksA)>
			<cfset TotalAMarks = TotalAMarks + RefereeMarksA>
			<cfset Denominator = Denominator + 1>
		</cfif> 
		
	</cfoutput>
	<tr>
	<td bgcolor="white"></td>
	<cfif Denominator GT 0>
		<td colspan="3" align="right" bgcolor="white"><font color="red">Average Marks #NumberFormat((TotalHMarks+TotalAMarks)/Denominator,'999.99')#</font></td>
	<cfelse>
		<td colspan="3" align="right" bgcolor="white"><font color="red">&nbsp;</font></td>
	</cfif>
	<td bgcolor="white"></td>
	<td bgcolor="white"></td>
	<td bgcolor="white"></td>
	<td bgcolor="white"></td>
	<td bgcolor="white"></td>
	<td bgcolor="white"></td>
	<td bgcolor="white"></td>
	<td bgcolor="white"></td>
	<td bgcolor="white"></td>
	<tr>
	<cfset Denominator = 0 >
	<cfset TotalHMarks = 0 >
	<cfset TotalAMarks = 0 >
</cfoutput>
</table>
