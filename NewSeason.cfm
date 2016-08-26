<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfif StructKeyExists(url, "OldYearString") AND StructKeyExists(url, "NewYearString")  AND StructKeyExists(url, "NextYearString")>
<cfelse>
	&amp;OldYearString=2012&amp;NewYearString=2013&amp;NextYearString=2014&amp;FAKORounds=N    <br /><br /><br /><br /><br /><br />Aborting..........
<cfabort>
</cfif>

<cfset LeagueCodePrefix = UCASE(request.filter) >
<cfset FAKORounds = #url.FAKORounds# > <!--- Y or N --->
<cfset OldYearString = #url.OldYearString# > <!--- e.g. 2005 --->
<cfset NewYearString = #url.NewYearString# > <!--- e.g. 2006 --->
<cfset NextYearString = #url.NextYearString# > <!--- e.g. 2007 --->
<cfset NewDatabase = "fm#NewYearString#"> <!--- e.g. fm2006 --->
<cfset OldDatabase = "fm#OldYearString#"> <!--- e.g. fm2005 --->
<cfset defaultleaguecode = "#LeagueCodePrefix##NewYearString#" > <!--- e.g. MDX2006 --->
<cfset OldDefaultleaguecode = "#LeagueCodePrefix##OldYearString#" > <!--- e.g. MDX2005 --->
<!--- check lookup tables exists in new season fm2011 - needs to be copied manually when creating new season --->
<cfinclude template = "queries/qry_MatchNoTable.cfm">
<cfif QMatchNoTable.RecordCount IS NOT 401 >
	<cfoutput>ABORTING - #NewDatabase# - MatchNo Table not 401 rows .....</cfoutput>
	<cfabort>
</cfif>
<cfif QPitchNoTable.RecordCount IS NOT 36 >
	<cfoutput>ABORTING - #NewDatabase# - PitchNo Table not 36 rows .....</cfoutput>
	<cfabort>
</cfif>
<cfif QPitchStatusTable.RecordCount IS NOT 7 >
	<cfoutput>ABORTING - #NewDatabase# - PitchStatus Table not 7 rows .....</cfoutput>
	<cfabort>
</cfif>
<cfflush>

<!---  Check the Page Counter and abort if there has been activity on this new site --->
<cfquery name="QPageCounter" datasource="fmpagecount">
	SELECT 
		CounterLeagueCode, CounterValue, CounterStartDateTime, LastHit, CounterLeagueID
	FROM
		pagecounter
	WHERE
		counterleaguecode='#defaultleaguecode#';
</cfquery>

<cfif QPageCounter.CounterValue GT 80 >
	ABORTING - Page Counter value too high.....
	<cfabort>
<cfelseif QPageCounter.RecordCount IS 0>
	<cfoutput>ZERO Page Counter value for #defaultleaguecode#<br></cfoutput>
	<cfflush>
<cfelse>
	<cfoutput>Page Counter value #QPageCounter.CounterValue#<br></cfoutput>
	<cfflush>
</cfif>

<!--- get FirstDay & LastDay from the old season
sine die suspensions will typically have the last day of the season the same as the last day of suspension --->
<cfquery name="QLeagueInfo" datasource="zmast">
	SELECT
			SeasonStartDate,
			SeasonEndDate,
			SeasonName,
			CountiesList,
			DefaultSponsor
	FROM
			leagueinfo
	WHERE
			defaultleaguecode='#OldDefaultleaguecode#';
</cfquery>

<cfset OldSeasonStartDate = DateFormat(QLeagueInfo.SeasonStartDate, 'YYYY-MM-DD') >
<cfset OldSeasonEndDate = DateFormat(QLeagueInfo.SeasonEndDate, 'YYYY-MM-DD') >

<cfset NewSeasonStartDate = "#NewYearString##RIGHT(OldSeasonStartDate,6)#" >
<cfset NewSeasonEndDate = "#NextYearString##RIGHT(OldSeasonEndDate,6)#" >
<cfset NewSeasonName = QLeagueInfo.SeasonName >
<cfset NewSeasonName = Replace(NewSeasonName, '#NewYearString#', '#NextYearString#')	>
<cfset NewSeasonName = Replace(NewSeasonName, '#OldYearString#', '#NewYearString#')	>
<cfset DefaultSponsor = QLeagueInfo.DefaultSponsor	>
<!---
**************
* LeagueInfo *
**************
--->
<cfquery name="DeleteLeagueInfo" datasource="zmast">
	DELETE FROM leagueinfo where defaultleaguecode='#defaultleaguecode#';
</cfquery>

<cfquery name="InsertLeagueInfo" datasource="zmast">
	INSERT INTO
		leagueinfo 
			(	COUNTIESLIST, 
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
				FANPlayerRegNo, 
				VenueAndPitchAvailable, 
				SuppressTeamSheetEntry, 
				SuppressRedYellowCardsEntry, 
				SuppressTeamCommentsEntry, 
				SuppressTeamDetailsEntry, 
				SuppressKOTimeEntry, 
				SuppressLeadingGoalscorers, 
				SuppressScorelineEntry, 
				LeagueBrand, 
				ShowAssessor, 
				GoalrunTeamSheet,
				HideThisSeason,
				NoPlayerReRegistrationForm,
				ShowOnGoalrunOnly,
				MatchBasedSuspensions,
				HideSuspensions,
				SuspensionStartsAfter,
				KickOffTimeOrder,
				ClubsCanInputSportsmanshipMarks,
				MatchBanReminder, 
				SportsmanshipMarksOutOfHundred, 
				RefereeLowMarkWarning,
				SeeOppositionTeamSheet,
				RefereeMarkMustBeEntered,
				spare01,
				spare02,
				HideDoubleHdrMsg 
			)
	SELECT
			'#QLeagueInfo.CountiesList#',
			NAMESORT,
			LEAGUENAME,
			'#defaultleaguecode#',
			'#LeagueCodePrefix#',
			'#NewYearString#',
			BADGEJPEG, 
			WEBSITELINK, 
			0, 
			PointsForWin,
			PointsForDraw,
			PointsForLoss,
			LEAGUETBLCALCMETHOD, 
			DEFAULTYOUTHLEAGUE,
			'#NewSeasonName#',
			'#NewSeasonStartDate#',
			'#NewSeasonEndDate#', 
			DEFAULTRULESANDFINES,
			DEFAULTSPONSOR,
			REFMARKSOUTOFHUNDRED,
			DEFAULTGOALSCORERS,
			SupplyLeague,
			LeagueType,
			AltLeagueCodePrefix, 
			Alert, 
			RandomPlayerRegNo, 
			FANPlayerRegNo, 
			VenueAndPitchAvailable, 
			SuppressTeamSheetEntry,
			SuppressRedYellowCardsEntry,
			SuppressTeamCommentsEntry,
			SuppressKOTimeEntry,
			SuppressTeamDetailsEntry,
			SuppressLeadingGoalscorers,
			SuppressScorelineEntry,
			LeagueBrand,
			ShowAssessor,
			GoalrunTeamSheet,
			1,
			NoPlayerReRegistrationForm,
			ShowOnGoalrunOnly,
			MatchBasedSuspensions,
			HideSuspensions,
			14,
			KickOffTimeOrder,
			ClubsCanInputSportsmanshipMarks,
			MatchBanReminder, 
			SportsmanshipMarksOutOfHundred, 
			RefereeLowMarkWarning,
			SeeOppositionTeamSheet,
			RefereeMarkMustBeEntered,
			spare01,
			spare02,
			HideDoubleHdrMsg 
	FROM
			leagueinfo
	WHERE
			defaultleaguecode='#OldDefaultleaguecode#';
