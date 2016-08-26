<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QContributoryReport.cfm">
<cfif url.ReportType IS "State of Pitch">
<cfelseif url.ReportType IS "Club Facilities">
<cfelseif url.ReportType IS "Hospitality">
</cfif>
<table align="center" cellpadding="3" cellspacing="3">
	<tr>
		<td>
			<table border="1" cellspacing="1" cellpadding="2" >
				<tr>
					<td rowspan="2" align="center"><span class="pix10">Team</span></td>
					<td colspan="4" align="center"><span class="pix10"><cfoutput>#url.ReportType#</cfoutput></span></td>
				</tr>
				<tr>
					<td align="center"><span class="pix10">Total<br />Marks</span></td>
					<td align="center"><span class="pix10">Marked<br />Games</span></td>
					<td colspan="2" align="center"><span class="pix10">Average Marks</span></td>
				</tr>
				
				<cfset QName = QueryNew("TeamName,TotalMarks,NumberOfMarks,AveMarks,Verdict") >
				<cfoutput query="QContributoryReport" group="TeamName">
					<cfset NumberOfMarks = 0>
					<cfset TotalMarks = 0>
					<cfset Excellent = "#Replace(url.ReportType, ' ', '', 'ALL')#" & "Excellent">
					<cfset Good = "#Replace(url.ReportType, ' ', '', 'ALL')#" & "Good">
					<cfset Satisfactory = "#Replace(url.ReportType, ' ', '', 'ALL')#" & "Satisfactory">
					<cfset Poor = "#Replace(url.ReportType, ' ', '', 'ALL')#" & "Poor">
					<cfoutput>
						<cfset NumberOfMarks = NumberOfMarks + Evaluate(Excellent) + Evaluate(Good) + Evaluate(Satisfactory) + Evaluate(Poor) >
						<cfset TotalMarks = TotalMarks + (Evaluate(Excellent)*4)  + (Evaluate(Good)*3) + (Evaluate(Satisfactory)*2) + (Evaluate(Poor)*1) >
					</cfoutput>
					<cfif NumberOfMarks GT 0>
						<cfset AveMarks = TotalMarks / NumberOfMarks >
						<tr>
							<td><span class="pix10">#TeamName#</span></td>
							<td align="right"><span class="pix10">#TotalMarks#</span></td>
							<td align="right"><span class="pix10">#NumberOfMarks#</span></td>
							<td align="right"><span class="pix10">#NumberFormat(AveMarks, '99.9')#</span></td>
							 
							<cfif 4.0 GE AveMarks AND AveMarks GT 3.5>
								<cfset Verdict = "Excellent">
							<cfelseif 3.5 GE AveMarks AND AveMarks GT 2.5>
								<cfset Verdict = "Good">
							<cfelseif 2.5 GE AveMarks AND AveMarks GT 1.5>
								<cfset Verdict = "Satisfactory">
							<cfelse>
								<cfset Verdict = "Poor">
							</cfif>
							<td><span class="pix10">#Verdict#</span></td>	
						</tr>
						<cfset temp = QueryAddRow(QName) >
						<cfset temp = QuerySetCell(QName, "TeamName", "#TeamName#") >
						<cfset temp = QuerySetCell(QName, "TotalMarks", "#TotalMarks#") >
						<cfset temp = QuerySetCell(QName, "NumberOfMarks", "#NumberOfMarks#") >
						<cfset temp = QuerySetCell(QName, "AveMarks", "#AveMarks#") >
						<cfset temp = QuerySetCell(QName, "Verdict", "#Verdict#") >
					</cfif>
				</cfoutput>
			</table>
		</td>
		<cfinclude template="queries/qry_QName.cfm">
		<td>
			<table border="1" cellspacing="1" cellpadding="2" >
				<tr>
					<td rowspan="2" align="center"><span class="pix10">Team</span></td>
				
					<td colspan="4" align="center"><span class="pix10"><cfoutput>#url.ReportType#</cfoutput></span></td>
				</tr>
				<tr>
					<td align="center"><span class="pix10">Total<br />Marks</span></td>
					<td align="center"><span class="pix10">Marked<br />Games</span></td>
					<td colspan="2" align="center"><span class="pix10">Average Marks</span></td>
				</tr>
				<cfoutput query="QName001" >
						<tr>
							<td><span class="pix10">#TeamName#</span></td>
							<td align="right"><span class="pix10">#TotalMarks#</span></td>
							<td align="right"><span class="pix10">#NumberOfMarks#</span></td>
							<td align="right"><span class="pix10">#NumberFormat(AveMarks, '99.9')#</span></td>
							<td><span class="pix10">#Verdict#</span></td>	
						</tr>
				</cfoutput>
			</table>
		</td>	
	</tr>
</table>



<!---

						
<cfoutput query="QContributoryReport" group="TeamName">

<strong>#TeamName#</strong><BR>

	<cfoutput>
#ID# - #HCOB_Excellent# #HCOB_Good# #HCOB_Satisfactory# #HCOB_Poor# - #ACOB_Excellent# #ACOB_Good# #ACOB_Satisfactory# #ACOB_Poor# - #SOP_Excellent# #SOP_Good# #SOP_Satisfactory# #SOP_Poor#
- #CF_Excellent# #CF_Good# #CF_Satisfactory# #CF_Poor# - #H_Excellent# #H_Good# #H_Satisfactory# #H_Poor#<BR>
	</cfoutput>
</cfoutput>
--->
