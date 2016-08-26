
<cfif NOT StructKeyExists(url, "LeagueCode")>
	LeagueCode - parameter missing. Aborting!
	<CFABORT>
</cfif>
<cfif NOT StructKeyExists(url, "SID")>
	Sponsor ID - parameter missing. Aborting!
	<CFABORT>
</cfif>	

<cfinclude template = "queries/qry_QSponsorT.cfm">

<!---
<table width="100%" border="0" cellspacing="1" cellpadding="10" align="CENTER">
	<tr align="LEFT">
		<td>
		<span class="pix13red">
		Please email <a href="mailto:INSERT_EMAIL_HERE?subject=sponsorship on football.mitoo">INSERT_EMAIL_HERE</a> for more information about team sponsorship and team photos.
		<BR>Costs &pound;20 to the first team in their division to go for this, otherwise &pound;40 for the rest of this season.
		</span>

		</td>
	</tr>
</table>
--->

<HEAD>
<TITLE><cfoutput>#QSponsorT.TeamName# #QSponsorT.OrdinalName# are sponsored by #QSponsorT.SponsorsName#</cfoutput></TITLE>
<link rel="stylesheet" href="fmstyle.css" type="text/css">
</HEAD>

<table width="100%" border="1" cellspacing="1" cellpadding="10" align="CENTER">
<cfoutput query="QSponsorT">
	<tr align="CENTER">
		<td><span class="pix14bold">#TeamName# #OrdinalName#</span> <span class="pix10">are sponsored by</span> <span class="pix14bold">#SponsorsName#</span></td>
	</tr>
	<tr align="CENTER">
		<td height="400"><span class="pix10">#TeamHTML#</span></td>
	</tr>
	
	<tr align="CENTER">
		<td height="120"><span class="pix10">#SponsorsHTML#</span></td>
	</tr>
</cfoutput>
</table>

