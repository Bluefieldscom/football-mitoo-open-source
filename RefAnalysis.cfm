<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>


<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfinclude template="queries/qry_QFixtures_v7.cfm">
<cfoutput query="QFixtures" >
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr align="center">
			<td>
				<span class="pix10">Breakdown of #GamesPlayed# Middles, #Evaluate(2*GamesPlayed)# Lines and #GamesPlayed# Fourths</span>
			</td>
		</tr>
	</table>
</cfoutput>
<cfinclude template="queries/qry_QRefAnalyse.cfm">
<cfinclude template="queries/qry_QAstAnalyse.cfm">
<cfinclude template="queries/qry_QFourthAnalyse.cfm">

<table align="center" class="loggedinScreen">
	<tr valign="TOP">
		<td>
			<table border="1" cellspacing="0" cellpadding="1" align="center">
				<tr>
					<td align="left"><span class="pix10">&nbsp;</span></td>
					<td align="left"><span class="pix10">Name</span></td>
					<td><span class="pix10">History</span></td>
					<td align="center"><span class="pix10">Middles</span></td>
				</tr>
				<cfoutput query="QRefAnalyse" >
						<tr>
							<td align="left"><span class="pix10"><cfif RefsName IS "">&nbsp;<cfelse><cfif MediumCol IS "">&nbsp;<cfelse>#MediumCol#</cfif></cfif></span></td>
							<td align="left"><span class="pix10"><cfif RefsName IS "">Unspecified<cfelse>#RefsName#</cfif></span></td>
							<td align="center"><cfif RefsName IS "">&nbsp;<cfelse><a href="RefsHistPublic.cfm?RI=#RefID#&LeagueCode=#LeagueCode#"><span class="pix9">see</span></a></cfif></td>
							<td align="center"><span class="pix10">#GamesDone#</span></td>
						</tr>
				</cfoutput>
			</table>
		</td>
		<td>
			<table border="1" cellspacing="0" cellpadding="1" align="center">
				<tr>
					<td align="left"><span class="pix10">&nbsp;</span></td>
					<td align="left"><span class="pix10">Name</span></td>
					<td><span class="pix10">History</span></td>
					<td align="center"><span class="pix10">Lines</span></td>
				</tr>
				<cfoutput query="QAstAnalyse" group="RefID">
					<cfoutput>
						<tr>
							<td align="left"><span class="pix10"><cfif RefsName IS "">&nbsp;<cfelse>#MediumCol#</cfif></span></td>
							<td align="left"><span class="pix10"><cfif RefsName IS "">Unspecified<cfelse>#RefsName#</cfif></span></td>
							<td align="center"><cfif RefsName IS "">&nbsp;<cfelse><a href="RefsHistPublic.cfm?RI=#RefID#&LeagueCode=#LeagueCode#"><span class="pix9">see</span></a></cfif></td>
							<td align="center"><span class="pix10">#GamesDone#</span></td>
						</tr>
					</cfoutput>
				</cfoutput>
			</table>
		</td>
		<td>
			<table border="1" cellspacing="0" cellpadding="1" align="center">
				<tr>
					<td align="left"><span class="pix10">&nbsp;</span></td>
					<td align="left"><span class="pix10">Name</span></td>
					<td><span class="pix10">History</span></td>
					<td align="center"><span class="pix10">Fourths</span></td>
				</tr>
				<cfoutput query="QFourthAnalyse" >
						<tr>
							<td align="left"><span class="pix10"><cfif RefsName IS "">&nbsp;<cfelse>#MediumCol#</cfif></span></td>
							<td align="left"><span class="pix10"><cfif RefsName IS "">Unspecified<cfelse>#RefsName#</cfif></span></td>
							<td align="center"><cfif RefsName IS "">&nbsp;<cfelse><a href="RefsHistPublic.cfm?RI=#RefID#&LeagueCode=#LeagueCode#"><span class="pix9">see</span></a></cfif></td>
							<td align="center"><span class="pix10">#GamesDone#</span></td>
						</tr>
				</cfoutput>
			</table>
		</td>
	</tr>
</table>
