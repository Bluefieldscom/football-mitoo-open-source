<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<LINK REL="stylesheet" type="text/css" href="fmstyle.css">

<cfsetting requestTimeOut = "1200" >

<!--
ESA data comes like this............

Column1 = ESAFixtureID - this will correspond to the value in fixture.PitchAvailableID
Column2 = H or A
Column3 = ESAPlayerID
Column4 = Goals scored by player
Column5 = OWNGOALS scored by player
Column6 = CardValue 1,3 or 4
Column7 = StarPlayer
Column8 = division code conf,fcn or fcs
--->
<cfset ThisESAFixtureID = 0 >
<cfset ThisLeagueCodePrefix = Left(url.LeagueCode, (Len(TRIM(url.LeagueCode))-4))>      <!--- e.g. "CONF" ---> 
<cfset ThisLeagueCode = url.LeagueCode >      <!--- e.g. "CONF2008" ---> 
<cfset ThisDB = "fm#Right(url.LeagueCode,4)#"> <!--- e.g. "fm2008" --->
<cfset Thiscellpadding="5">
<cfset Thiscellspacing="0">

<cfif ThisLeagueCodePrefix IS NOT "CONF" >
	This program is designed for ESA Conference data stream only
	<cfabort>
</cfif>
<!--- delete all appearances --->
<cfquery name="DelFixtures" datasource="#ThisDB#">
	DELETE FROM 
		appearance
	WHERE 
		leaguecode='#ThisLeagueCodePrefix#'
</cfquery>

<cfset Spreadsheet = "#ThisLeagueCodePrefix#Appearances.xls"   >           <!--- e.g. CONFAppearances.xls --->
<cfset objPOIAppearances = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />
<cfset objSheetAppearances = objPOIAppearances.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />
<!--- this gives objSheetAppearances.Query as a result set --->


<cfquery Name="QSpreadsheet" dbtype="query">
	SELECT 
		Column1 as ESAFixtureID,
		Column2 as ESAHomeAway,
		Column3 as ESAPlayerID,
		Column4 as ESAGoals,
		Column5 as ESAOwnGoals,
		Column6 as ESACardValue,
		Column7 as ESAStarPlayer
	FROM
		objSheetAppearances.Query
</cfquery>

<table class="pix10">
	<cfoutput query="QSpreadsheet">
		<!--- get corresponding fixture in football.mitoo --->
		<cfquery name="QFixture" datasource="#ThisDB#">
			SELECT
				f.ID as FID,
				f.fixturedate
			FROM 
				fixture f
			WHERE
				f.LeagueCode='#ThisLeagueCodePrefix#'
				AND f.PitchAvailableID = '#QSpreadsheet.ESAFixtureID#'
		</cfquery>
		<cfif ThisESAFixtureID IS NOT ESAFixtureID AND QFixture.RecordCount IS 1 >
			<cfset ThisESAFixtureID = ESAFixtureID>
			<tr>
				<td>#DateFormat(QFixture.fixturedate, 'DD MMM YYYY')# #ThisESAFixtureID#</td>
			</tr>
			<cfflush>
		<cfelseif QFixture.RecordCount IS NOT 1 >
			QFixture NO MATCH FOUND
			<cfabort>
		</cfif>
		<!--- get corresponding player in football.mitoo --->
		<cfquery name="QPlayer" datasource="#ThisDB#">
			SELECT
				ID as PID, 
				mediumCol, 
				shortCol, 
				notes, 
				LeagueCode, 
				surname, 
				forename
			FROM
				player
			WHERE
				LeagueCode='#ThisLeagueCodePrefix#'
				AND shortcol = #ESAPlayerID#
		</cfquery>
		<cfif QPlayer.RecordCount IS 1>
			<!--- Insert an appearance record --->
			<cfquery name="InsertAppearance" datasource="#ThisDB#">
				INSERT INTO
					appearance
					(FixtureID, HomeAway, PlayerID,	GoalsScored, Card, StarPlayer, LeagueCode)
				VALUES
					(
					#QFixture.FID#,
					'#QSpreadsheet.ESAHomeAway#',
					#QPlayer.PID#,
					#ESAGoals#,
					#ESACardValue#,
					#ESAStarPlayer#,
					'#ThisLeagueCodePrefix#'
					)
			</cfquery>
		<cfelse>
			<tr>
				<td>#ESAFixtureID#</td> 
				<td>#ESAHomeAway#</td> 
				<td>#ESAPlayerID#</td> 
				<td>#ESAGoals#</td> 
				<td>#ESAOwnGoals#</td>
				<td>#ESACardValue#</td> 
				<td>#ESAStarPlayer#</td> 
				<td>#QFixture.FID#</td>
				<cfif ESAGoals GT 0>
					<td>#ESAGoals#</td>
				<cfelse>
					<td>-</td>
				</cfif> 
				<cfif ESAOwnGoals GT 0>
					<td>#ESAOwnGoals#</td>
				<cfelse>
					<td>-</td>
				</cfif> 
				
				<cfif ESACardValue IS 1>
					<td>Yellow</td>
				<cfelseif ESACardValue IS 3>
					<td>Red</td>
				<cfelseif ESACardValue IS 4>
					<td>Orange</td>
				<cfelseif ESACardValue GT 0>
					<td>#ESACardValue#</td>
				<cfelse>
					<td>&nbsp;</td>
				</cfif> 
				<cfif ESAStarPlayer IS 1>
					<td>STAR</td>
				<cfelseif ESAStarPlayer IS 0>
					<td>&nbsp;</td>
				<cfelse>
					<td>***ERROR***</td>
				</cfif> 
				<td>#QPlayer.Surname#</td> 
				<td>#QPlayer.Forename#</td> 
				<td>*PLAYER NOT FOUND*</td> 
			</tr>
		</cfif>
	</cfoutput>
</table>