</cfquery>

<cfoutput>LeagueInfo Table done<br></cfoutput>
<cfflush>

<!---
****************
* PageCounter  *
****************
--->
<cfquery name="DeletePageCounter" datasource="fmpagecount">
	DELETE FROM pagecounter WHERE counterleaguecode='#defaultleaguecode#';
</cfquery>
<cfquery name="InsertPageCounter" datasource="fmpagecount">
	INSERT INTO pagecounter
			(CounterLeagueCode, CounterValue, CounterStartDateTime, LastHit, CounterLeagueID)
			VALUES
			('#defaultleaguecode#', 0, NOW(), NULL, (select id from `zmast`.`leagueinfo` where defaultleaguecode='#defaultleaguecode#'))
</cfquery>
<cfoutput>PageCounter Table done<br></cfoutput>
<cfflush>

<cfquery name="ForeignKeyCheckOff" datasource="#NewDatabase#">
	SET FOREIGN_KEY_CHECKS=0;
</cfquery>
<!---
**************
* Committee  *
**************
--->
<cfquery name="DeleteCommittee" datasource="#NewDatabase#">
	DELETE FROM committee WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertCommittee" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`committee` 
		(LongCol, MediumCol, ShortCol, Notes, LeagueCode, Title, Surname, Forename, EmailAddress1, EmailAddress2, HomeTel, WorkTel, MobileTel, AddressLine1, AddressLine2, AddressLine3, PostCode, ShowHideEmailAddress1, ShowHideEmailAddress2, ShowHideHomeTel, ShowHideWorkTel, ShowHideMobileTel, ShowHideAddress, NoMailout, CCEmailAddress1, CCEmailAddress2 )
		SELECT LongCol, MediumCol, ShortCol, Notes, LeagueCode, Title, Surname, Forename, EmailAddress1, EmailAddress2, HomeTel, WorkTel, MobileTel, AddressLine1, AddressLine2, AddressLine3, PostCode, ShowHideEmailAddress1, ShowHideEmailAddress2, ShowHideHomeTel, ShowHideWorkTel, ShowHideMobileTel, ShowHideAddress, NoMailout, CCEmailAddress1, CCEmailAddress2
		 		FROM `#OldDatabase#`.`committee` where leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfoutput>Committee Table done<br></cfoutput>
<cfflush>
<!---
**************
*   Venue    *
**************
--->
<cfquery name="DeleteVenue" datasource="#NewDatabase#">
	DELETE FROM venue WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertVenue" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`venue` 
		(LongCol, MediumCol, ShortCol, Notes, LeagueCode, AddressLine1, AddressLine2, AddressLine3, PostCode, VenueTel, MapURL, CompassPoint)
		SELECT	LongCol, MediumCol, ShortCol, Notes, LeagueCode, AddressLine1, AddressLine2, AddressLine3, PostCode, VenueTel, MapURL, CompassPoint 
		FROM `#OldDatabase#`.`venue` where leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfoutput>Venue Table done<br></cfoutput>
<cfflush>
<!---
**************
* Division   *
**************
--->
<cfquery name="DeleteDivision" datasource="#NewDatabase#">
	DELETE FROM division WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertDivision" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`division` 
		(longcol, mediumcol, shortcol, notes, LeagueCode)
		SELECT
		longcol, mediumcol, shortcol, notes, LeagueCode  
		FROM `#OldDatabase#`.`division` where leaguecode='#LeagueCodePrefix#';
</cfquery>
<!--- ============================== Terry's new ======================= --->
<cfquery name="Dropdivisionxref" datasource="zmast">
	DROP TEMPORARY TABLE IF EXISTS divisionxref;
</cfquery>

