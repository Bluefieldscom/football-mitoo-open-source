<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfif NOT LEFT(url.LeagueCode,4) IS "CONF">
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<LINK REL="stylesheet" type="text/css" href="fmstyle.css">

<cfset ThisLeagueCode = url.LeagueCode >      <!--- e.g. "CONF2008" ---> 
<cfset ThisDB = "fm#Right(url.LeagueCode,4)#"> <!--- e.g. "fm2008" --->

<cfsetting requestTimeOut = "3600" >

<!--- you first need to have copied the latest games.csv, appearances.csv, players.csv and referees.csv into the football.mitoo directory --->

<!--- 1. delete all fm appearances --->
<cfquery name="DelAppearance" datasource="#ThisDB#">
	DELETE FROM 
		appearance
	WHERE 
		leaguecode='CONF'
</cfquery>
<cfoutput><span class="pix10">appearances deleted ...<br></span></cfoutput>
<cfflush>
<!--- 2. delete all fm registrations --->
<cfquery name="DelRegistrations" datasource="#ThisDB#">
	DELETE FROM 
		register
	WHERE 
		LeagueCode = 'CONF'
</cfquery>
<cfoutput><span class="pix10">registrations deleted ...<br></span></cfoutput>
<cfflush>
<!--- 3. delete all fm fixtures --->
<cfquery name="DelFixtures" datasource="#ThisDB#">
	DELETE FROM 
		fixture
	WHERE 
		leaguecode='CONF'
</cfquery>
<cfoutput><span class="pix10">fixtures deleted ...<br></span></cfoutput>
<cfflush>
<!--- 4. delete all fm referees except default --->
<cfquery name="DelReferee" datasource="#ThisDB#">
	DELETE FROM 
		referee
	WHERE 
		leaguecode='CONF'
		AND NOT (LongCol IS NULL);
</cfquery>
<cfoutput><span class="pix10">referees deleted ...<br></span></cfoutput>
<cfflush>
<!--- 5. delete all the fm players except Own Goal --->
<cfquery name="DelPlayers" datasource="#ThisDB#">
	DELETE FROM 
		player
	WHERE 
		LeagueCode = 'CONF'
		AND NOT (Surname = 'OwnGoal')
</cfquery>
<cfoutput><span class="pix10">players deleted ...<br></span></cfoutput>
<cfflush>
<!--- 6. delete temporary ESA players --->
<cfquery name="Delete_esa_players" datasource="#ThisDB#">
	DELETE FROM 
		esa_players
</cfquery>
<cfoutput><span class="pix10">ESA players deleted ...<br></span></cfoutput>
<cfflush>

<!--- 7. delete temporary ESA appearances --->
<cfquery name="Delete_esa_appearances" datasource="#ThisDB#">
	DELETE FROM 
		esa_appearances
</cfquery>
<cfoutput><span class="pix10">ESA appearances deleted ...<br></span></cfoutput>
<cfflush>

<!--- 8. delete temporary ESA games --->
<cfquery name="Delete_esa_games" datasource="#ThisDB#">
	DELETE FROM 
		esa_games
</cfquery>
<cfoutput><span class="pix10">ESA games deleted ...<br></span></cfoutput>
<cfflush>

<!---
referees.csv - go directly from ESA data into fm referee table
============
Column1 = ESA RefereeID
Column2 = Initials
Column3 = Surname
Column4 = Place he comes from
--->
<cfset objPOI = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />
<cfset ESAname = "referees">
<cfset Spreadsheet = "#ESAname#.xls">
<cfset objSheet = objPOI.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />
<cfquery Name="Q#ESAname#" dbtype="query">
	SELECT
		Column1 as ESARefereeID,
		Column2 as Initials,
		Column3 as Surname,
		Column4 as WhereHeComesFrom
	FROM
		objSheet.Query
