<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Unregistered Players without Suspensions and without Appearances - ready for deletion</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

<link href="fmstyle.css" rel="stylesheet" type="text/css">

<cfinclude template="queries/qry_QUnregisteredPlayersWithNoSuspensions.cfm">
<cfoutput>
<span class="monopix12"><strong>#QUnregisteredPlayersWithNoSuspensions.RecordCount# Unregistered Players without Suspensions and without Appearances</strong><br /></span>
</cfoutput>
<table>
	<cfoutput query="QUnregisteredPlayersWithNoSuspensions">
		<tr>
			<td><span class="monopix12">#Surname#</span></td>
			<td><span class="monopix12">#Forename#</span></td>
			<td><span class="monopix12">#shortcol#</span></td>
		</tr>
	</cfoutput>
</table>

<cfif ListFind("Silver",request.SecurityLevel) >
	<cfoutput>
	<span class="pix13bold">
	<br /><br />Julian, use this SQL to do the deletion in SQLYOG on Live FM2....<br /><br />
		DELETE FROM player WHERE leaguecode='#ReqFilter#'<br />
		AND shortcol <> 0
		AND id NOT IN (SELECT playerid FROM register WHERE leaguecode='#ReqFilter#') <br /> 
		AND id NOT IN (SELECT playerid FROM suspension WHERE leaguecode='#ReqFilter#')<br />
		AND id NOT IN (SELECT playerid FROM appearance WHERE leaguecode='#ReqFilter#') </span>
	</cfoutput>
</cfif>

</body>
</html>
