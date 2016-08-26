<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfinclude template="queries/qry_QSecretTeamList.cfm">


<!--- List of Passwords for Club access to Player Registration details. 
See the yellow League Reports menu in News.cfm --->
<div>
<cfif HideThisSeason IS 1>
	<table align="center">
		<tr><td  class="pix24boldred" >WARNING: If you distribute these passwords the clubs will be able to see<br>their own fixtures even if the site is hidden from the public</td></tr>
	</table>
</cfif>
<table align="center">
	<tr><td colspan="2" class="pix18boldred" ></td></tr>
	<tr><th class="pix13bold" align="left">Club Name</th><th class="pix13bold" align="left">Password</th></tr>
	<cfloop query="QGetSecretTeamList">
		<cfif ShortCol IS NOT "Guest">
			<cfset SecretWord = QGetSecretTeamList.LongCol >
			<cfset SecretID = QGetSecretTeamList.ID >
			<cfinclude template="InclSecretWordCreation.cfm">
			<cfoutput><tr><td align="left"><span class="pix10boldnavy">#LongCol#</span></td><td align="left"><span class="monopix16red">#SecretWord#</span></td></tr></cfoutput>
		</cfif>
	</cfloop>
</table>
</div>
<br><br><br><br><br><br><br><br><br>