</cfquery>
<cfoutput query="Q#ESAname#">
	<cfquery name="Insrt#ESAname#" datasource="#ThisDB#" >
		INSERT INTO referee 
			(longcol, 
			mediumcol,
			shortcol, 
			notes, 
			LeagueCode,
			Surname, 
			Forename, 
			DateOfBirth, 
			FAN, 
			ParentCounty,
			AddressLine1, 
			AddressLine2,
			AddressLine3, 
			PostCode, 
			HomeTel, 
			WorkTel, 
			MobileTel)
		VALUES 
		(	'#Surname#, #Initials#' , 
		'',
		'',
		'#ESARefereeID#',
		'CONF',
		'#Surname#',
		'#Initials#',
		'0000-00-00',
		0,
		'',
		'',
		'',
		'#WhereHeComesFrom#',
		'',
		'',
		'',
		'' )
	</cfquery>
</cfoutput>
<cfoutput><span class="pix10">#Spreadsheet# loaded ...<br></span></cfoutput>
<cfflush>



<!---
players.csv - go from ESA spreadsheet data into a temporary ESA players table
===========
Column1 = conf 	107216	Richard	Acton	Goal	16/10/1979
Column2 = ESADivisionDesc e.g. Blue Square Premier
Column3 = ESATeamID e.g. 46579
Column4 = ESA TeamName e.g. Altrincham
Column5 = ESAPlayerID e.g. 107216
Column6 = ESAForenames e.g.	Richard
Column7 = ESASurname e.g.	Acton
Column8 = ESAPosition e.g.	Goal
Column9 = ESAPlayerDoB e.g. 16/10/1979
--->
<cfset objPOI = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />
<cfset ESAname = "players">
<cfset Spreadsheet = "#ESAname#.xls">
<cfset objSheet = objPOI.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />
<cfquery Name="Q#ESAname#" dbtype="query">
	SELECT
		Column1, <!--- e.g. conf 	107216	Richard	Acton	Goal	16/10/1979 --->
		Column2 as ESADivisionDesc, <!--- e.g. Blue Square Premier --->
		Column3 as ESATeamID, <!--- e.g. 46579 --->
		Column4 as ESATeamName, <!--- e.g. Altrincham --->
		Column5 as ESAPlayerID, <!--- e.g. 107216 --->
		Column6 as ESAForenames, <!--- e.g.	Richard --->
		Column7 as ESASurname, <!--- e.g.	Acton --->
		Column8 as ESAPosition, <!--- e.g.	Goal --->
		Column9 as ESAPlayerDoB <!--- e.g. 16/10/1979 --->
	FROM
		objSheet.Query
</cfquery>
<!--- copy this spreadsheet into MySQL table --->
<cfoutput query="Q#ESAname#">
	<cfquery name="Insrtplayers" datasource="#ThisDB#" >
	INSERT INTO esa_players 
		(
		ESADivisionDesc,
		ESATeamID,
		ESATeamName,
		ESAPlayerID,
		ESAForenames,
		ESASurname,
		ESAPosition,
		ESAPlayerDoB
		)
		VALUES 
		(
		'#ESADivisionDesc#',
		#ESATeamID#,
		'#ESATeamName#',
		#ESAPlayerID#,
		'#ESAForenames#',
		'#ESASurname#', 
		'#ESAPosition#',
		<cfif ESAPlayerDoB IS '0000-00-00'>NULL<cfelse>'#DateFormat(ESAPlayerDoB, 'YYYY-MM-DD')#'</cfif>
		)
	</cfquery>
</cfoutput>
<cfoutput><span class="pix10">esa_players loaded ...<br></span></cfoutput>
<cfflush>

<!---
appearances.csv - go from ESA spreadsheet data into a temporary ESA players table
===============
Column1 = ESAFixtureID - this will correspond to the value in fixture.PitchAvailableID
Column2 = H or A
Column3 = ESAPlayerID
Column4 = Goals scored by player
Column5 = OWNGOALS scored by player
Column6 = CardValue 1,3 or 4
Column7 = StarPlayer
Column8 = division code conf,fcn or fcs - not needed
--->
<cfset objPOI = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />
<cfset ESAname = "appearances">
<cfset Spreadsheet = "#ESAname#.xls">
<cfset objSheet = objPOI.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />
<cfquery Name="Q#ESAname#" dbtype="query">
	SELECT 
		Column1 as ESAFixtureID,
		Column2 as ESAHomeAway,
		Column3 as ESAPlayerID,
		Column4 as ESAGoals,
		Column5 as ESAOwnGoals,
		Column6 as ESACardValue,
		Column7 as ESAStarPlayer
	FROM
		objSheet.Query
