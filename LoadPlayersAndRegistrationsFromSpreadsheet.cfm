<!---  FixturesAndResults spreadsheet must be in this format 
A column1 as TeamName,               
B column2 as RegNo,
C column3 as DOB,  (DATE)
D column4 as surname,
E column5 as forenames,
F column6 as RegType, e.g. 'Non-Contract'
G column7 as FirstDay,  (DATE)
H column8 as Notes,
I column9 as FAN,
J column10 as AddressLine1,
K column11 as AddressLine2,
L column12 as AddressLine3,
M column13 as Postcode,
N column14 as Email1
The spreadsheet should be put in the same directory as the .cfm code 
	

--->
<cfsetting requestTimeOut = "120"  showdebugoutput="yes">

<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>
<cfset ThisLeagueCode = url.LeagueCode >                                           <!--- e.g. "SDWFL2009" ---> 
<cfset ThisLeagueCodePrefix = Left(ThisLeagueCode, (Len(TRIM(ThisLeagueCode))-4))> <!--- e.g. "SDWFL" --->
<cfset ThisDB = "fm#Right(url.LeagueCode,4)#">                                     <!--- e.g. "fm2009" --->
<cfset Thiscellpadding = "2" >
<cfset Thiscellspacing = "2" >
<!--- e.g. LoadPlayersAndRegistrationsFromSpreadsheet.cfm?LeagueCode=SDWFL2009&delete=no --->
<cfoutput>
	<!--- OPTIONAL - clear out any previous registrations --->
	<cfif NOT StructKeyExists(url, "delete") >
		"delete" parameter must be specified<br><br><br>
		LoadPlayersAndRegistrationsFromSpreadsheet.cfm?LeagueCode=#LeagueCode#&delete=no<br><br>
		<cfabort>
	</cfif> 
</cfoutput>
<cfif url.delete IS "Yes">
	<cfquery name="DelRegistrations" datasource="#ThisDB#">
		DELETE FROM 
			register
		WHERE 
			LeagueCode = '#ThisLeagueCodePrefix#'
	</cfquery>
</cfif>
<cfif url.delete IS "Yes">
	<cfquery name="DelPlayers" datasource="#ThisDB#">
		DELETE FROM 
			player
		WHERE 
			LeagueCode = '#ThisLeagueCodePrefix#'
			AND NOT (Surname = 'OwnGoal')
			AND id NOT IN (SELECT PlayerID FROM suspension WHERE LeagueCode = '#ThisLeagueCodePrefix#' )
	</cfquery>
</cfif>
<cfset objPOI = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />


<cfset spreadsheetname = "#ThisLeagueCode#PlayersAndRegistrations">
<cfset Spreadsheet = "#spreadsheetname#.xls">
<cfset zzz = ExpandPath( "./#Spreadsheet#" )>
<cfoutput>#zzz#<br></cfoutput>
<cfset objSheet = objPOI.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />


<cfset ListOfTeamIDs = "">
<cfset TeamNamesAllOK = "Yes">

