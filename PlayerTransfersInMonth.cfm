<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Player Transfers in <cfoutput>#MonthAsString(url.MonthNo)#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<link href="fmstyle.css" rel="stylesheet" type="text/css">

<cfoutput>
<span class="pix18"><strong><cfoutput>#url.LeagueName#</cfoutput></strong><br /><br /></span>

<span class="pix13bold">Player Transfers in <cfoutput>#MonthAsString(url.MonthNo)#</cfoutput><br /></span>
</cfoutput>
<cfinclude template="queries/qry_PlayerTransfersInMonth.cfm">
<table border="0" cellpadding="0" cellspacing="0">
<cfoutput group="ID" query="PlayerMovementList">
	<tr>
		<td height="40" valign="bottom"><span class="pix13"><strong>#Forename# #Surname#</strong> [#RegNo#]</span></td>
 	</tr>
	<cfoutput>
		<tr>
			<td><span class="pix13">#TeamName#</span></td>
			<td><span class="pix13">#DateFormat(FirstDayOfRegistration, 'dd mmm yyyy')# - #DateFormat(LastDayOfRegistration, 'dd mmm yyyy')#</span></td>
		</tr>
	</cfoutput>
</cfoutput>
</table>

