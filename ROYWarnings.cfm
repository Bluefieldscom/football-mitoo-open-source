<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<!--- LEAVE THIS STYLESHEET BELOW - it is needed when generating HTM files for each County --->
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>Red/Orange/Yellow Warnings</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body>

<cfset ThisYear = Right(url.LeagueCode,4) >                                           <!--- e.g. "SDWFL2009" ---> 
<!--- This query is used to see if there are any RED, ORANGE or YELLOW player warnings across all leagues  --->
<cfinclude template="queries/qry_QAnyROYWarnings.cfm">
<cfif QAnyROYWarnings.RecordCount GT 0>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr><td><span class="pix24boldred">Red/Orange/Yellow Warnings</span></td></tr>
		<cfoutput  query="QAnyROYWarnings" group="LeagueCode">
			<tr><td><span class="pix18boldred">#LeagueCode# <a href="LUList.cfm?TblName=Player&LeagueCode=#LeagueCode##ThisYear#">click here</a></span></td></tr>
			<cfoutput>
				<tr><td><span class="pix13boldred">#Reason# #RegNo1# #RegNo2#</span></td></tr>
			</cfoutput>		
		</cfoutput>
	</table>	
</cfif>

<cfif QWarnings.RecordCount GT 0>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr><td><span class="pix24boldred">Red Warnings</span></td></tr>
		<cfoutput query="QWarnings">
				<tr><td><span class="pix13boldred">#LeagueCode#</span></td></tr>
		</cfoutput>
	</table>	
</cfif>

 