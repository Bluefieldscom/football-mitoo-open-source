<!--- called by MtchDay.cfm --->
<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- ALLOW future Team Sheet updates by the clubs for all of today's games --->
<cfinclude template="queries/upd_TeamSheetOKAllow.cfm">
<cfoutput>
<cflocation url="MtchDay.cfm?TblName=Matches&MDate=#DateFormat(ThisDate, 'DD-MM-YYYY')#&DivisionID=#DivisionID#&LeagueCode=#LeagueCode#" addtoken="no">
</cfoutput>
