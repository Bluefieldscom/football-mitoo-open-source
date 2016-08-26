<!--- called by MtchDay.cfm --->
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="queries/del_PostponedFixtures.cfm">
<cflocation url="MtchDay.cfm?LeagueCode=#LeagueCode#&MDate=#DateFormat(MDate,'YYYY-MM-DD')#" addtoken="no">
<cfabort>
