<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfif NOT StructKeyExists(url, "Prefix")>
	Prefix parameter missing from url<br><br><br>
	e.g. &prefix='abc'
	<cfabort>
</cfif>
<cfset ParamLength = #len(url.prefix)#>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfquery name="ClubUmbrellaReport2" datasource="zmast">
SELECT
 	ci.id, 
	ci.ClubName, 
	ci.Location,
	ti.fmTeamID,
	ti.LeagueInfoID,
	COUNTIESLIST, 
	NAMESORT, 
	LEAGUENAME, 
	DEFAULTLEAGUECODE, 
	LeagueCodePrefix, 
	LeagueCodeYear, 
	BADGEJPEG, 
	WEBSITELINK, 
	DEFAULTDIVISIONID, 
	PointsForWin, 
	PointsForDraw, 
	PointsForLoss, 
	LEAGUETBLCALCMETHOD, 
	DEFAULTYOUTHLEAGUE, 
	SEASONNAME, 
	SEASONSTARTDATE, 
	SEASONENDDATE, 
	DEFAULTRULESANDFINES, 
	DEFAULTSPONSOR, 
	REFMARKSOUTOFHUNDRED, 
	DEFAULTGOALSCORERS, 
	SupplyLeague, 
	LeagueType, 
	AltLeagueCodePrefix, 
	Alert, 
	RandomPlayerRegNo, 
	VenueAndPitchAvailable, 
	SuppressTeamSheetEntry, 
	SuppressRedYellowCardsEntry, 
	SuppressTeamCommentsEntry, 
	SuppressTeamDetailsEntry,
	SuppressLeadingGoalscorers,
	LeagueBrand, 
	ShowAssessor
FROM 
	clubinfo ci,
	teaminfo ti,
	leagueinfo li
