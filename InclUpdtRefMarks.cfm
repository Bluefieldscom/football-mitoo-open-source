<!--- included by InclBatchUpdate2.cfm --->

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfinclude template="queries/upd_FixtRefMarks.cfm">
