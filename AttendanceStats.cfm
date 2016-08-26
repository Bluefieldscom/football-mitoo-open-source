<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_AttendanceStats.cfm">

<cfif AttendanceStats.RecordCount IS 0>
	<table border="0" cellspacing="3" cellpadding="3" align="CENTER">
		<tr>
			<td align="center"><span class="pix13bold"><cfoutput>Attendance figures have not been recorded</cfoutput></span></td>
		</tr>
	</table>
<cfelse>
<!---
<cfinclude template="queries/qry_AttendanceStats2.cfm">
--->

<table width="70%" align="center">
	<tr valign="top">
		<td>
			<table width="100%" border="0" cellspacing="2" cellpadding="2" align="CENTER">
				<tr>
					<td align="center" colspan="6"><span class="pix10bold"><cfoutput>#AttendanceStats.DivisionName#</cfoutput></span></td>
				</tr>
				<tr>
					<td align="center"><span class="pix10bold">Team</span></td>
					<td align="CENTER"><span class="pix10bold">Home<br />Games</span></td>
					<td align="center"><span class="pix10bold">Lowest</span></td>
					<td align="CENTER"><span class="pix10bold">Highest</span></td>
					<td align="CENTER"><span class="pix10bold">Average</span></td>
					<td align="CENTER"><span class="pix10bold">Total</span></td>
				</tr>
					<cfoutput query="AttendanceStats">
						<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >
							<td><span class="pix10realblack">#ClubName# #OrdinalName#</span></td>
							<td align="center"><span class="pix10realblack">#total_home_games#</span></td>
							<td align="right"><span class="pix10realblack">#NumberFormat(SmallestGate, "999,999")#</span></td>
							<td align="right"><span class="pix10realblack">#NumberFormat(BiggestGate, "999,999")#</span></td>
							<td align="right"><span class="pix10realblack">#NumberFormat(average_home_attendance, "999,999")#</span></td>
							<td align="right"><span class="pix10realblack">#NumberFormat(total_home_attendance, "999,999")#</span></td>
						</tr>
					</cfoutput>
			</table>
		</td>
		<!---
		<td>
			<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
				<tr>
					<td align="center" colspan="6"><span class="pix10bold">All Competitions</span></td>
				</tr>
				<tr>
					<td align="center"><span class="pix10bold">Team</span></td>
					<td align="CENTER"><span class="pix10bold">Home<br />Games</span></td>
					<td align="center"><span class="pix10bold">Lowest</span></td>
					<td align="CENTER"><span class="pix10bold">Highest</span></td>
					<td align="CENTER"><span class="pix10bold">Average</span></td>
					<td align="CENTER"><span class="pix10bold">Total</span></td>
				</tr>
					<cfoutput query="AttendanceStats2">
						<tr>
							<td><span class="pix10">#TeamName#</span></td>
							<td align="center"><span class="pix10">#total_home_games#</span></td>
							<td align="right"><span class="pix10">#NumberFormat(SmallestGate, "999,999")#</span></td>
							<td align="right"><span class="pix10">#NumberFormat(BiggestGate, "999,999")#</span></td>
							<td align="right"><span class="pix10">#NumberFormat(average_home_attendance, "999,999")#</span></td>
							<td align="right"><span class="pix10">#NumberFormat(total_home_attendance, "999,999")#</span></td>
						</tr>
					</cfoutput>
			</table>
		</td>
		--->
	</tr>
</table>
</cfif>
<!--- next, underneath the grid display various buttons....... 
Leading Goalscorers
Attendance Statistics
Expanded League Table
.... etc
--->
<table width="100%" border="0" cellpadding="0" cellspacing="5" >
	<tr>
		<td valign="top">
			<table>
				<cfset DivisionName = Getlong.CompetitionDescription>
				<cfinclude template="InclLeagueTabButtons.cfm">
			</table>
		</td>
		<td align="center">
			<cfinclude template="InclLeagueTabAdvertsTbl.cfm">
		</td>
	</tr>
</table>

