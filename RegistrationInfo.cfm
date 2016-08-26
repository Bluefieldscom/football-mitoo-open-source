<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT StructKeyExists(url, "LeagueCode")>
	LeagueCode parameter missing!
	<CFABORT>
</cfif>

<cfinclude template = "queries/qry_QRegnInfo.cfm">

<br>
<cfoutput><b>#LeagueCode# Registrations as of #DateFormat( Now() , "DDDD, DD MMMM YYYY")#</b></cfoutput>
<br><br><br>
<cfoutput query="QRegnInfo">
#name# (#DateFormat( DateRegistered , "D MMM YYYY" )#)<br>
#email#<br>
#info#<br>
<BR>
<BR>

</cfoutput>
