<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QFixtures_v8.cfm">
<cfsetting enablecfoutputonly="yes">
<cfset TabChar = Chr(9)>
<cfset NewLine = Chr(13) & Chr(10)>
<CFCONTENT type="application/msword">
<cfheader name="Content-Disposition" value="filename=Referee_Appointments.doc">
<cfoutput query="QFixtures" group="FixtureDate">
============== #DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")# ==============
<cfoutput group="DivName">
=== #DivName# ===
<cfoutput>
<cfset assistnames = "#AR1Name# #AR2Name#">
#RoundName##NewLine#
#HomeTeam# #HomeOrdinal# v #AwayTeam# #AwayOrdinal##NewLine##TabChar#Referee: #RefsName##NewLine#<cfif TRIM(assistnames) IS ""><cfelse>#TabChar#Asst Ref 1: #AR1Name#  Asst Ref 2: #AR2Name#</cfif><cfif TRIM(FourthOfficialName) IS ""><cfelse>#TabChar#Fourth: #FourthOfficialName#</cfif>#NewLine#
</cfoutput>
</cfoutput>
</cfoutput>
