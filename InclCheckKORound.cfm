<!--- included by InclInsrtGroupOfFixtures.cfm and InclUpdtFixture.cfm --->

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<link href="fmstyle.css" rel="stylesheet" type="text/css">
<!--- Check to see if the current "Division" is a Cup or Trophy i.e. a Knock-Out Competition --->
<CFPARAM name="KO" default="No">
<cfinclude template="queries/qry_QKnockOut_v2.cfm">
<cfif Left(QKnockOut.Notes,2) IS "KO" >
	<cfset KO = "Yes">
</cfif>
<cfinclude template="queries/qry_GetKORound.cfm">
<cfif #GetKORound.LongCol# IS "" AND KO IS "Yes">
	<span class="pix24boldred">You are not allowed to have an empty KO Round in a Knock Out competition...<BR><BR>Press the Back button on your browser.....</span>
	<CFABORT>
</cfif>

<cfif #GetKORound.LongCol# IS NOT "" AND KO IS "No">
	<span class="pix24boldred">You are not allowed to have a KO Round in a league competition...<BR><BR>Press the Back button on your browser.....</span>
	<CFABORT>
</cfif>