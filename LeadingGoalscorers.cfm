<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QGoalsScored20.cfm">
<cfif QGoalsScored.RecordCount IS 0>
	<cfoutput>
		<span class="pix18boldred">Goalscorer information has not been recorded</span>
	</cfoutput>
	<CFABORT>
</cfif>
<table border="1" cellspacing="1" cellpadding="3" align="CENTER">
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