</cfquery>
<!--- copy this spreadsheet into MySQL table --->
<cfoutput query="Q#ESAname#">
	<cfif NOT (ESAHomeAway IS "H" OR ESAHomeAway IS "A")>
		<span class="pix10boldred">ERROR ESAHomeAway is not A or H, ESAFixtureID #ESAFixtureID# ESAPlayerID #ESAPlayerID# - appearance ignored<br></span>
		<cfflush>
	<cfelse>
		<cfquery name="Insrtappearances" datasource="#ThisDB#" >
			INSERT INTO esa_appearances 
				(ESAFixtureID, ESAHomeAway, ESAPlayerID, ESAGoals, ESAOwnGoals, ESACardValue, ESAStarPlayer)
			VALUES 
			( 
			#ESAFixtureID#, 
			'#ESAHomeAway#',
			#ESAPlayerID#,
			#ESAGoals#,
			#ESAOwnGoals#,
			#ESACardValue#,
			#ESAStarPlayer#
			)
		</cfquery>
	</cfif>
</cfoutput>
<cfoutput><span class="pix10">esa_appearances loaded ...<br></span></cfoutput>
<cfflush>

<!---
games.csv - go from ESA spreadsheet data into a temporary ESA players table
=========
Column1 = ESAFixtureID
Column2 = ESARefereeID
Column3 = FixtureDate
Column4 = DivisionName
Column5 = HomeTeamName 
Column6 = HomeGoals
Column7 = Versus  - leave empty
Column8 = AwayGoals
Column9 = AwayTeamName
--->
<cfset objPOI = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />
<cfset ESAname = "games">
<cfset Spreadsheet = "#ESAname#.xls">
<cfset objSheet = objPOI.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />
<cfquery Name="Q#ESAname#" dbtype="query">
	SELECT
		Column1 as ESAFixtureID,
		Column2 as ESARefereeID,
		Column3 as ESAFixtureDate,
		Column4 as ESADivisionName,
		Column5 as ESAHomeTeamName,
		Column6 as ESAHomeGoals,
		Column7 as ESAVersus, <!--- ignored --->
		Column8 as ESAAwayGoals,
		Column9 as ESAAwayTeamName
	FROM
		objsheet.Query
</cfquery>
<!--- copy this spreadsheet into MySQL table --->
<cfoutput query="Q#ESAname#">
	<cfquery name="Insrtappearances" datasource="#ThisDB#" >
		INSERT INTO esa_games <!--- only 8 columns --->
			(ESAFixtureID, ESARefereeID, ESAFixtureDate, ESADivisionName, ESAHomeTeamName, ESAHomeGoals, ESAAwayGoals, ESAAwayTeamName)
		VALUES 
		( 
		#ESAFixtureID#, 
		<cfif Trim(ESARefereeID) IS ''>NULL<cfelse>#ESARefereeID#</cfif>,
		'#DateFormat(ESAFixtureDate, "YYYY-MM-DD")#',
		'#ESADivisionName#',
		'#ESAHomeTeamName#',
		<cfif Trim(ESAHomeGoals) IS ''>NULL<cfelse>#ESAHomeGoals#</cfif>,		
		<cfif Trim(ESAAwayGoals) IS ''>NULL<cfelse>#ESAAwayGoals#</cfif>,		
		'#ESAAwayTeamName#'
		)
	</cfquery>
</cfoutput>
<cfoutput><span class="pix10">esa_games loaded ...<br></span></cfoutput>
<cfflush>

<!--- get the OWNGOAL player in football.mitoo --->
<cfquery name="QOG" datasource="#ThisDB#">
	SELECT
		ID
	FROM
		player
	WHERE
		LeagueCode='CONF'
		AND shortcol = 0
</cfquery>
<cfset OGID = QOG.ID >

