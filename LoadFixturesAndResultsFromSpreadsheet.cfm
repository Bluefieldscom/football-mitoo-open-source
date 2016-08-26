<!---  FixturesAndResults spreadsheet must be in this format 
column1 as FixtureDate,                <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<       THIS MUST BE IN YYYY-MM-DD TEXT FORMAT
column2 as DivisionName,
column3 as HomeTeamName,
column4 as HomeGoals,
column5 as Versus,
column6 as AwayGoals,
column7 as AwayTeamName,
column8 as Notes,
column9 as KOTime in HH:MM:SS format


The spreadsheet should be put in the same directory as the .cfm code 

--->


<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfset ThisLeagueCode = url.LeagueCode >                                           <!--- e.g. "SDWFL2009" ---> 
<cfset ThisLeagueCodePrefix = Left(ThisLeagueCode, (Len(TRIM(ThisLeagueCode))-4))> <!--- e.g. "SDWFL" --->
<cfset ThisDB = "fm#Right(url.LeagueCode,4)#">                                     <!--- e.g. "fm2009" --->
<cfset Thiscellpadding = "2" >
<cfset Thiscellspacing = "2" >
<!--- e.g. LoadFixturesAndResultsFromSpreadsheet.cfm?LeagueCode=SDWFL2009&delete=no --->
<cfoutput>
	<!--- OPTIONAL - clear out any previous fixtures --->
	<cfif NOT StructKeyExists(url, "delete") >
		"delete" parameter must be specified<br><br><br>
		LoadFixturesAndResultsFromSpreadsheet.cfm?LeagueCode=#LeagueCode#&delete=no<br><br>
		<cfabort>
	</cfif> 
</cfoutput>
<cfif url.delete IS "Yes">
	<cfquery name="DelFixtures" datasource="#ThisDB#">
		DELETE FROM 
			fixture
		WHERE 
			LeagueCode = '#ThisLeagueCodePrefix#'
	</cfquery>
</cfif>

<cfset objPOI = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />

<cfset spreadsheetname = "#ThisLeagueCode#FixturesAndResults">
<cfset Spreadsheet = "#spreadsheetname#.xls">
<cfset zzz = ExpandPath( "./#Spreadsheet#" )>
<cfoutput>#zzz#<br></cfoutput>
<cfset objSheet = objPOI.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />
 

<cfquery Name="QDivisionNames" dbtype="query" >
	SELECT DISTINCT
		column2 as DivisionName
	FROM
		objsheet.query
</cfquery>