<cfoutput query="objsheet.Query">
	<cfquery Name="QTeamName" datasource="#ThisDB#">
		SELECT
			ID 
		FROM
			team 
		WHERE
			LeagueCode = '#ThisLeagueCodePrefix#'
			AND LongCol = '#column1#'
	</cfquery>
	<cfif QTeamName.RecordCount IS 1> <!--- exact match with TeamName --->
		<cfset TeamID = QTeamName.ID >
		<cfset ListOfTeamIDs = ListAppend(ListOfTeamIDs,#TeamID#)>
	<cfelse>
		Error in row #CurrentRow#: <strong>#column1#</strong><br> <!--- change as needed to point to TeamName--->
		<cfflush>
		<cfset TeamNamesAllOK = "No">
	</cfif>
</cfoutput>

<cfif TeamNamesAllOK IS "No">
	<br><br> Team Names NOT OK so aborting... 
	<cfabort>
<cfelse>
	 Team Names OK ...... 
	<cfflush>
</cfif>


<cfquery name="QExisting" datasource="#ThisDB#" >
<!--- get any existing registration numbers   --->
	SELECT ShortCol as RegNo FROM Player WHERE LeagueCode = '#ThisLeagueCodePrefix#'
</cfquery>
<cfset RegNoList = ValueList(QExisting.RegNo)>

<cfquery Name="QXLS" dbtype="query">
SELECT
		column1 as TeamName,			<!--- column A --->
		column2 as RegNo,				<!--- column B --->
		column3 as DOB,					<!--- column C --->
		column4 as surname,				<!--- column D --->
		column5 as forenames,			<!--- column E --->
		column6 as RegType,				<!--- column F --->
		column7 as FirstDay,			<!--- column G --->
		column8 as Notes,				<!--- column H --->
		column9 as FAN,					<!--- column I --->
		column10 as AddressLine1,		<!--- column J --->
		column11 as AddressLine2,		<!--- column K --->
		column12 as AddressLine3,		<!--- column L --->
		column13 as Postcode,			<!--- column M --->
		column14 as Email1				<!--- column N --->
	FROM
		objsheet.query
</cfquery>
<br>
QXLS query done ...... 
<cfflush>
	<!--- check for duplicate registration numbers and list them before proceeding  --->
<cfquery Name="QDuplicatesOld" dbtype="query">
	SELECT 
		RegNo
	FROM
		QXLS
	WHERE
		RegNo IN (#RegNoList#)
</cfquery>
<cfif QDuplicatesOld.RecordCount GT 0>
	<br>
	Duplicate registration numbers ...... aborting<br>
	<cfoutput query="QDuplicatesOld">
		#RegNo#<br>
	</cfoutput>
	<cfabort>
</cfif>

<!--- check for duplicate registration numbers and list them before proceeding  --->
<cfquery Name="QDuplicates" dbtype="query">
	SELECT 
		RegNo, 
		Count(RegNo) as PossDupe 
	FROM
		QXLS
	GROUP BY 
		RegNo 
	HAVING 
		PossDupe > 1
</cfquery>
<br>
checking for duplicate registration numbers ...... 
<cfflush>
<cfif QDuplicates.RecordCount GT 0>
	DUPLICATE RegNos found <br>
	<cfoutput query="QDuplicates">
	#PossDupe# times #RegNo#<br>
	</cfoutput>
	<cfabort>
</cfif>
<cfflush>
	
<cfoutput query="QXLS">

	<!--- making sure this player is not already registered to another team  --->
	<cfquery name="QDuplicateRegNo" datasource="#ThisDB#">
		SELECT
			*
		FROM
			player
		WHERE
			LeagueCode = '#ThisLeagueCodePrefix#'
			AND shortcol = #RegNo# 
	</cfquery>
	
	<cfif QDuplicateRegNo.RecordCount IS 1>		
		DUPLICATE Registration Number #RegNo# for #surname# #forenames#<br>
		<cfabort>
	<cfelse>
		<cfquery name="InsrtPlayer" datasource="#ThisDB#" >
			INSERT INTO player 
				(Surname, Forename, MediumCol, ShortCol, Notes, LeagueCode, FAN, AddressLine1, AddressLine2, AddressLine3, Postcode, Email1 ) 
			VALUES 
				( 
				'#TRIM(surname)#' ,
				'#TRIM(forenames)#' ,				
				<cfif IsDate(DateFormat(DOB, "YYYY-MM-DD"))>'#DateFormat(DOB, "YYYY-MM-DD")#'<cfelse>NULL</cfif> ,
				#RegNo# ,
				'#TRIM(Notes)#' ,
				'#ThisLeagueCodePrefix#' ,
				<cfif IsNumeric(#FAN#) >#FAN#<cfelse>NULL</cfif> ,
				'#TRIM(AddressLine1)#' ,
				'#TRIM(AddressLine2)#' ,
				'#TRIM(AddressLine3)#' ,
				'#TRIM(Postcode)#' ,
				'#TRIM(Email1)#' 
				)
		</cfquery>
		
		<!--- Get the ID of this new row in the Player table --->
		<cfquery name="QPlayerID" datasource="#ThisDB#">
			SELECT
				ID
			FROM
				player
			WHERE
				LeagueCode = '#ThisLeagueCodePrefix#'
				AND ShortCol = #RegNo#
		</cfquery>	
		<cfif QPlayerID.RecordCount IS NOT 1>
			aborted......
			<cfabort >
		</cfif>
					
		<cfif RegType IS "Non-Contract">
			<cfset RType = "A">
		<cfelseif RegType IS "Contract">
			<cfset RType = "B">
		<cfelseif RegType IS "Short Loan">
			<cfset RType = "C">
		<cfelseif RegType IS "Long Loan">
			<cfset RType = "D">
		<cfelseif RegType IS "Work Experience">
			<cfset RType = "E">
		<cfelseif RegType IS "Lapsed">
			<cfset RType = "G">
		<cfelseif RegType IS "Temporary">
			<cfset RType = "F">
		<cfelse>
			<cfset RType = "X">
		</cfif>
					
	<!--- Get the TeamID  --->
		<cfquery name="QTeamID" datasource="#ThisDB#">
			SELECT
				ID
			FROM
				team
			WHERE
				LeagueCode = '#ThisLeagueCodePrefix#'
				AND LongCol = '#TeamName#'
		</cfquery>
		<cfif QTeamID.RecordCount IS 1>
			<cfquery name="QAddRegistration" datasource="#ThisDB#" >
				INSERT INTO
					register
					(TeamID, PlayerID, FirstDay, RegType, LeagueCode) 
				VALUES
					( #QTeamID.ID#, #QPlayerID.ID#, '#DateFormat(FirstDay,"YYYY-MM-DD")#', '#RType#', '#ThisLeagueCodePrefix#' )
			</cfquery>
		</cfif>
	</cfif>
</cfoutput>
