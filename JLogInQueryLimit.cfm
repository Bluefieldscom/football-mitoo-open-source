<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif NOT StructKeyExists(url, "ThisLimit")>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="queries/qry_QLogInQueryLimit.cfm">
<table width="100%" border="1" cellspacing="1" cellpadding="1">
	<cfoutput query="QLogInQuery" group="DateX">
		<tr>
			<td colspan="7" align="center" bgcolor="silver"><span class="pix13bold">#DateFormat( DateTimeStamp , "DDDD, DD MMMM YYYY")#</span></td>
		</tr>
		<cfoutput>
		<tr>
			<td align="left"><span class="pix10">#TimeFormat( DateTimeStamp , "HH:mm")#</span></td>
			<td align="left" <cfif QLogInQuery.LeagueCode IS #URL.LeagueCode#>bgcolor="Aqua"</cfif>><span class="pix10">#LeagueCode#</span></td> 
			<td align="left" <cfif QLogInQuery.LeagueCode IS #URL.LeagueCode#>bgcolor="Aqua"</cfif>><span class="pix10">#NameSort#</span></td> 
			<td align="left"><span class="pix10">#UserName#</span></td>
			<td align="left" <cfif QLogInQuery.Passwd IS "*Supervisor*">bgcolor="Red"</cfif>><span class="pix10">#Passwd#</span></td>
			<td align="left" <cfif LoggedInOK IS "No">bgcolor="Yellow"</cfif>><span class="pix10"><cfif LoggedInOK IS "Yes">Yes<cfelse>NO</cfif></span></td>
			<td align="left"><span class="pix10">#ID#</span></td>
		</tr>
		</cfoutput>
	</cfoutput>
</table>
