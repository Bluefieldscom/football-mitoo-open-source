<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfinclude template="queries/qry_QFixtures_v5.cfm">
<cfoutput query="QFixtures" group="FixtureDate">
	<span class="pix13boldnavy"><HR>#DateFormat( FixtureDate , "DDDD, DD MMMM YYYY")#</span>
	<cfoutput group="DivName">
		<span class="pix13bold"><BR>#DivName#</span>
		<cfoutput>
			<span class="pix13"><BR>
			#HomeTeam# #HomeOrdinal#&nbsp;&nbsp;<cfif Result IS "P">P<cfelseif Result IS "W" >V<cfelseif Result IS "Q" >A<cfelseif Result IS "H" >H<cfelseif Result IS "A" >-<cfelseif Result IS "D" >D<cfelse>#HomeGoals#</cfif>
			v
			<cfif Result IS "P">P<cfelseif Result IS "W" >V<cfelseif Result IS "Q" >A<cfelseif Result IS "H" >-<cfelseif Result IS "A" >A<cfelseif Result IS "D" >D<cfelse>#AwayGoals#</cfif>&nbsp;&nbsp;#AwayTeam# #AwayOrdinal# 
			<em>#RoundName#</em></span> 
			<cfset OfficialsNames = "#RefsName# #AR1Name# #AR2Name# #FourthOfficialName#">
			<cfif TRIM(OfficialsNames) IS "">
			<cfelse>
				<cfif RefsName IS ""><span class="pix10"><BR></span><cfelse><span class="pix10"><BR>&nbsp;&nbsp;&nbsp;&nbsp;<em>Referee:#RefsName#&nbsp;&nbsp;</em></span></cfif>
				<cfset assistnames = "#AR1Name# #AR2Name#">
				<cfif TRIM(assistnames) IS ""><cfelse><span class="pix10"><em> Asst1:#AR1Name#&nbsp;&nbsp;Asst2:#AR2Name#&nbsp;&nbsp;</em></span></cfif>
				<cfif TRIM(FourthOfficialName) IS ""><cfelse><span class="pix10"><em> 4th:#FourthOfficialName#</em></span></cfif>
			</cfif>
			<cfif TRIM(VenueDetails) IS "">
			<cfelse>
				<span class="pix10"><br />&nbsp;&nbsp;&nbsp;&nbsp;<em>Venue:#VenueDetails#</em></span>
			</cfif>
			<cfset ThisKOTime = "#KOTime#">
			<cfif TRIM(ThisKOTime) IS "">
			<cfelse>
				<span class="pix10">&nbsp;&nbsp; <em>#TimeFormat(ThisKOTime, 'h:mm TT')#</em></span>
			</cfif>
			<cfset ThisFixtureNotes = "#FixtureNotes#">
			<cfif TRIM(ThisFixtureNotes) IS "">
			<cfelse>
				<span class="pix10"><br />&nbsp;&nbsp;&nbsp;&nbsp;#ThisFixtureNotes#</span>
			</cfif>
		</cfoutput>
	</cfoutput>
</cfoutput>

