<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif NOT StructKeyExists(url,"Limit")>
	<cfset ThisLimit = "Limit 20" >
<cfelse>
	<cfset ThisLimit = "" >
</cfif>
<cfinclude template="queries/qry_QTopTwenty.cfm">
<cfif (QGoalsScored.RecordCount + QStarPlayerAwards.RecordCount) IS 0>
	<cfoutput>
		<span class="pix18boldred">Goalscorer and Star Player information has not been recorded</span>
	</cfoutput>
	<CFABORT>
</cfif>

<table border="0" align="center" cellpadding="5" cellspacing="5" bgcolor="#F5F5F5" >

	<tr>
		<td colspan="2" align="center" bgcolor="#333333"><span class="pix13boldwhite">Please note: these totals are for ALL COMPETITIONS</span></td>
	</tr>

	<tr>
		<cfif SuppressLeadingGoalscorers IS 0>
			<td width="50%" valign="top">
				<table border="0" cellspacing="1" cellpadding="3" align="CENTER">
					<tr>
						<td align="center"><span class="pix10bold">Club</span></td>
						<td align="center"><span class="pix10bold">Player</span></td>
						<td align="CENTER"><span class="pix10bold">Games<BR>Played</span></td>
						<td align="CENTER"><span class="pix10bold">Goals</span></td>
					</tr>
					<cfoutput query="QGoalsScored">
							<tr>
								<td align="LEFT"><span class="pix10">#TeamName#</span></td>						
								<td><span class="pix10"><strong>#Surname#</strong> #Left(Forename,1)#</span></td>
								<td align="CENTER"><span class="pix10">#GamesPlayed#</span></td>
								<td align="CENTER"><span class="pix10">#Goals#</span></td>
							</tr>
					</cfoutput>
				</table>
			</td>
		<cfelse>
			<td width="50%" valign="top">
				<table border="0" cellspacing="1" cellpadding="3" align="CENTER">
					<tr >
						<td align="center" ><span class="pix10bold">Leading Goalscorers Table<br>has been suppressed by the league</span></td>
					</tr>
				</table>
			</td>
			
		</cfif>
		
		<td width="50%" valign="top">
			<table border="0" cellspacing="1" cellpadding="3" align="CENTER">
				<tr>
					<td align="center"><span class="pix10bold">Club</span></td>
					<td align="center"><span class="pix10bold">Player</span></td>
					<td align="CENTER"><span class="pix10bold">Games<BR>Played</span></td>
					<td align="CENTER"><span class="pix10bold">Stars</span></td>
				</tr>
				<cfoutput query="QStarPlayerAwards">
						<tr>
							<td align="LEFT"><span class="pix10">#TeamName#</span></td>						
							<td><span class="pix10"><strong>#Surname#</strong> #Left(Forename,1)#</span></td>
							<td align="CENTER"><span class="pix10">#GamesPlayed#</span></td>
							<td align="CENTER"><span class="pix10">#TotalStars#</span></td>
						</tr>
				</cfoutput>
			</table>
		</td>
	</tr>
</table>


