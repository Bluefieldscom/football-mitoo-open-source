<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfinclude template="queries/qry_QSecretRefereeList.cfm">


<!--- List of Passwords for Club access to Player Registration details. 
See the yellow League Reports menu in News.cfm --->
<div>
<table align="center">
<tr><th class="pix13bold" align="left">Referee Name</th><th class="pix13bold">Password</th></tr>
<tr><td colspan="2">&nbsp;</td></tr>

<cfloop query="QGetSecretRefereeList">
		<cfset RSecretWord = "#Trim(QGetSecretRefereeList.Surname)##Trim(QGetSecretRefereeList.Forename)#" >
		<cfset SecretWord = RSecretWord >
		<cfset SecretID = QGetSecretRefereeList.ID >
		<cfinclude template="InclSecretWordCreation.cfm">
		<cfset RSecretWord = SecretWord >
		<cfoutput><tr><td align="left"><span class="pix10boldnavy">#LongCol#</span></td><td align="left"><span class="monopix16red">#SecretWord#</span></td></tr></cfoutput>
</cfloop>
</table>
</div>