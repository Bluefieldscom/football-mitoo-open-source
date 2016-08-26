<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<!--- called by News.cfm --->
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfinclude template="queries/qry_QReferee0.cfm">
<cfinclude template="queries/qry_QReferee1.cfm">
<cfinclude template="queries/qry_QReferee2.cfm">
<table width="100%" align="CENTER">
	<tr>
		<td align="CENTER" valign="TOP">
			<table border="1" cellspacing="1" cellpadding="2" >
				<cfoutput query="QReferee1">
					<tr>
						<cfset EmailSubject = URLEncodedFormat("Referee: #RefereeName# - #LeagueName#") >

						<td align="LEFT"><a href="RefsHistPublic.cfm?RI=#RefID#&LeagueCode=#LeagueCode#"><span class="pix9">see history</span></a></td>
						<td align="LEFT"><span class="pix10">#RefereeName#
						<br />
						<a href="mailto:#TRIM(EmailAddress1)#?subject=#EmailSubject#">#TRIM(EmailAddress1)#</a>
						<br />
						<a href="mailto:#TRIM(EmailAddress2)#?subject=#EmailSubject#">#TRIM(EmailAddress2)#</a>
						</span>
						</td>
						<td align="CENTER"><span class="pix10">#MediumCol#</span></td>
						<td align="Left"><span class="pix10">#RefDetails#</span></td>
					</tr>
				</cfoutput>	
			</table>
		</td>
		<td align="CENTER" valign="TOP">
			<table border="1" cellspacing="1" cellpadding="2" >
				<cfoutput query="QReferee2">
					<tr>
						<td align="CENTER"><span class="pix10">#MediumCol#</span></td>
						<td align="LEFT"><span class="pix10">#RefereeName#</span></td>
						<td align="LEFT"><a href="RefsHistPublic.cfm?RI=#RefID#&LeagueCode=#LeagueCode#"><span class="pix9">see history</span></a></td>
					</tr>
				</cfoutput>	
			</table>
		</td>
	</tr>
</table>
