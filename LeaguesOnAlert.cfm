<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QLeaguesOnAlert.cfm">
<table width="50%" border="1" align="center" cellpadding="1" cellspacing="1">
	<cfoutput query="QLeaguesOnAlert">
		<tr>
			<td><span class="pix10">#namesort#</span></td>
			<td><span class="pix10"><a href="SecurityCheck.cfm?LeagueCode=#defaultleaguecode#">#defaultleaguecode#</a></span></td>
		</tr>
	</cfoutput>
</table>
	