<table class="pix10">
	<tr>
		<td valign="top">
			<!--- Get default Referee ID --->
			<cfquery Name="QNoReferee" datasource="#ThisDB#">
				SELECT
					ID 
				FROM
					referee 
				WHERE
					LeagueCode = '#ThisLeagueCodePrefix#'
					AND LEFT(Notes,10) = 'No Referee'
			</cfquery>
			<cfif QNoReferee.RecordCount IS 1>
			<cfelse>
				QNoReferee error
				<cfabort>
			</cfif>
			<cfset NullRefereeID = QNoReferee.ID >
			<cfoutput>
				<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix13">
					<tr>
						<td><cfoutput>NullRefereeID</cfoutput></td>
					</tr>
					<tr>
						<td><cfoutput>#NullRefereeID#</cfoutput></td>
					</tr>
				</table>
			</cfoutput>
		</td>
		<td valign="top">
			<!--- Get default KORound ID --->
			<cfquery Name="QKORoundID" datasource="#ThisDB#">
				SELECT
					ID 
				FROM
					koround 
				WHERE
					LeagueCode = '#ThisLeagueCodePrefix#'
					AND LEFT(Notes,26) = 'Blank for non KO Divisions'
			</cfquery>
			<cfif QKORoundID.RecordCount IS 1>
			<cfelse>
				QKORoundID error
				<cfabort>
			</cfif>
			<cfset NullKORoundID = QKORoundID.ID >
			<cfoutput>
				<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix13">
					<tr>
						<td><cfoutput>NullKORoundID</cfoutput></td>
					</tr>
					<tr>
						<td><cfoutput>#NullKORoundID#</cfoutput></td>
					</tr>
				</table>
			</cfoutput>
		</td>
		<td>
			<cfoutput>
				<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix13">
			</cfoutput>
					<tr>
						<td>DivisionNames</td>
						<td>DivisionID</td>
					</tr>
					<cfset ListOfDivisionIDs = "">
					<cfset DivisionsAllOK = "Yes">
					<cfoutput query="QDivisionNames">
						<cfif DivisionName IS ''>
						<cfelse>
							<tr>
								<td>#DivisionName#</td>
								<!--- Get Division ID from DivisionName --->
									<cfquery Name="QDivName" datasource="#ThisDB#">
										SELECT
											ID 
										FROM
											division 
										WHERE
											LeagueCode = '#ThisLeagueCodePrefix#'
											AND LongCol = '#DivisionName#'
									</cfquery>
									<cfif QDivName.RecordCount IS 1>
										<cfset DivisionID = QDivName.ID >
										<cfset ListOfDivisionIDs = ListAppend(ListOfDivisionIDs,#DivisionID#)>
										<td>#DivisionID#</td>
									<cfelse>
										<td bgcolor="red"><strong>FAIL</strong></td>
										<cfset DivisionsAllOK = "No">
									</cfif>
							</tr>
						</cfif>
					</cfoutput>
				</table>
				<cfif DivisionsAllOK IS "No">
					<cfabort>
				</cfif>
			</td>
		</tr>

		<cfquery name="DelLeagueTable" datasource="#ThisDB#">
			DELETE FROM 
				leaguetable
			WHERE 
				DivisionID IN ( #ListOfDivisionIDs#  )
		</cfquery>

		<tr>
			<cfset InputDivisionNameList=ValueList(QDivisionNames.DivisionName)>

			<!---
			<cfloop index="i" list="#InputDivisionNameList#">
				<cfoutput>#i#</cfoutput>
			</cfloop>
			<br>
			<cfloop index="i" list="#ListOfDivisionIDs#">
				<cfoutput>#i#</cfoutput>
			</cfloop>
			--->

			<cfset EverythingOK = "Yes">
			<cfloop index="i" from="1" to="#ListLen(InputDivisionNameList)#">
				<td valign="top">
				<cfoutput>
					<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix10">
				</cfoutput>
						<tr>
							<td colspan="2" align="center">Home Teams Input <cfoutput><strong>#ListGetAt(InputDivisionNameList, i)#</strong></cfoutput></td>
						</tr>
						<cfquery Name="QTeamNames" dbtype="query">
							SELECT DISTINCT
								column3 as TeamName,
								column2
							FROM
								objsheet.query
							WHERE
								column2 = '#ListGetAt(InputDivisionNameList, i)#'
						</cfquery>
							
						<cfset InputTeamNameList=ValueList(QTeamNames.TeamName)>
						<cfloop index="j" from="1" to="#ListLen(InputTeamNameList)#">
							<tr>
								<td><cfoutput>#ListGetAt(InputTeamNameList, j)#</cfoutput></td>
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
											c.LeagueCode = '#ThisLeagueCodePrefix#'
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
										<td bgcolor="red"><strong>FAIL</strong></td>
										<cfset EverythingOK = "No">
									<cfelseif QCheckTeamName.RecordCount IS 1>
										<td><cfoutput>#QCheckTeamName.CID#</cfoutput></td>
									<cfelse>
										<cfset EverythingOK = "No">
										<td>ERROR</td>
									</cfif>
							</tr>
									
						</cfloop>
					</table>
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
						c.LeagueCode = '#ThisLeagueCodePrefix#'
						AND d.ID = #ListGetAt(ListOfDivisionIDs, i)#
						AND t.ID = c.TeamID
						AND o.ID = c.OrdinalID
						AND c.DivisionID = d.ID
					ORDER BY
						fmTeamName
				</cfquery>
				<cfoutput>
					<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix10navy">
				</cfoutput>
						<tr>
							<td colspan="2" align="center">fm <cfoutput><strong>#ListGetAt(InputDivisionNameList, i)#</strong></cfoutput></td>
						</tr>
						<cfoutput query="QfmTeamNames">
							<tr>
								<td>#fmTeamName#</td>
							</tr>
						</cfoutput>
					</table>
				</td>
			</cfloop>
			
			



			<cfloop index="i" from="1" to="#ListLen(InputDivisionNameList)#">
				<td valign="top">
				<cfoutput>
					<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix10">
				</cfoutput>
						<tr>
							<td colspan="2" align="center">Away Teams Input <cfoutput><strong>#ListGetAt(InputDivisionNameList, i)#</strong></cfoutput></td>
						</tr>
						<cfquery Name="QTeamNames" dbtype="query">
							SELECT DISTINCT
								column7 as TeamName,
								column2
							FROM
								objsheet.query
							WHERE
								column2 = '#ListGetAt(InputDivisionNameList, i)#'
						</cfquery>
							
						<cfset InputTeamNameList=ValueList(QTeamNames.TeamName)>
						<cfloop index="j" from="1" to="#ListLen(InputTeamNameList)#">
							<tr>
								<td><cfoutput>#ListGetAt(InputTeamNameList, j)#</cfoutput></td>
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
											c.LeagueCode = '#ThisLeagueCodePrefix#'
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
										<td bgcolor="red"><strong>FAIL</strong></td>
										<cfset EverythingOK = "No">
									<cfelseif QCheckTeamName.RecordCount IS 1>
										<td><cfoutput>#QCheckTeamName.CID#</cfoutput></td>
									<cfelse>
										<cfset EverythingOK = "No">
										<td>ERROR</td>
									</cfif>
							</tr>
									
						</cfloop>
					</table>
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
						c.LeagueCode = '#ThisLeagueCodePrefix#'
						AND d.ID = #ListGetAt(ListOfDivisionIDs, i)#
						AND t.ID = c.TeamID
						AND o.ID = c.OrdinalID
						AND c.DivisionID = d.ID
					ORDER BY
						fmTeamName
				</cfquery>
				<cfoutput>
					<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix10navy">
				</cfoutput>
						<tr>
							<td colspan="2" align="center">fm <cfoutput><strong>#ListGetAt(InputDivisionNameList, i)#</strong></cfoutput></td>
						</tr>
						<cfoutput query="QfmTeamNames">
							<tr>
								<td>#fmTeamName#</td>
							</tr>
						</cfoutput>
					</table>
				</td>
			</cfloop>






			
		</tr>
</table>
<cfflush>
<cfif EverythingOK IS "No">
	<cfabort>
</cfif>
<cfquery Name="QXLS" dbtype="query">
SELECT
		column1 as FixtureDate,
		column2 as DivisionName,
		column3 as HomeTeamName,
		column4 as HomeGoals,
		column5 as Versus,
		column6 as AwayGoals,
		column7 as AwayTeamName,
		column8 as Notes,
		column9 as KOTime
	FROM
		objsheet.query
</cfquery>

<cfoutput query="QXLS">
	<cfquery name="Q01" datasource="#ThisDB#">
		SELECT 
			ID as ThisDivisionID
		FROM 
			division 
		WHERE 
			LeagueCode='#ThisLeagueCodePrefix#' 
			AND LongCol = '#DivisionName#'
	</cfquery>
	<cfif Q01.RecordCount IS 1>
	<cfelse>
		ERROR Q01: ThisLeagueCodePrefix is #ThisLeagueCodePrefix# ThisDivisionID is #Q01.ThisDivisionID# <br>
		<cfabort>
	</cfif>
	
	<cfquery name="Q02" datasource="#ThisDB#">
		SELECT
			c.ID as HomeID
		FROM
			constitution c,
			team t,
			ordinal o,
			division d
		WHERE
			c.LeagueCode = '#ThisLeagueCodePrefix#'
			AND d.ID = #Q01.ThisDivisionID#
		AND CASE
		WHEN o.longcol IS NULL THEN t.longcol
		ELSE CONCAT(t.longcol, ' ', o.longcol)
		END = '#HomeTeamName#'
			AND t.ID = c.TeamID
			AND o.ID = c.OrdinalID
			AND c.DivisionID = d.ID
	</cfquery>
	<cfif Q02.RecordCount IS 1>
	<cfelse>
		ERROR Q02: #ThisLeagueCodePrefix# #Q01.ThisDivisionID# #HomeTeamName#<br>Q02.RecordCount IS #Q02.RecordCount#
		<cfabort>
	</cfif>
	
	<cfquery name="Q03" datasource="#ThisDB#">
		SELECT
			c.ID as AwayID
		FROM
			constitution c,
			team t,
			ordinal o,
			division d
		WHERE
			c.LeagueCode = '#ThisLeagueCodePrefix#'
			AND d.ID = #Q01.ThisDivisionID#
		AND CASE
		WHEN o.longcol IS NULL THEN t.longcol
		ELSE CONCAT(t.longcol, ' ', o.longcol)
		END = '#AwayTeamName#'
			AND t.ID = c.TeamID
			AND o.ID = c.OrdinalID
			AND c.DivisionID = d.ID
	</cfquery>
	<cfif Q03.RecordCount IS 1>
	<cfelse>
		ERROR Q03: #ThisLeagueCodePrefix# #Q03.AwayID# #HomeTeamName# v #AwayTeamName#<br>Q03.RecordCount IS #Q03.RecordCount#
		<cfabort>
	</cfif>
	
	<!--- ignore Postponed, Abandoned etc  games --->
		<cfif (IsNumeric(HomeGoals) AND IsNumeric(AwayGoals)) OR (Trim(HomeGoals) IS '' AND Trim(AwayGoals) IS '')>
			<cfquery Name="Insert#ThisLeagueCode#" datasource="#ThisDB#">
				INSERT INTO
					fixture 
				(HomeID, AwayID, MatchNumber, FixtureDate, HomeGoals, AwayGoals, 
				Result, RefereeID, RefereeMarksH, RefereeMarksA, AsstRef1ID, AsstRef1Marks, 
				AsstRef2ID, AsstRef2Marks, FourthOfficialID, AssessorID, AssessmentMarks, 
				MatchOfficialsExpenses, HomeSportsmanshipMarks, AwaySportsmanshipMarks, 
				KORoundID, Fixturenotes, HomePointsAdjust, AwayPointsAdjust, LeagueCode, 
				Attendance, HomeClubOfficialsBenches, AwayClubOfficialsBenches, 
				StateOfPitch, ClubFacilities, Hospitality, AsstRef1MarksH, AsstRef1MarksA, 
				AsstRef2MarksH, AsstRef2MarksA, HospitalityMarks, PitchAvailableID, 
				HomeTeamSheetOK, AwayTeamSheetOK,
				HomeTeamNotes, AwayTeamNotes, PrivateNotes, KOTime, RefereeReportReceived, HideMatchOfficials )
				VALUES
				(#Q02.HomeID#, #Q03.AwayID#, 0, '#DateFormat(QXLS.FixtureDate, "YYYY-MM-DD")#', 
				<cfif Trim(HomeGoals) IS ''>NULL<cfelse>#HomeGoals#</cfif>, <cfif Trim(AwayGoals) IS ''>NULL<cfelse>#AwayGoals#</cfif>, 
				NULL, #NullRefereeID#, NULL, NULL, #NullRefereeID#, NULL, 
				#NullRefereeID#, NULL, #NullRefereeID#, #NullRefereeID#, NULL, 
				0, NULL, NULL, 
				#NullKORoundID#, '#Notes#', 0, 0, '#ThisLeagueCodePrefix#', 
				NULL, NULL, NULL, 
				NULL, NULL, NULL, NULL, NULL, 
				NULL, NULL, NULL, 0, 
				0, 0,
				NULL, NULL, NULL, <cfif Trim(KOTime) IS ''>NULL<cfelse>'#TimeFormat(KOTime,"HH:mm:ss")#'</cfif>, 0, 0 )
			</cfquery>
		</cfif>
</cfoutput>
	
<cfoutput><br><br><br><br><br>Fixtures and results loaded</cfoutput>