<!--- Get default Referee ID --->
<cfquery Name="QNoReferee" datasource="#ThisDB#">
	SELECT
		ID 
	FROM
		referee 
	WHERE
		LeagueCode ='CONF'
		AND LEFT(Notes,10) = 'No Referee'
</cfquery>
<cfset NullRefereeID = QNoReferee.ID >
<!--- Get default KORound ID --->
<cfquery Name="QKORoundID" datasource="#ThisDB#">
	SELECT
		ID 
	FROM
		koround 
	WHERE
		LeagueCode ='CONF'
		AND LEFT(Notes,26) = 'Blank for non KO Divisions'
</cfquery>
<cfset NullKORoundID = QKORoundID.ID >

<cfquery Name="QDivisionNames" datasource="#ThisDB#">
	SELECT DISTINCT
		ESADivisionName as DivisionName
	FROM
		esa_games
</cfquery>
<cfset ListOfDivisionIDs = "">
<cfset DivisionsAllOK = "Yes">
<cfoutput query="QDivisionNames">
	<cfif DivisionName IS ''>
	<cfelse>
	<!--- Get Division ID from DivisionName --->
		<cfquery Name="QDivName" datasource="#ThisDB#">
			SELECT
				ID 
			FROM
				division 
			WHERE
				LeagueCode = 'CONF'
				AND LongCol = '#DivisionName#'
		</cfquery>
		<cfif QDivName.RecordCount IS 1>
			<cfset DivisionID = QDivName.ID >
			<cfset ListOfDivisionIDs = ListAppend(ListOfDivisionIDs,#DivisionID#)>
		<cfelse>
			DivisionID error
			<cfabort>
		</cfif>
	</cfif>
</cfoutput>
<cfif DivisionsAllOK IS "No">
	DivisionsAllOK bad
	<cfabort>
</cfif>

<cfquery name="DelLeagueTable" datasource="#ThisDB#">
	DELETE FROM 
		leaguetable
	WHERE 
		DivisionID IN ( #ListOfDivisionIDs#  )
</cfquery>
<cfset InputDivisionNameList=ValueList(QDivisionNames.DivisionName)>
<cfset EverythingOK = "Yes">
<cfloop index="i" from="1" to="#ListLen(InputDivisionNameList)#">
	<cfquery Name="QTeamNames" datasource="#ThisDB#">
		SELECT DISTINCT
			ESAHomeTeamName as TeamName,
			ESADivisionName
		FROM
			esa_games
		WHERE
			ESADivisionName = '#ListGetAt(InputDivisionNameList, i)#'
	</cfquery>
	<cfset InputTeamNameList=ValueList(QTeamNames.TeamName)>
	<cfloop index="j" from="1" to="#ListLen(InputTeamNameList)#">
		<cfquery Name="QCheckTeamName" datasource="#ThisDB#">
			SELECT
				CASE
					WHEN o.longcol IS NULL THEN t.longcol
					ELSE CONCAT(t.longcol, ' ', o.longcol)
				END
				as fmTeamName,
				c.ID as CID
			FROM
				constitution c,
				team t,
				ordinal o,
				division d
			WHERE
				c.LeagueCode = 'CONF'
				AND d.ID = #ListGetAt(ListOfDivisionIDs, i)#
				AND t.ID = c.TeamID
				AND o.ID = c.OrdinalID
				AND c.DivisionID = d.ID
				AND
				CASE
					WHEN o.longcol IS NULL THEN t.longcol
					ELSE CONCAT(t.longcol, ' ', o.longcol)
				END
				 = '#ListGetAt(InputTeamNameList, j)#';
		</cfquery>
		<cfif QCheckTeamName.RecordCount IS 0>
			<cfset EverythingOK = "No">
		<cfelseif QCheckTeamName.RecordCount IS 1>
		<cfelse>
			<cfset EverythingOK = "No">
		</cfif>
	</cfloop>
	<!--- Get all the fm Team Names for this Division --->
	<cfquery Name="QfmTeamNames" datasource="#ThisDB#">
		SELECT
			CASE
				WHEN o.longcol IS NULL THEN t.longcol
				ELSE CONCAT(t.longcol, ' ', o.longcol)
			END
			as fmTeamName
		FROM
			constitution c,
			team t,
			ordinal o,
			division d
		WHERE
			c.LeagueCode = 'CONF'
			AND d.ID = #ListGetAt(ListOfDivisionIDs, i)#
			AND t.ID = c.TeamID
			AND o.ID = c.OrdinalID
			AND c.DivisionID = d.ID
		ORDER BY
			fmTeamName
	</cfquery>
</cfloop>

<cfif EverythingOK IS "No">
	EverythingOK IS "No"
	<cfabort>
</cfif>
<cfquery Name="Qgames" datasource="#ThisDB#">
	SELECT
		ESAFixtureID,
		ESARefereeID,
		ESAFixtureDate,
		ESADivisionName,
		ESAHomeTeamName,
		ESAHomeGoals,
		ESAAwayGoals,
		ESAAwayTeamName
	FROM
		esa_games
	ORDER BY
		ESADivisionName, ESAHomeTeamName, ESAFixtureDate
</cfquery>
<cfoutput query="Qgames">
	<cfquery name="Q01" datasource="#ThisDB#">
		SELECT 
			ID as ThisDivisionID
		FROM 
			division 
		WHERE 
			LeagueCode='CONF' 
			AND LongCol = '#ESADivisionName#'
	</cfquery>
	<cfquery name="Q02" datasource="#ThisDB#">
		SELECT
			c.ID as HomeID
		FROM
			constitution c,
			team t,
			ordinal o,
			division d
		WHERE
			c.LeagueCode = 'CONF'
			AND d.ID = #Q01.ThisDivisionID#
			AND t.longcol = '#ESAHomeTeamName#'
			AND t.ID = c.TeamID
			AND o.ID = c.OrdinalID
			AND c.DivisionID = d.ID
	</cfquery>
	<cfquery name="Q03" datasource="#ThisDB#">
		SELECT
			c.ID as AwayID
		FROM
			constitution c,
			team t,
			ordinal o,
			division d
		WHERE
			c.LeagueCode = 'CONF'
			AND d.ID = #Q01.ThisDivisionID#
			AND t.longcol = '#ESAAwayTeamName#'
			AND t.ID = c.TeamID
			AND o.ID = c.OrdinalID
			AND c.DivisionID = d.ID
	</cfquery>
	<cfquery name="Q04" datasource="#ThisDB#">
		SELECT
			ID as RID
		FROM
			referee
		WHERE
			LeagueCode = 'CONF'
			AND Notes = '#ESARefereeID#'
	</cfquery>
	
	<cfif Q04.RecordCount IS 1>
		<cfset ThisRefereeID = Q04.RID>
	<cfelse>
		<cfset ThisRefereeID = NullRefereeID >
	</cfif>
<!--- assume no Postponed, Abandoned etc  games --->
	<cfquery Name="Insert#ThisLeagueCode#" datasource="#ThisDB#">
		INSERT INTO
			fixture 
		(HomeID, AwayID, 
		MatchNumber,
		FixtureDate, HomeGoals, AwayGoals, 
		Result, RefereeID, RefereeMarksH, RefereeMarksA, AsstRef1ID, AsstRef1Marks, 
		AsstRef2ID, AsstRef2Marks, FourthOfficialID, AssessorID, AssessmentMarks, 
		MatchOfficialsExpenses, HomeSportsmanshipMarks, AwaySportsmanshipMarks, 
		KORoundID, Fixturenotes, HomePointsAdjust, AwayPointsAdjust, LeagueCode, 
		Attendance, HomeClubOfficialsBenches, AwayClubOfficialsBenches, 
		StateOfPitch, ClubFacilities, Hospitality, AsstRef1MarksH, AsstRef1MarksA, 
		AsstRef2MarksH, AsstRef2MarksA, HospitalityMarks, 
		PitchAvailableID, <!--- -------------------------------------- use PitchAvailableID to store ESAFixtureID --->
		HomeTeamSheetOK, AwayTeamSheetOK )
		VALUES
		(#Q02.HomeID#, #Q03.AwayID#, 0, '#dateformat(ESAFixtureDate, 'YYYY-MM-DD')#', 
		<cfif Trim(ESAHomeGoals) IS ''>NULL<cfelse>#ESAHomeGoals#</cfif>, <cfif Trim(ESAAwayGoals) IS ''>NULL<cfelse>#ESAAwayGoals#</cfif>, 
		NULL, #ThisRefereeID#, NULL, NULL, #NullRefereeID#, NULL, 
		#NullRefereeID#, NULL, #NullRefereeID#, #NullRefereeID#, NULL, 
		0, NULL, NULL, #NullKORoundID#, NULL, NULL, NULL, 'CONF', 
		NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, #ESAFixtureID#,
		1, 1 )
	</cfquery>
</cfoutput>
<cfoutput><span class="pix10">fixture table loaded ...<br></span></cfoutput>
<cfflush>


<!--- get each player ........... --->
<cfquery Name="Qplayers" datasource="#ThisDB#">
	SELECT
		DISTINCT ESAPlayerID
	FROM
		esa_players
	ORDER BY 
		ESAPlayerID
</cfquery>
<cfloop query="Qplayers">
	<cfquery Name="QThisPlayer" datasource="#ThisDB#">
		SELECT
			ESAPlayerID, 
			ESAForenames, 
			ESASurname, 
			ESAPosition, 
			ESAPlayerDoB,
			ESATeamName
		FROM
			esa_players
		WHERE
			ESAPlayerID = #Qplayers.ESAPlayerID#
	</cfquery>
	<!---  insert this player --->
	<cfquery name="QInsrtPlayer" datasource="#ThisDB#">
		INSERT INTO 
			player 
				(mediumCol, 
				shortCol, 
				notes, 
				LeagueCode, 
				surname, 
				forename
				)
				values
				(<cfif QThisPlayer.ESAPlayerDoB IS ''>NULL<cfelse>'#DateFormat(QThisPlayer.ESAPlayerDOB, "YYYY-MM-DD")#'</cfif>, 
				#ESAPlayerID#, 
				'#QThisPlayer.ESAPosition#', 
				'CONF', 
				'#QThisPlayer.ESASurname#', 
				'#QThisPlayer.ESAForenames#'
				)
	</cfquery>
	<!---  just after inserting this new row in the Player table we need to get the ID --->
	<cfquery name="QPlayerID" datasource="#ThisDB#">
		SELECT
			ID
		FROM
			player
		WHERE
			LeagueCode = 'CONF'
			AND ShortCol = #QThisPlayer.ESAPlayerID#
	</cfquery>
	<!--- look at all his appearances  --->
	<cfquery name="QAppearances" datasource="#ThisDB#">
		SELECT
			CASE
				WHEN a.ESAHomeAway='H' AND a.ESAOwnGoals=0 THEN g.ESAHomeTeamName
				WHEN a.ESAHomeAway='H' AND a.ESAOwnGoals>0 THEN g.ESAAwayTeamName
				WHEN a.ESAHomeAway='A' AND a.ESAOwnGoals=0 THEN g.ESAAwayTeamName
				ELSE g.ESAHomeTeamName 
			END
			    as CurrentTeam,
			g.ESAFixtureDate,
			a.ESAGoals,
			a.ESAOwnGoals,
			a.ESACardValue,
			a.ESAFixtureID
		FROM 
			esa_appearances a, 
			esa_games g 
		WHERE 
			a.esaplayerid = #Qplayers.ESAPlayerID#
			and a.ESAFixtureID = g.ESAFixtureID
		ORDER BY
			ESAFixtureDate
	</cfquery>
	
	
	<cfif QAppearances.RecordCount IS 0>
	<!--- this means that the player has made no appearances so register him for the whole season i.e. no first or last day --->
		<!---  INSERT register record --->
		<!--- Get the TeamID  --->
		<cfquery name="QTeamID" datasource="#ThisDB#">
			SELECT ID FROM team	WHERE LeagueCode = 'CONF' AND MediumCol = '#QThisPlayer.ESATeamName#' <!--- NOTE: compare MediumCol --->
		</cfquery>
		<cfquery name="INSERTregisterrecord" datasource="#ThisDB#" >
			INSERT INTO
				register
				(TeamID, PlayerID, RegType, LeagueCode) 
			VALUES
				( #QTeamID.ID#, #QPlayerID.ID#, 'B', 'CONF' ) <!--- "B" RegType is "Contract" --->
		</cfquery>
		<!---  finished with INSERT of register record --->
	<cfelse>
	<!--- this means that the player has made appearances so register him as necessary --->
		<cfset CurrentTeamList = ValueList(QAppearances.CurrentTeam)>
		<cfset ESAFixtureDateList = ValueList(QAppearances.ESAFixtureDate)>
		<cfloop index="r" from="1" to="#ListLen(CurrentTeamList)#" step="1" >
			<cfif r IS 1 >
				<!--- first appearance for this player --->
				<cfset SaveTeam = ListGetAt(CurrentTeamList,1)>
				<cfset FirstDay = ListGetAt(ESAFixtureDateList,1)>
			</cfif>
			
			<cfif NOT ListGetAt(CurrentTeamList,r) IS SaveTeam>
				<cfset LastDay = ListGetAt(ESAFixtureDateList,(r-1)) >
				<!---  INSERT register record --->
				<!--- Get the TeamID  --->
				<cfquery name="QTeamID" datasource="#ThisDB#">
					SELECT ID FROM team	WHERE LeagueCode = 'CONF' AND LongCol = '#SaveTeam#'
				</cfquery>
				<cfquery name="INSERTregisterrecord" datasource="#ThisDB#" >
					INSERT INTO
						register
						(TeamID, PlayerID, FirstDay, LastDay, RegType, LeagueCode) 
					VALUES
						( #QTeamID.ID#, #QPlayerID.ID#, '#DateFormat(FirstDay, 'YYYY-MM-DD')#', '#DateFormat(LastDay, 'YYYY-MM-DD')#', 'B', 'CONF' ) <!--- "B" RegType is "Contract" --->
				</cfquery>
				<!---  finished with INSERT of register record --->
				
				<cfset SaveTeam = ListGetAt(CurrentTeamList,r)>
				<cfset FirstDay = ListGetAt(ESAFixtureDateList,r)>
			</cfif>
			
			<cfif r IS #ListLen(CurrentTeamList)# >
				<!--- final appearance for this player , let's assume he is still registered to this club so LastDay will be kept blank --->
				<!---  INSERT register record --->
				<!--- Get the TeamID  --->
				<cfquery name="QTeamID" datasource="#ThisDB#">
					SELECT ID FROM team	WHERE LeagueCode = 'CONF' AND LongCol = '#SaveTeam#'
				</cfquery>
				<cfquery name="INSERTregisterrecord" datasource="#ThisDB#" >
					INSERT INTO
						register
						(TeamID, PlayerID, FirstDay,  RegType, LeagueCode) 
					VALUES
						( #QTeamID.ID#, #QPlayerID.ID#, '#DateFormat(FirstDay, 'YYYY-MM-DD')#',  'B', 'CONF' ) <!--- "B" RegType is "Contract" --->
				</cfquery>
				<!---  finished with INSERT of register record --->
			</cfif>
		</cfloop>
	</cfif>
	
</cfloop>
	
	
	
	
	
	
	
							
<!--- get the OWNGOAL player in football.mitoo --->
<cfquery name="QOG" datasource="#ThisDB#">
	SELECT
		ID
	FROM
		player
	WHERE
		LeagueCode='CONF'
		AND shortcol = 0
</cfquery>
<cfset OGID = QOG.ID >
<!--------------------------------------------------->

<cfquery name="QESAappearances" datasource="#ThisDB#">
	SELECT
		ESAFixtureID, 
		ESAHomeAway, 
		ESAPlayerID, 
		ESAGoals, 
		ESAOwnGoals, 
		ESACardValue, 
		ESAStarPlayer
	FROM
		esa_appearances
	ORDER BY
		ESAFixtureID
</cfquery>

<cfoutput query="QESAappearances">
	<!--- get corresponding fixture in football.mitoo --->
	<cfquery name="QFixture" datasource="#ThisDB#">
		SELECT
			f.ID as FID,
			f.fixturedate
		FROM 
			fixture f
		WHERE
			f.LeagueCode='CONF'
			AND f.PitchAvailableID = '#QESAappearances.ESAFixtureID#'
	</cfquery>
	
	<cfif ESAOwnGoals IS 0>		 
		<!--- get corresponding player in football.mitoo --->
		<cfquery name="QPlayer" datasource="#ThisDB#">
			SELECT
				ID as PID
			FROM
				player
			WHERE
				LeagueCode='CONF'
				AND shortcol = #ESAPlayerID#
		</cfquery>
		<cfif QPlayer.RecordCount IS 0 >
			<span class="pix10boldred">ERROR ESAPlayerID #ESAPlayerID# not found for ESAappearance #QESAappearances.ESAFixtureID# <br></span>
			<cfflush>
		<cfelse>
			<!--- Insert an appearance record --->
			<cfquery name="InsertAppearance" datasource="#ThisDB#">
				INSERT INTO
					appearance
					(FixtureID, HomeAway, PlayerID,	GoalsScored, Card, LeagueCode)
				VALUES
					(
					#QFixture.FID#,
					'#QESAappearances.ESAHomeAway#',
					#QPlayer.PID#,
					#ESAGoals#,
					#ESACardValue#,
					'CONF'
					)
			</cfquery>
		</cfif>
	<cfelse>
		<!--- get corresponding player in football.mitoo --->
		<cfquery name="QPlayer" datasource="#ThisDB#">
			SELECT
				ID as PID
			FROM
				player
			WHERE
				LeagueCode='CONF'
				AND shortcol = #ESAPlayerID#
		</cfquery>
		<cfif QPlayer.RecordCount IS 0 >
			<span class="pix10boldred">ERROR ESAPlayerID #ESAPlayerID# not found for ESAappearance #QESAappearances.ESAFixtureID# <br></span>
			<cfflush>
		<cfelse>
			<!--- Insert an appearance record --->
			<cfquery name="InsertAppearance" datasource="#ThisDB#">
				INSERT INTO
					appearance
					(FixtureID, HomeAway, PlayerID,	GoalsScored, Card, LeagueCode)
				VALUES
					(
					#QFixture.FID#,
					IF('#QESAappearances.ESAHomeAway#'='H','A','H'),
					#QPlayer.PID#,
					#ESAGoals#,
					#ESACardValue#,
					'CONF'
					)
			</cfquery>
		</cfif>
	</cfif>
	
<!--- now process own goals for the fm "own goal" imaginary player --->	
	
	<!--- if there is already an OWNGOAL appearance then update otherwise create --->
	<cfset UpdateOwnGoals = "No">
	<cfquery name="OwnGoalAppearance" datasource="#ThisDB#">
		SELECT
			ID, 
			GoalsScored
		FROM
			appearance
		WHERE
			LeagueCode='CONF'
			AND FixtureID = #QFixture.FID#
			AND PlayerID = #OGID#
			AND HomeAway = '#QESAappearances.ESAHomeAway#'
	</cfquery>
	<cfif OwnGoalAppearance.RecordCount IS 1>
		<cfset UpdateOwnGoals = "Yes">
	</cfif>
			
	<cfif UpdateOwnGoals IS "Yes"> <!--- update own goals --->
		<cfquery name="UpdateAppearance" datasource="#ThisDB#">
			UPDATE
				appearance
				SET GoalsScored=(#OwnGoalAppearance.GoalsScored#+#QESAappearances.ESAOwnGoals#)
			WHERE
				ID = #OwnGoalAppearance.ID#
		</cfquery>
	<cfelse>
		<cfif QESAappearances.ESAOwnGoals GT 0>		 
			<cfquery name="InsertAppearance" datasource="#ThisDB#">
				INSERT INTO
					appearance
					(FixtureID, HomeAway, PlayerID,	GoalsScored, Card, LeagueCode)
			VALUES
				(
				#QFixture.FID#,
				'#QESAappearances.ESAHomeAway#',
				#OGID#,
				#QESAappearances.ESAOwnGoals#,
				0,
				'CONF'
				)
			</cfquery>
		</cfif>
	</cfif>
	
	
	
</cfoutput>			
