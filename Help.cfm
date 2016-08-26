<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">
<cfoutput>
<table border="0" cellspacing="0" cellpadding="0" align="CENTER" valign="MIDDLE">
	<tr align="CENTER" valign="MIDDLE">
		<td align="CENTER">
		<span class="pix13">
		<br />
		Please telephone us on <strong>08000 119 843</strong>
		<br />
		<br />
		Email: <a href="mailto:INSERT_EMAIL_HERE?subject=football.mitoo help!">INSERT_EMAIL_HERE</a>
		<br /><br />
		</span>
		<span class="pix18boldred">
		Please print this page and keep it near your PC.</span><span class="pix13boldred"><br /><br /><br />If you can't connect to <em>football.mitoo</em> but you can connect to other sites (e.g. www.bbc.co.uk)<br />
		or you notice an unusual error message then <u>please call me immediately</u>.<br /><br />
		</span>
	</tr>
	<tr align="CENTER" valign="MIDDLE">
		<td>
			<img src="mitoo_logo1.png" alt="fmlogo" border="0">
		</td>
	</tr>
</table>
</cfoutput>
