<!---
qry_getmaxes.cfm
Purpose:	Grab all current max(ID) integers required for selecting the 
			old data IDs with the correctly added number
Created:	14 July 2004
By:			Terry Riley
Called by:	qry_import_process.cfm
Notes:		SMS removed 11/July
			If an ID is zero, it is so set
--->

<cfquery name="maxConstitID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Constitution
</cfquery>
<cfif maxConstitID.MaxID GT 0>
	<cfset variables.maxConstitID = maxConstitID.MaxID>
<cfelse>
	<cfset variables.maxConstitID = 0>
</cfif>

<cfquery name="maxDivID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Division
</cfquery>	
<cfif maxDivID.MaxID GT 0>
	<cfset variables.maxDivID = maxDivID.MaxID>
<cfelse>
	<cfset variables.maxDivID = 0>
</cfif>

<cfquery name="maxTeamID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Team
</cfquery>	
<cfif maxTeamID.MaxID GT 0>
	<cfset variables.maxTeamID = maxTeamID.MaxID>
<cfelse>
	<cfset variables.maxTeamID = 0>
</cfif>

<cfquery name="maxOrdID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Ordinal
</cfquery>	
<cfif maxOrdID.MaxID GT 0>
	<cfset variables.maxOrdID = maxOrdID.MaxID>	
<cfelse>
	<cfset variables.maxOrdID = 0>
</cfif>

<cfquery name="maxRegID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Register
</cfquery>	
<cfif maxRegID.MaxID GT 0>
	<cfset variables.maxRegID = maxRegID.MaxID>	
<cfelse>
	<cfset variables.maxRegID = 0>
</cfif>		

<cfquery name="maxPlayerID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Player
</cfquery>	
<cfif maxPlayerID.MaxID GT 0>
	<cfset variables.maxPlayerID = maxPlayerID.MaxID>	
<cfelse>
	<cfset variables.maxPlayerID = 0>
</cfif>	

<cfquery name="maxRefID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Referee
</cfquery>	
<cfif maxRefID.MaxID GT 0>
	<cfset variables.maxRefID = maxRefID.MaxID>	
<cfelse>
	<cfset variables.maxRefID = 0>
</cfif>	

<cfquery name="maxKOID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM KORound
</cfquery>	
<cfif maxKOID.MaxID GT 0>
	<cfset variables.maxKOID = maxKOID.MaxID>	
<cfelse>
	<cfset variables.maxKOID = 0>
</cfif>

<cfquery name="maxSusID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Suspension
</cfquery>	
<cfif maxSusID.MaxID GT 0>
	<cfset variables.maxSusID = maxSusID.MaxID>	
<cfelse>
	<cfset variables.maxSusID = 0>
</cfif>	

<!--- for Matchreport and Appearance --->
<cfquery name="maxFixtureID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Fixture
</cfquery>	
<cfif maxFixtureID.MaxID GT 0>
	<cfset variables.maxFixtureID = maxFixtureID.MaxID>	
<cfelse>
	<cfset variables.maxFixtureID = 0>
</cfif>	

<cfquery name="maxSponID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM Sponsor
</cfquery>	
<cfif maxSponID.MaxID GT 0>
	<cfset variables.maxSponID = maxSponID.MaxID>	
<cfelse>
	<cfset variables.maxSponID = 0>
</cfif>		

<!--- <cfquery name="maxSMSID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM SMSInfo
</cfquery>	
<cfif maxSMSID.MaxID GT 0>
	<cfset variables.maxSMSID = maxSMSID.MaxID>	
<cfelse>
	<cfset variables.maxSMSID = 0>
</cfif> --->		

<!--- special for one-off import of HERTS03 MatchNo table --->	
<cfquery name="maxMatchNoID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM MatchNo
</cfquery>	
<cfif maxMatchNoID.MaxID GT 0>
	<cfset variables.maxMatchNoID = maxMatchNoID.MaxID>	
<cfelse>
	<cfset variables.maxMatchNoID = 0>
</cfif>	

<cfquery name="maxNewsID" datasource="#application.DSN#">
	SELECT MAX(ID) AS MaxID FROM NewsItem
</cfquery>	
<cfif maxNewsID.MaxID GT 0>
	<cfset variables.maxNewsID = maxNewsID.MaxID>	
<cfelse>
	<cfset variables.maxNewsID = 0>
</cfif>		