WHERE
	left(ci.ClubName,#ParamLength#)='#url.prefix#'
	AND ci.id = ti.ClubInfoID
	AND li.id = ti.LeagueInfoID
ORDER BY	 
	ci.ClubName, LeagueCodeYear DESC, LeagueCodePrefix
	
</cfquery>

<cfif ClubUmbrellaReport2.RecordCount IS 0>
	<cfoutput>
		<span class="pix13">
		<br><br>None found beginning with parameter="#url.prefix#"
		</span>
		<cfabort>
	</cfoutput>
</cfif>

<cfif ClubUmbrellaReport2.RecordCount GT 1000>
	<cfoutput>
		<span class="pix13">
		<br><br>Too many rows (#ClubUmbrellaReport2.RecordCount#) found beginning with parameter="#url.prefix#"
		</span>
		<cfabort>
	</cfoutput>
</cfif>

<table width="100%"  border="0" align="left" cellpadding="1" cellspacing="0">
<cfoutput query="ClubUmbrellaReport2" group="ClubName">
	<cfset CountiesString = "">
	<cfset CountiesStringCount = 0>
	<tr bgcolor="white">
		<td colspan="7"><span class="pix18bold">#ClubName#</span></td>
		<td colspan="1"><span class="pix10silver">#id#</span></td>
	</tr>
		
		<cfoutput group="LeagueCodeYear">
		<cfif LeagueCodeYear IS 2008>
			<cfset ThisClass = "pix10">
		<cfelse>
			<cfset ThisClass = "pix10silver">
		</cfif>
			<tr>
				<td colspan="8"><span class=#ThisClass#>#LeagueCodeYear#</span></td>
			</tr>
			<cfoutput>
			
			<CFSWITCH expression="#LeagueBrand#">
			
				<CFCASE VALUE="0">
					<cfset ThisColor = "bg_highlight0"> <!--- Normal --->
				</CFCASE>
				
				<CFCASE VALUE="1">
					<cfset ThisColor = "bg_yellow"> <!--- National League System --->
				</CFCASE>
				
				<CFCASE VALUE="2">
					<cfset ThisColor = "bg_lightgreen"> <!--- Womens Football Pyramid --->
				</CFCASE>
				
				<CFCASE VALUE="3">
					<cfset ThisColor = "bg_highlight0"> <!--- Normal --->
				</CFCASE>
				
				<CFCASE VALUE="4">
					<cfset ThisColor = "bg_highlight"> <!--- Football Association --->
				</CFCASE>
				
				<CFCASE VALUE="5">
					<cfset ThisColor = "bg_highlight2"> <!--- Referees Association --->
				</CFCASE>
					
			</CFSWITCH>
			
			<tr>
			<cfif LeagueCodeYear IS 2008>
				<cfif CountiesStringCount GT 0>
				
				
					<cfif CountiesString IS CountiesList >
					<cfelse>
						<cfset CountiesString = "#CountiesString# + #CountiesList#" >
					</cfif>
					
					<cfset CountiesStringCount = CountiesStringCount + 1 >
					
					
					
				<cfelse>
					<cfset CountiesString = "#CountiesList#" >
					<cfset CountiesStringCount = 1 >
				</cfif>
			</cfif>
			<cfquery name="QTeamDetails" datasource="fm#LeagueCodeYear#">
				SELECT
					longcol, 
					mediumcol, 
					shortcol, 
					notes 
				FROM
					team
				WHERE
					id=#fmTeamID#
			</cfquery>
			<td ><span class="#ThisClass#">#QTeamDetails.longcol#</span></td>
			
			<td  ><span class="#ThisClass#">#IIF(Location IS "",DE("&nbsp;"),DE(Location))#</span></td>
			<td ><span class="#ThisClass#"><a href="ClubList.cfm?fmTeamID=#fmTeamID#&LeagueCode=#LeagueCodePrefix##LeagueCodeYear#" target="_blank">details</a></span></td>


			<!---
			<td><span class="#ThisClass#">#fmTeamID#</span></td>
			<td><span class="pix10">#LeagueInfoID#</span></td>
			--->
			<td  ><span class="#ThisClass#">#COUNTIESLIST#</span></td> 
			<td class="#ThisColor#"><span class="#ThisClass#">#NAMESORT#</span></td> 
			<!---
			<td><span class="pix10">#LEAGUENAME#</span></td> 
			<td><span class="pix10">#DEFAULTLEAGUECODE#</span></td> 
			--->	
			<td class="#ThisColor#"><span class="#ThisClass#">#LeagueCodePrefix#</span></td> 



			<!---
			<td><span class="pix10">#BADGEJPEG#</span></td> 
			--->
			<td ><span class="#ThisClass#"><a href="#WEBSITELINK#" target="_blank">#WEBSITELINK#</a></span></td> 
			<!---
			<td><span class="pix10">#DEFAULTDIVISIONID#</span></td> 
			<td><span class="pix10">#PointsForWin#</span></td> 
			<td><span class="pix10">#PointsForDraw#</span></td> 
			<td><span class="pix10">#PointsForLoss#</span></td> 
			<td><span class="pix10">#LEAGUETBLCALCMETHOD#</span></td> 
			<td><span class="pix10">#DEFAULTYOUTHLEAGUE#</span></td> 
			<td><span class="pix10">#SEASONNAME#</span></td> 
			<td><span class="pix10">#SEASONSTARTDATE#</span></td> 
			<td><span class="pix10">#SEASONENDDATE#</span></td>
			<td><span class="pix10">#DEFAULTRULESANDFINES#</span></td> 
			<td><span class="pix10">#DEFAULTSPONSOR#</span></td> 
			<td><span class="pix10">#REFMARKSOUTOFHUNDRED#</span></td> 
			<td><span class="pix10">#DEFAULTGOALSCORERS#</span></td> 
			<td><span class="pix10">#SupplyLeague#</span></td> 
			--->	
			<td ><span class="#ThisClass#">#LeagueType#</span></td> 
			<!---
			<td><span class="pix10">#AltLeagueCodePrefix#</span></td> 
			<td><span class="pix10">#Alert#</span></td> 
			<td><span class="pix10">#RandomPlayerRegNo#</span></td> 
			<td><span class="pix10">#VenueAndPitchAvailable#</span></td> 
			<td><span class="pix10">#SuppressTeamSheetEntry#</span></td> 
			<td><span class="pix10">#SuppressRedYellowCardsEntry#</span></td> 
			<td><span class="pix10">#SuppressTeamCommentsEntry#</span></td> 
			<td><span class="pix10">#SuppressTeamDetailsEntry#</span></td>
			<td><span class="pix10">#SuppressLeadingGoalscorers#</span></td>
			<td><span class="pix10">#LeagueBrand#</span></td> 
			<td><span class="pix10">#ShowAssessor#</span></td>
			--->
			</tr>
			</cfoutput>	
	</cfoutput>
	<cfif CountiesStringCount GT 1>
		<tr bgcolor="white">
			<td colspan="8"><span class="pix10boldred">#CountiesStringCount#: #CountiesString#</span></td>
		</tr>
	</cfif>
	
</cfoutput>
</table>
<!--- <script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script> --->
