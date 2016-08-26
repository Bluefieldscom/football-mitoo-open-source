<!--- Change club password - if, for example, the club secretary is sacked - JAB Only --->
<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif NOT (StructKeyExists (url, "OldTeamID") AND StructKeyExists (url, "NewTeamID"))  >
		<cfabort>
</cfif>
<cfif url.OldTeamID is 0 OR url.NewTeamID IS 0 OR (NOT StructKeyExists (url, "NewYearString")) >
	<cfoutput>
		Julian, Add new Team ('existingnameNew') with a new TeamID. Copy across any info from shortcol, mediumcol & notes. 
		Put the OldTeamID and NewTeamID parameters into the url and try again... &amp;NewYearString=2012 .....change as needed<br>
		<cfabort>
	</cfoutput>
</cfif>
<cfinclude template = "queries/upd_ClubPassword.cfm">