<cfquery name="Createdivisionxref" datasource="zmast">
	CREATE TEMPORARY TABLE IF NOT EXISTS divisionxref 
		(                                        
          OldID mediumint(8) unsigned NOT NULL ,        
          NewID mediumint(8) unsigned NOT NULL ,
		  DivisionName varchar(50) NOT NULL,
		  LeagueCode varchar(8) NOT NULL,         
          UNIQUE KEY OldID (OldID)  ,       
		  UNIQUE KEY NewID (NewID)                  
        ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ; 
</cfquery>
<cfquery name="Insertdivisionxref" datasource="zmast">
	INSERT INTO divisionxref
		( OldID, NewID, DivisionName, LeagueCode )
		SELECT 
			olddivision.ID,
			newdivision.ID,
			olddivision.longcol,
			olddivision.LeagueCode
		FROM
		 #OldDatabase#.division olddivision, #NewDatabase#.division newdivision
		WHERE
		olddivision.leaguecode='#LeagueCodePrefix#' AND newdivision.leaguecode='#LeagueCodePrefix#'
		AND olddivision.longcol = newdivision.longcol
</cfquery>

<cfquery name="selectdivisionxref" datasource="zmast">
	SELECT * FROM divisionxref
</cfquery>


<cfquery name="QDivision" datasource="#NewDatabase#">
	SELECT
		ID,
		Notes
	FROM
		division
	WHERE
		leaguecode='#LeagueCodePrefix#'
		AND (Notes LIKE '%Promoted=%' OR Notes LIKE '%Relegated=%');
</cfquery>
<cfoutput query="QDivision">
	<cfset TheseNotes =  "#Notes#">
	<cfset p = FindNoCase("Promoted=",TheseNotes) >
	<cfif p GT 0 >
		<cfset TheseNotes = RemoveChars(TheseNotes,p,10)>
	</cfif>
	<cfset p = FindNoCase("Relegated=",TheseNotes) >
	<cfif p GT 0 >
		<cfset TheseNotes = RemoveChars(TheseNotes,p,11)>
	</cfif>
	<cfquery name="UpdateDivision" datasource="#NewDatabase#">
		UPDATE
			division
		SET
			notes = '#TheseNotes#'
		WHERE
			ID=#QDivision.ID#;
	</cfquery>
</cfoutput>

<cfloop index="i" from="0" to="12">
	<cfset AString = #OldYearString# -7 - i >
	<cfset BString = #OldYearString# -6 - i >
	<cfquery name="QDivisionAgeBand" datasource="#NewDatabase#">
		SET @OldAgeBand='AgeBand3108#AString#'
	</cfquery>
	<cfquery name="QDivisionAgeBand" datasource="#NewDatabase#">
		SET @NewAgeBand='AgeBand3108#BString#'
	</cfquery>
	<cfquery name="QDivisionAgeBand" datasource="#NewDatabase#">
		SET @OldAgeBandPerc=concat('%',@OldAgeBand,'%')
	</cfquery>
	<cfquery name="QDivisionAgeBand" datasource="#NewDatabase#">
		SET @NewAgeBandPerc=concat('%',@NewAgeBand,'%')
	</cfquery>
	<cfquery name="QDivisionAgeBand" datasource="#NewDatabase#">
		UPDATE `#NewDatabase#`.`division` SET notes = REPLACE(notes, @OldAgeBand, @NewAgeBand) where leaguecode='#LeagueCodePrefix#' and notes like @OldAgeBandPerc
	</cfquery>
</cfloop>

<!-------
UPDATE division 
SET 
longcol = REPLACE(longcol, 'Under 8', 'Under 9'),
mediumcol =  REPLACE(mediumcol, 'U8', 'U9'),
shortcol =  REPLACE(shortcol, 'U8', 'U9'),
notes =  REPLACE(notes, '2003', '2002')
where leaguecode='MHRML' and left(notes,2) <>'KO' and longcol like  '%Under 8%';



UPDATE division 
SET 
longcol = REPLACE(longcol, 'Under 16', 'Under 17'),
shortcol =  REPLACE(shortcol, '16', '17') 
where leaguecode='OGFL'  and longcol like  '%Under 16%';

------>

<cfoutput>Division Table done<br></cfoutput>
<cfflush>
<!---
**************
* KORound    *
**************
--->
<cfquery name="DeleteKORound" datasource="#NewDatabase#">
	DELETE FROM koround WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertKORound" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`koround` 
		(LongCol, MediumCol, ShortCol, Notes, LeagueCode)
		VALUES
(NULL,NULL,NULL,'Blank for non KO Divisions','#LeagueCodePrefix#'),   
<cfif FAKORounds IS "Y">
('Extra Preliminary Round','00000001',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Preliminary Round',      '00000002',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('First Round Qualifying', '00000003',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Second Round Qualifying','00000004',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Third Round Qualifying', '00000005',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Fourth Round Qualifying','00000006',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('First Round Proper',     '00000007',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Second Round Proper',    '00000008',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Third Round Proper',     '00000009',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Fourth Round Proper',    '00000010',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Fifth Round Proper',     '00000011',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Sixth Round Proper',     '00000012',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),

('Extra Preliminary Round - Replay','00000001R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Preliminary Round - Replay',      '00000002R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('First Round Qualifying - Replay', '00000003R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Second Round Qualifying - Replay','00000004R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Third Round Qualifying - Replay', '00000005R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Fourth Round Qualifying - Replay','00000006R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('First Round Proper - Replay',     '00000007R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Second Round Proper - Replay',    '00000008R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Third Round Proper - Replay',     '00000009R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Fourth Round Proper - Replay',    '00000010R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Fifth Round Proper - Replay',     '00000011R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),
('Sixth Round Proper - Replay',     '00000012R',NULL,'FA Cup, FA Trophy & FA Vase','#LeagueCodePrefix#'),

('Round 1','0001',NULL,NULL,'#LeagueCodePrefix#'),     
('Round 1 - Replay','0001R',NULL,NULL,'#LeagueCodePrefix#'),                                   
('Round 1 - First Leg','00011',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 1 - Second Leg','00012',NULL,NULL,'#LeagueCodePrefix#'),                               
('Round 2','0002',NULL,NULL,'#LeagueCodePrefix#'),                                            
('Round 2 - Replay','0002R',NULL,NULL,'#LeagueCodePrefix#'),                                   
('Round 2 - First Leg','00021',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 2 - Second Leg','00022',NULL,NULL,'#LeagueCodePrefix#'),                               
('Round 3','0003',NULL,NULL,'#LeagueCodePrefix#'),                                           
('Round 3 - Replay','0003R',NULL,NULL,'#LeagueCodePrefix#'),                                   
('Round 3 - First Leg','00031',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 3 - Second Leg','00032',NULL,NULL,'#LeagueCodePrefix#'),                               
('Round 4','0004',NULL,NULL,'#LeagueCodePrefix#'),                                         
('Round 4 - Replay','0004R',NULL,NULL,'#LeagueCodePrefix#'),  
('Round 4 - First Leg','00041',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 4 - Second Leg','00042',NULL,NULL,'#LeagueCodePrefix#'),  
('Round 5','0005',NULL,NULL,'#LeagueCodePrefix#'),                                        
('Round 5 - Replay','0005R',NULL,NULL,'#LeagueCodePrefix#'),
('Round 5 - First Leg','00051',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 5 - Second Leg','00052',NULL,NULL,'#LeagueCodePrefix#'),  
('Round 6','0006',NULL,NULL,'#LeagueCodePrefix#'),                                            
('Round 6 - Replay','0006R',NULL,NULL,'#LeagueCodePrefix#'),   
('Round 6 - First Leg','00061',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 6 - Second Leg','00062',NULL,NULL,'#LeagueCodePrefix#'),  
('Quarter Final','0007',NULL,NULL,'#LeagueCodePrefix#'),                                     
('Quarter Final - Replay','0007R',NULL,NULL,'#LeagueCodePrefix#'),                            
('Quarter Final - First Leg','00071',NULL,NULL,'#LeagueCodePrefix#'),                         
('Quarter Final - Second Leg','00072',NULL,NULL,'#LeagueCodePrefix#'),                        
('Semi Final','0008',NULL,NULL,'#LeagueCodePrefix#'),                                        
('Semi Final - Replay','0008R',NULL,NULL,'#LeagueCodePrefix#'),                               
('Semi Final - First Leg','00081',NULL,NULL,'#LeagueCodePrefix#'),                            
('Semi Final - Second Leg','00082',NULL,NULL,'#LeagueCodePrefix#'),                           
('Final','0009',NULL,NULL,'#LeagueCodePrefix#'),                                             
('Final - Replay','0009R',NULL,NULL,'#LeagueCodePrefix#'),                                     
('Final - First Leg','00091',NULL,NULL,'#LeagueCodePrefix#'),                                  
('Final - Second Leg','00092',NULL,NULL,'#LeagueCodePrefix#');                                  
<cfelse>
('Preliminary Round','00001',NULL,NULL,'#LeagueCodePrefix#'),     
('Preliminary Round - Replay','00001R',NULL,NULL,'#LeagueCodePrefix#'),                                   
('Round 1','0001',NULL,NULL,'#LeagueCodePrefix#'),     
('Round 1 - Replay','0001R',NULL,NULL,'#LeagueCodePrefix#'),                                   
('Round 1 - First Leg','00011',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 1 - Second Leg','00012',NULL,NULL,'#LeagueCodePrefix#'),                               
('Round 2','0002',NULL,NULL,'#LeagueCodePrefix#'),                                            
('Round 2 - Replay','0002R',NULL,NULL,'#LeagueCodePrefix#'),                                   
('Round 2 - First Leg','00021',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 2 - Second Leg','00022',NULL,NULL,'#LeagueCodePrefix#'),                               
('Round 3','0003',NULL,NULL,'#LeagueCodePrefix#'),                                           
('Round 3 - Replay','0003R',NULL,NULL,'#LeagueCodePrefix#'),                                   
('Round 3 - First Leg','00031',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 3 - Second Leg','00032',NULL,NULL,'#LeagueCodePrefix#'),                               
('Round 4','0004',NULL,NULL,'#LeagueCodePrefix#'),                                         
('Round 4 - Replay','0004R',NULL,NULL,'#LeagueCodePrefix#'),  
('Round 4 - First Leg','00041',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 4 - Second Leg','00042',NULL,NULL,'#LeagueCodePrefix#'),  
('Round 5','0005',NULL,NULL,'#LeagueCodePrefix#'),                                        
('Round 5 - Replay','0005R',NULL,NULL,'#LeagueCodePrefix#'),
('Round 5 - First Leg','00051',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 5 - Second Leg','00052',NULL,NULL,'#LeagueCodePrefix#'),  
('Round 6','0006',NULL,NULL,'#LeagueCodePrefix#'),                                            
('Round 6 - Replay','0006R',NULL,NULL,'#LeagueCodePrefix#'),   
('Round 6 - First Leg','00061',NULL,NULL,'#LeagueCodePrefix#'),                                
('Round 6 - Second Leg','00062',NULL,NULL,'#LeagueCodePrefix#'),  
('Quarter Final','0007',NULL,NULL,'#LeagueCodePrefix#'),                                     
('Quarter Final - Replay','0007R',NULL,NULL,'#LeagueCodePrefix#'),                            
('Quarter Final - First Leg','00071',NULL,NULL,'#LeagueCodePrefix#'),                         
('Quarter Final - Second Leg','00072',NULL,NULL,'#LeagueCodePrefix#'),                        
('Semi Final','0008',NULL,NULL,'#LeagueCodePrefix#'),                                        
('Semi Final - Replay','0008R',NULL,NULL,'#LeagueCodePrefix#'),                               
('Semi Final - First Leg','00081',NULL,NULL,'#LeagueCodePrefix#'),                            
('Semi Final - Second Leg','00082',NULL,NULL,'#LeagueCodePrefix#'),                           
('Final','0009',NULL,NULL,'#LeagueCodePrefix#'),                                             
('Final - Replay','0009R',NULL,NULL,'#LeagueCodePrefix#'),                                     
('Final - First Leg','00091',NULL,NULL,'#LeagueCodePrefix#'),                                  
('Final - Second Leg','00092',NULL,NULL,'#LeagueCodePrefix#');                                  
		
</cfif>   
</cfquery>
<cfoutput>KORound Table done<br></cfoutput>
<cfflush>

<!---
**************
* Ordinal    *
**************
--->

<cfquery name="DeleteOrdinal" datasource="#NewDatabase#">
	DELETE FROM ordinal WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertOrdinal" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`ordinal` 
		(LongCol, MediumCol, ShortCol, Notes, LeagueCode)
		SELECT
		LongCol, MediumCol, ShortCol, Notes, LeagueCode   
		FROM `#OldDatabase#`.`ordinal` where leaguecode='#LeagueCodePrefix#';
</cfquery>

<cfoutput>Ordinal Table done<br></cfoutput>
<cfflush>

<!---
***************************
* Ordinal Cross Reference *             Ordinal IDs for old and new seasons
***************************
--->

<!--- modified 
NOTE temp table structure changed to include more fields 
--->
<cfquery name="Dropordinalxref" datasource="zmast">
	DROP TEMPORARY TABLE IF EXISTS ordinalxref;
</cfquery>
<cfquery name="Createordinalxref" datasource="zmast">
	CREATE TEMPORARY TABLE IF NOT EXISTS ordinalxref 
		(                                        
          OldID mediumint(8) unsigned NOT NULL ,        
          NewID mediumint(8) unsigned NOT NULL ,         
		  OrdinalName varchar(50) NULL ,
		  LeagueCode varchar(8) NOT NULL ,   
          UNIQUE KEY OldID (OldID) ,       
		  UNIQUE KEY NewID (NewID)                  
        ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ; 
</cfquery>
<cfquery name="Insertordinalxref" datasource="zmast">
	INSERT INTO ordinalxref
		( OldID, NewID, OrdinalName, LeagueCode )
		SELECT 
			oldordinal.ID,
			newordinal.ID,
			oldordinal.longcol,
			oldordinal.leaguecode
		FROM
		 `#OldDatabase#`.`ordinal` oldordinal, `#NewDatabase#`.`ordinal` newordinal
		WHERE
		oldordinal.leaguecode='#LeagueCodePrefix#'
		AND newordinal.leaguecode='#LeagueCodePrefix#'
		AND oldordinal.longcol = newordinal.longcol
</cfquery>

<!--- NOTE: this is for the First Team ordinals which are null and not blank --->
<cfquery name="Insertordinalxref" datasource="zmast">
	INSERT INTO ordinalxref
		( OldID, NewID, OrdinalName, LeagueCode )
		SELECT 
			oldordinal.ID,
			newordinal.ID,
			oldordinal.longcol,
			oldordinal.leaguecode			
		FROM
		 `#OldDatabase#`.`ordinal` oldordinal, `#NewDatabase#`.`ordinal` newordinal
		WHERE
		oldordinal.leaguecode='#LeagueCodePrefix#'
		AND newordinal.leaguecode='#LeagueCodePrefix#'
		AND oldordinal.longcol IS NULL
		AND newordinal.longcol IS NULL
</cfquery>


<cfoutput>Ordinal Cross Reference Temp Table done<br></cfoutput>
<cfflush>

<!---
**************
* Referee    *
**************
--->
<cfquery name="DeleteReferee" datasource="#NewDatabase#">
	DELETE FROM referee WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertReferee" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`referee` 
		(longcol, mediumcol, shortcol, notes, LeagueCode, EmailAddress1, EmailAddress2, Level, PromotionCandidate, Restrictions,
		 Surname, Forename, DateOfBirth, ParentCounty,AddressLine1, AddressLine2, AddressLine3, PostCode, HomeTel,WorkTel, MobileTel)
		SELECT
		 longcol, mediumcol, shortcol, notes, LeagueCode, EmailAddress1, EmailAddress2, Level, PromotionCandidate, Restrictions,
		 Surname, Forename, DateOfBirth, ParentCounty,AddressLine1, AddressLine2, AddressLine3, PostCode, HomeTel,WorkTel, MobileTel 
		FROM `#OldDatabase#`.`referee` where leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfoutput>Referee Table done<br></cfoutput>
<cfflush>
<!---
**************************
* Player                 *
**************************
--->
<cfquery name="DeletePlayer" datasource="#NewDatabase#">
	DELETE FROM player WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertPlayer" datasource="#NewDatabase#">
	<!--- applies to season 2012 onwards only --->
	<cfif NextYearString GT 2012>
		INSERT INTO `#NewDatabase#`.`player` 
			( mediumCol, shortCol, notes, LeagueCode, surname, forename, FAN, addressline1, addressline2, addressline3, postcode)
			SELECT
			mediumCol, shortCol, notes, LeagueCode, surname, forename, FAN, addressline1, addressline2, addressline3, postcode  
			FROM `#OldDatabase#`.`player` where leaguecode='#LeagueCodePrefix#';
	<cfelse>
		INSERT INTO `#NewDatabase#`.`player` 
			( mediumCol, shortCol, notes, LeagueCode, surname, forename, FAN )
			SELECT
			mediumCol, shortCol, notes, LeagueCode, surname, forename, FAN   
			FROM `#OldDatabase#`.`player` where leaguecode='#LeagueCodePrefix#';
	</cfif>
</cfquery>
<cfoutput>Player Table done<br></cfoutput>
<cfflush>
<!---
**************************
* NewsItem               *
**************************
--->

<cfquery name="DeleteNewsItem" datasource="#NewDatabase#">
	DELETE FROM newsitem WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertNewsItem" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`newsitem` 
		(longcol, mediumcol, shortcol, notes, LeagueCode)
		SELECT
		longcol, mediumcol, shortcol, notes, LeagueCode    
		FROM `#OldDatabase#`.`newsitem` where leaguecode='#LeagueCodePrefix#';
</cfquery>

<cfquery name="GetNotice" datasource="#NewDatabase#">
	SELECT ID FROM `#NewDatabase#`.`newsitem` 
	WHERE leaguecode='#LeagueCodePrefix#' AND LongCol='NOTICE'
</cfquery>
<cfif GetNotice.RecordCount IS 1>
	<cfquery name="UpdateNotice" datasource="#NewDatabase#">
		UPDATE `#NewDatabase#`.`newsitem` 
		SET LongCol="#OldYearString# NOTICE"  WHERE ID=#GetNotice.ID#
	</cfquery>
</cfif>
<cfquery name="InsertNewsItem" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`newsitem` 
		(longcol, mediumcol, shortcol, notes, LeagueCode)
		values
		('NOTICE', '', '', '#NewYearString#-#NextYearString# Season is now under construction .....', '#LeagueCodePrefix#')    
</cfquery>

<cfoutput>NewsItem Table done<br></cfoutput>
<cfflush>

<!---
********
* Team *
********
--->

<cfquery name="DeleteTeam" datasource="#NewDatabase#">
	DELETE FROM team  WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertTeam" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`team` 
		( longcol, mediumcol, shortcol, notes, LeagueCode, FACharterStandardType, ParentCountyFA, AffiliationNo)
		SELECT 
	longcol, mediumcol, shortcol, notes, LeagueCode, FACharterStandardType, ParentCountyFA, AffiliationNo
		FROM
		 `#OldDatabase#`.`team`
		WHERE
		leaguecode='#LeagueCodePrefix#';
</cfquery>

<!---
***********************
* Remove GUEST Teams  *
***********************
<cfquery name="DeleteGuest" datasource="#NewDatabase#">
	DELETE FROM team  WHERE leaguecode='#LeagueCodePrefix#' AND UPPER(ShortCol) = 'GUEST';
</cfquery>
--->

<!---
***********************************************
* Remove WITHDRAWN, RESIGNED, EXPELLED Teams  *
***********************************************
--->

<cfquery name="DeleteWITHDRAWN" datasource="#NewDatabase#">
	DELETE FROM team  WHERE leaguecode='#LeagueCodePrefix#' AND 
	( UPPER(LongCol) LIKE '%WITHDRAWN%' OR UPPER(LongCol) LIKE '%EXPELLED%' OR UPPER(LongCol) LIKE '%RESIGNED%' OR UPPER(LongCol) LIKE '%SUSPENDED%');
</cfquery>



<cfoutput>Team Table done<br></cfoutput>
<cfflush>

<!---
************************
* Team Cross Reference *             Team IDs for old and new seasons
************************
--->
<!--- modified --->
<cfquery name="Dropteamxref" datasource="zmast">
	DROP TEMPORARY TABLE IF EXISTS teamxref;
</cfquery>
<cfquery name="Createteamxref" datasource="zmast">
CREATE TEMPORARY TABLE IF NOT EXISTS teamxref
		 (                                        
          OldID mediumint(8) unsigned NOT NULL ,        
          NewID mediumint(8) unsigned NOT NULL ,         
		  TeamName varchar(50) NOT NULL ,
		  LeagueCode varchar(8) NOT NULL ,   
          UNIQUE KEY OldID (OldID)  ,       
		  UNIQUE KEY NewID (NewID)                  
        ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ; 
</cfquery>
<cfoutput>teamxref TEMPORARY TABLE created<br></cfoutput>
<cfflush>
<!--- modified for more fields --->
<cfquery name="InsertTeamXREF" datasource="zmast">
	INSERT INTO teamxref
		( OldID, NewID, TeamName, LeagueCode )
		SELECT 
			oldteam.ID,
			newteam.ID,
			oldteam.longcol,
			oldteam.leaguecode
		FROM
		 `#OldDatabase#`.`team` oldteam, `#NewDatabase#`.`team` newteam
		WHERE
		oldteam.leaguecode='#LeagueCodePrefix#'
		AND newteam.leaguecode='#LeagueCodePrefix#'
		AND oldteam.longcol = newteam.longcol;
</cfquery>
<cfoutput>teamxref INSERT done ...<br></cfoutput>
<cfflush>


<!---
*************************
*         Teamdetails  *
*************************
--->



<cfquery name="ChkTeamDetails" datasource="#NewDatabase#">
	SELECT * FROM teamdetails  WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>


<cfoutput>ChkTeamDetails.RecordCount is #ChkTeamDetails.RecordCount#<br></cfoutput>
<cfflush>

<cfif ChkTeamDetails.RecordCount GT 0>
	<cfquery name="DeleteTeamDetails" datasource="#NewDatabase#">
		DELETE FROM teamdetails  WHERE leaguecode='#LeagueCodePrefix#';
	</cfquery>
	<cfoutput>Teamdetails deleted ........<br></cfoutput>
	<cfflush>
</cfif>
<cfquery name="InsertTeamDetails" datasource="zmast">
	INSERT INTO `#NewDatabase#`.`teamdetails` 
	( 
	LeagueCode, 
	TeamID, 
	OrdinalID, 
	VenueID,
	PitchNoID,
	ShirtColour1, 
	ShortsColour1, 
	SocksColour1, 
	ShirtColour2, 
	ShortsColour2, 
	SocksColour2, 
	URLTeamWebsite, 
	URLTeamPhoto, 
	Contact1Name, 
	Contact1JobDescr, 
	Contact1Address, 
	Contact1TelNo1, 
	Contact1TelNo1Descr, 
	Contact1TelNo2, 
	Contact1TelNo2Descr, 
	Contact1TelNo3, 
	Contact1TelNo3Descr, 
	Contact1Email1, 
	Contact1Email2, 
	Contact2Name, 
	Contact2JobDescr, 
	Contact2Address, 
	Contact2TelNo1, 
	Contact2TelNo1Descr, 
	Contact2TelNo2, 
	Contact2TelNo2Descr, 
	Contact2TelNo3, 
	Contact2TelNo3Descr, 
	Contact2Email1, 
	Contact2Email2, 
	Contact3Name, 
	Contact3JobDescr, 
	Contact3Address, 
	Contact3TelNo1, 
	Contact3TelNo1Descr, 
	Contact3TelNo2, 
	Contact3TelNo2Descr, 
	Contact3TelNo3, 
	Contact3TelNo3Descr, 
	Contact3Email1, 
	Contact3Email2, 
	ShowHideContact1Address, 
	ShowHideContact1TelNo1, 
	ShowHideContact1TelNo2, 
	ShowHideContact1TelNo3, 
	ShowHideContact1Email1, 
	ShowHideContact1Email2, 
	ShowHideContact2Address, 
	ShowHideContact2TelNo1, 
	ShowHideContact2TelNo2, 
	ShowHideContact2TelNo3, 
	ShowHideContact2Email1, 
	ShowHideContact2Email2, 
	ShowHideContact3Address, 
	ShowHideContact3TelNo1, 
	ShowHideContact3TelNo2, 
	ShowHideContact3TelNo3, 
	ShowHideContact3Email1, 
	ShowHideContact3Email2
	)
	SELECT
	LeagueCode, 
	(SELECT newID FROM teamxref WHERE oldID=teamID),
	(SELECT newID FROM ordinalxref WHERE oldID=ordinalID),
	0,
	0,
	ShirtColour1, 
	ShortsColour1, 
	SocksColour1, 
	ShirtColour2, 
	ShortsColour2, 
	SocksColour2, 
	URLTeamWebsite, 
	URLTeamPhoto, 
	Contact1Name, 
	Contact1JobDescr, 
	Contact1Address, 
	Contact1TelNo1, 
	Contact1TelNo1Descr, 
	Contact1TelNo2, 
	Contact1TelNo2Descr, 
	Contact1TelNo3, 
	Contact1TelNo3Descr, 
	Contact1Email1, 
	Contact1Email2, 
	Contact2Name, 
	Contact2JobDescr, 
	Contact2Address, 
	Contact2TelNo1, 
	Contact2TelNo1Descr, 
	Contact2TelNo2, 
	Contact2TelNo2Descr, 
	Contact2TelNo3, 
	Contact2TelNo3Descr, 
	Contact2Email1, 
	Contact2Email2, 
	Contact3Name, 
	Contact3JobDescr, 
	Contact3Address, 
	Contact3TelNo1, 
	Contact3TelNo1Descr, 
	Contact3TelNo2, 
	Contact3TelNo2Descr, 
	Contact3TelNo3, 
	Contact3TelNo3Descr, 
	Contact3Email1, 
	Contact3Email2, 
	ShowHideContact1Address, 
	ShowHideContact1TelNo1, 
	ShowHideContact1TelNo2, 
	ShowHideContact1TelNo3, 
	ShowHideContact1Email1, 
	ShowHideContact1Email2, 
	ShowHideContact2Address, 
	ShowHideContact2TelNo1, 
	ShowHideContact2TelNo2, 
	ShowHideContact2TelNo3, 
	ShowHideContact2Email1, 
	ShowHideContact2Email2, 
	ShowHideContact3Address, 
	ShowHideContact3TelNo1, 
	ShowHideContact3TelNo2, 
	ShowHideContact3TelNo3, 
	ShowHideContact3Email1, 
	ShowHideContact3Email2
		FROM
		 `#OldDatabase#`.`teamdetails`
		WHERE
		leaguecode='#LeagueCodePrefix#'
</cfquery>


<cfoutput>Teamdetails Table done<br></cfoutput>
<cfflush>

<cfquery name="QTeamDetails" datasource="#NewDatabase#">
	SELECT
		td_new.id as NewTeamDetailsID,
		td_new.teamid as NewTeamID,
		td_new.ordinalid as NewOrdinalID,
		td_new.venueid as NewVenueID,
		td_new.pitchnoid
	FROM 
		`#NewDatabase#`.`teamdetails` td_new
	WHERE
		td_new.leaguecode='#LeagueCodePrefix#'
		AND NOT (td_new.teamid IS NULL)
		AND NOT (td_new.ordinalid IS NULL)		
	ORDER BY
		td_new.teamid, td_new.ordinalid;
</cfquery>

<cfoutput query="QTeamDetails">
	<cfset OString=''>
	<cfquery name="Q999" datasource="#NewDatabase#">select longcol from `#NewDatabase#`.`ordinal` where id=#NewOrdinalID#</cfquery>
	<cfif Q999.longcol IS ''>
		<cfquery name="Q21" datasource="#OldDatabase#">
			select id from `#OldDatabase#`.`ordinal` where leaguecode='#LeagueCodePrefix#' and longcol is null;
		</cfquery>
		<cfset OldOrdinalID=#Q21.id# >
	<cfelse>
		<cfquery name="Q22" datasource="#OldDatabase#">
			select id, longcol from `#OldDatabase#`.`ordinal` where leaguecode='#LeagueCodePrefix#' and longcol = '#Q999.longcol#';
		</cfquery>
		<cfset OldOrdinalID=#Q22.id# >
		<cfset OString='#Q22.longcol#'>
	</cfif>
	<cfif IsNumeric(NewTeamID)>
		<cfquery name="Q1" datasource="#OldDatabase#">
			select id, longcol from `#OldDatabase#`.`team` where leaguecode='#LeagueCodePrefix#' and longcol = (select longcol from `#NewDatabase#`.`team` where id=#NewTeamID#);
		</cfquery>
		
		<!---
		NewTeamDetailsID=#NewTeamDetailsID# 
		NewTeamID=#NewTeamID#
		NewOrdinalID=#NewOrdinalID#
		OldOrdinalID=#OldOrdinalID#
		--->
		
		<cfset OldTeamID=#Q1.id# >
		
		<!---
		OldTeamID=#OldTeamID#
		--->
		
		<cfif IsNumeric(OldTeamID) >
			<!---		
			<strong>#Q1.longcol# #OString#</strong>
			--->
			
			<cfquery name="Q3" datasource="#OldDatabase#">
				select venueid, pitchnoid from `#OldDatabase#`.`teamdetails` where leaguecode='#LeagueCodePrefix#' and OrdinalID=#OldOrdinalID# and TeamID=#OldTeamID#
			</cfquery>
			<cfset OldVenueID= #Q3.venueid# >
			<cfset OldPitchNoID= #Q3.pitchnoid# >
			
			<!---
			OldVenueID=#OldVenueID#
			OldPitchNoID=#OldPitchNoID#
			--->
			
			<cfif IsNumeric(OldVenueID) AND IsNumeric(OldPitchNoID) >
				<cfquery name="Q4" datasource="#OldDatabase#">	
					select longcol from `#OldDatabase#`.`venue` where leaguecode='#LeagueCodePrefix#' and ID=#OldVenueID#
				</cfquery>
				<cfset VenueName='#Q4.longcol#'>
				<!---
				VenueName=#VenueName#
				--->
				
				<cfquery name="Q5" datasource="#NewDatabase#">	
					select id as NewVID from `#NewDatabase#`.`venue` where leaguecode='#LeagueCodePrefix#' and longcol='#VenueName#'
				</cfquery>
				<cfset NewVID=#Q5.NewVID# >
				
				<!---
				NewVID=#NewVID#
				--->
				<cfif IsNumeric(NewVID)>
					<cfquery name="Q6" datasource="#NewDatabase#">
						UPDATE `#NewDatabase#`.`teamdetails` 
						SET VenueID=#NewVID#, PitchNoID=#OldPitchNoID#
						WHERE leaguecode='#LeagueCodePrefix#' and ID=#NewTeamDetailsID#
					</cfquery>
				</cfif>
			</cfif>
		</cfif>
	<cfelse>
	</cfif>
</cfoutput>

<cfoutput>Venue and PitchNo details done<br></cfoutput>
<cfflush>
<!---
**************************
* Register               *
**************************
--->

<cfquery name="DeleteRegister" datasource="#NewDatabase#">
	DELETE FROM register WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertRegister" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`register` 
		(TeamID,  PlayerID,    FirstDay,  LastDay,   RegType, LeagueCode)
		SELECT t_new.ID,   p_new.ID,  r.FirstDay, CASE WHEN r.LastDay IS NULL THEN '#OldSeasonEndDate#' ELSE r.LastDay END, r.RegType, '#LeagueCodePrefix#'
		FROM `#OldDatabase#`.`register` r, `#OldDatabase#`.`team` t_old , `#NewDatabase#`.`team` t_new , `#OldDatabase#`.`player` p_old , `#NewDatabase#`.`player` p_new 
		WHERE
		r.leaguecode='#LeagueCodePrefix#'
		AND t_old.leaguecode='#LeagueCodePrefix#'
		AND t_new.leaguecode='#LeagueCodePrefix#'
		AND p_old.leaguecode='#LeagueCodePrefix#'
		AND p_new.leaguecode='#LeagueCodePrefix#'
		AND r.TeamID = t_old.ID
		AND r.PlayerID = p_old.ID
		AND t_old.LongCol = t_new.LongCol
		AND p_old.shortcol = p_new.shortcol;
	
</cfquery>
<cfquery name="DeleteExpired" datasource="#NewDatabase#"> <!--- remove all expired registrations --->
	DELETE FROM register WHERE leaguecode='#LeagueCodePrefix#' AND LastDay <> '#OldSeasonEndDate#';
</cfquery>

<cfoutput>Register Table done<br></cfoutput>
<cfflush>

<!---
**************************
* Suspension             *
**************************
--->

<cfquery name="DeleteSuspension" datasource="#NewDatabase#">
	DELETE FROM suspension WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>

<cfquery name="InsertSuspension" datasource="#NewDatabase#">
	INSERT INTO `#NewDatabase#`.`suspension` 
		(PlayerID, FirstDay, LastDay, LeagueCode, NumberOfMatches, SuspensionNotes )
		SELECT
		p_new.ID, s.FirstDay, '#NewSeasonEndDate#', s.LeagueCode, s.NumberOfMatches, s.SuspensionNotes
		FROM `#OldDatabase#`.`suspension` s, `#OldDatabase#`.`player` p_old , `#NewDatabase#`.`player` p_new 
		WHERE
		s.leaguecode='#LeagueCodePrefix#'
		AND p_old.leaguecode='#LeagueCodePrefix#'
		AND p_new.leaguecode='#LeagueCodePrefix#'
		AND s.LastDay >= '#OldSeasonEndDate#' <!--- only copy across suspensions that were active on the last day of the old season and includes match bans with 2999-12-31 --->
		AND s.PlayerID = p_old.ID 
		AND p_new.shortcol = p_old.shortcol;
</cfquery>
<cfquery name="UpdtSuspension" datasource="#NewDatabase#">
	UPDATE `#NewDatabase#`.`suspension` 
		SET SuspensionNotes = CONCAT('WARNING: Please Update. Match Bans (', NumberOfMatches, ') - Some or all have been carried over from last season. '), NumberOfMatches = 0
		WHERE leaguecode='#LeagueCodePrefix#'
		AND NumberOfMatches > 0
</cfquery>
<cfoutput>Suspension Table done<br></cfoutput>
<cfflush>

<!---
*********************
* Constitution      *
*********************
--->
 
<cfquery name="DeleteConstitution" datasource="#NewDatabase#">
	DELETE FROM constitution WHERE leaguecode='#LeagueCodePrefix#';
</cfquery>
<cfquery name="InsertConstitution" datasource="zmast">
	INSERT INTO `#NewDatabase#`.`constitution` 
	( 
	DivisionID, 
	TeamID, 
	OrdinalID, 
	ThisMatchNoID, 
	NextMatchNoID, 
	LeagueCode, 
	PointsAdjustment
	)
	SELECT 	
		(SELECT d2.ID FROM `#OldDatabase#`.`division` d1, `#NewDatabase#`.`division` d2 
		WHERE d1.leaguecode='#LeagueCodePrefix#' AND d1.ID=c.divisionid AND d1.leaguecode = d2.leaguecode AND d1.longcol=d2.longcol),
		(SELECT newID FROM teamxref WHERE oldID=c.teamID), 
		(SELECT newID FROM ordinalxref WHERE oldID=c.ordinalID), 
		27,
		27,
		'#LeagueCodePrefix#',
		0
	FROM 
		`#OldDatabase#`.`constitution` c,
        `#OldDatabase#`.`division` d
	WHERE
		c.leaguecode='#LeagueCodePrefix#'
		AND c.divisionid=d.id
		AND d.id not in (SELECT id from `#OldDatabase#`.`division` WHERE leaguecode='#LeagueCodePrefix#' AND left(notes,2)='KO')
		AND d.id not in (SELECT id from `#OldDatabase#`.`division` WHERE leaguecode='#LeagueCodePrefix#' AND longcol='Miscellaneous')	
</cfquery>

<cfoutput>Constitution Table done<br></cfoutput>
<cfflush>

<!---
*********************
* DefaultDivision   *
*********************
--->

<cfquery name="GetNewDefaultDivisionID" datasource="#NewDatabase#">
	SELECT id FROM `#NewDatabase#`.`division` WHERE
		leaguecode='#LeagueCodePrefix#'
		AND longcol = (SELECT longcol FROM `#OldDatabase#`.`division` 
		WHERE id=(SELECT DefaultDivisionID from `zmast`.`leagueinfo` WHERE defaultleaguecode='#OldDefaultLeagueCode#'))
</cfquery>
<cfif GetNewDefaultDivisionID.RecordCount IS 0>
	<cfset NewDefaultDivisionID = 0 >
<cfelse>
	<cfset NewDefaultDivisionID = GetNewDefaultDivisionID.id >
</cfif>
<cfquery name="GetLeagueInfoID" datasource="zmast">
	SELECT id from `zmast`.`leagueinfo` WHERE defaultleaguecode='#DefaultLeagueCode#'
</cfquery>
<cfquery name="UpdateDefaultDivisionID" datasource="zmast">
	UPDATE
		leagueinfo
	SET
		DefaultDivisionID = '#NewDefaultDivisionID#'
	WHERE
		ID='#GetLeagueInfoID.id#'
</cfquery>

<cfquery name="DelNullTeamIDsT" datasource="#NewDatabase#"> <!--- delete rows with null teamids in constitution --->
	DELETE FROM constitution WHERE TeamID IS NULL
</cfquery>

<cfquery name="DelNullTeamIDsTD" datasource="#NewDatabase#"> <!--- delete rows with null teamids in teamdetails --->
	DELETE FROM teamdetails WHERE TeamID IS NULL
</cfquery>

<cfquery name="ForeignKeyCheckOn" datasource="#NewDatabase#">
	SET FOREIGN_KEY_CHECKS=1;
</cfquery>
<cfoutput>
<a href="SecurityCheck.cfm?DivisionID=0&LeagueCode=#defaultleaguecode#" target="_blank">GO TO NEW SEASON</a>
</cfoutput>



<!---
*********************
* New Team Details  *
*********************
--->

<cfquery name="QTeamDetails" datasource="#NewDatabase#">
	SELECT
		td_new.id as NewTeamDetailsID,
		td_new.teamid as NewTeamID,
		td_new.ordinalid as NewOrdinalID,
		td_new.venueid as NewVenueID,
		td_new.pitchnoid
	FROM 
		`#NewDatabase#`.`teamdetails` td_new
	WHERE
		td_new.leaguecode='#LeagueCodePrefix#'
		AND td_new.ordinalid IS NOT NULL
	ORDER BY
		td_new.teamid, td_new.ordinalid;
</cfquery>

<cfoutput query="QTeamDetails">
	<cfset OString=''>
	<cfquery name="Q999" datasource="#NewDatabase#">select longcol from `#NewDatabase#`.`ordinal` where id=#NewOrdinalID#</cfquery>
	<cfif Q999.longcol IS ''>
		<cfquery name="Q21" datasource="#OldDatabase#">
			select id from `#OldDatabase#`.`ordinal` where leaguecode='#LeagueCodePrefix#' and longcol is null;
		</cfquery>
		<cfset OldOrdinalID=#Q21.id# >
	<cfelse>
		<cfquery name="Q22" datasource="#OldDatabase#">
			select id, longcol from `#OldDatabase#`.`ordinal` where leaguecode='#LeagueCodePrefix#' and longcol = '#Q999.longcol#';
		</cfquery>
		<cfset OldOrdinalID=#Q22.id# >
		<cfset OString='#Q22.longcol#'>
	</cfif>
	<cfif IsNumeric(NewTeamID)>
		<cfquery name="Q1" datasource="#OldDatabase#">
			select id, longcol from `#OldDatabase#`.`team` where leaguecode='#LeagueCodePrefix#' and longcol = (select longcol from `#NewDatabase#`.`team` where id=#NewTeamID#);
		</cfquery>
		NewTeamDetailsID=#NewTeamDetailsID# 
		NewTeamID=#NewTeamID#
		NewOrdinalID=#NewOrdinalID#
		OldOrdinalID=#OldOrdinalID#
		<cfset OldTeamID=#Q1.id# >
		OldTeamID=#OldTeamID#
		<cfif IsNumeric(OldTeamID) >		
			<strong>#Q1.longcol# #OString#</strong>
			<cfquery name="Q3" datasource="#OldDatabase#">
				select venueid, pitchnoid from `#OldDatabase#`.`teamdetails` where leaguecode='#LeagueCodePrefix#' and OrdinalID=#OldOrdinalID# and TeamID=#OldTeamID#
			</cfquery>
			<cfset OldVenueID= #Q3.venueid# >
			<cfset OldPitchNoID= #Q3.pitchnoid# >
			OldVenueID=#OldVenueID#
			OldPitchNoID=#OldPitchNoID#
			<cfif IsNumeric(OldVenueID) AND IsNumeric(OldPitchNoID) >
				<cfquery name="Q4" datasource="#OldDatabase#">	
					select longcol from `#OldDatabase#`.`venue` where leaguecode='#LeagueCodePrefix#' and ID=#OldVenueID#
				</cfquery>
				<cfset VenueName='#Q4.longcol#'>
				<br>VenueName=#VenueName#
				<cfquery name="Q5" datasource="#NewDatabase#">	
					select id as NewVID from `#NewDatabase#`.`venue` where leaguecode='#LeagueCodePrefix#' and longcol='#VenueName#'
				</cfquery>
				<cfset NewVID=#Q5.NewVID# >
				NewVID=#NewVID#
				<cfif IsNumeric(NewVID)>
					<cfquery name="Q6" datasource="#NewDatabase#">
						UPDATE `#NewDatabase#`.`teamdetails` 
						SET VenueID=#NewVID#, PitchNoID=#OldPitchNoID#
						WHERE leaguecode='#LeagueCodePrefix#' and ID=#NewTeamDetailsID#
					</cfquery>
				</cfif>
			</cfif>
		</cfif>
	<cfelse>
	</cfif>
	<hr>
</cfoutput>












<!--- change team names to a year older e.g. Arsenal U15 will become Arsenal U16 
<cfloop index="i" from="19" to="7" step="-1">
	<cfset AString = #i# - 1>
	<cfset BString = #i#  >
	<cfquery name="QTeamAgeBand" datasource="#NewDatabase#">
		SET @OldAge='U#AString#'
	</cfquery>
	<cfquery name="QTeamAgeBand" datasource="#NewDatabase#">
		SET @NewAge='U#BString#'
	</cfquery>
	<cfquery name="QTeamAgeBand" datasource="#NewDatabase#">
		SET @OldAgePerc=concat('%',@OldAge,'%')
	</cfquery>
	<cfquery name="QTeamAgeBand" datasource="#NewDatabase#">
		SET @NewAgePerc=concat('%',@NewAge,'%')
	</cfquery>
	<cfquery name="QTeamAgeBand" datasource="#NewDatabase#">
		UPDATE `#NewDatabase#`.`team`  SET longcol = REPLACE(longcol, @OldAge, @NewAge) where leaguecode='#LeagueCodePrefix#' and longcol like @OldAgePerc
	</cfquery>
</cfloop>
--->
