<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<LINK REL="stylesheet" type="text/css" href="fmstyle.css">

<cfset ThisLeagueCode = url.LeagueCode >                                           <!--- e.g. "SDWFL2009" ---> 
<cfset ThisLeagueCodePrefix = Left(ThisLeagueCode, (Len(TRIM(ThisLeagueCode))-4))> <!--- e.g. "SDWFL" --->
<cfset ThisDB = "fm#Right(url.LeagueCode,4)#">                                     <!--- e.g. "fm2009" --->
<cfset Thiscellpadding = "2" >
<cfset Thiscellspacing = "2" >
 
<cfset objPOI = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />
  
  
<cfset spreadsheetname = "#ThisLeagueCode#Referee">
<cfset Spreadsheet = "#spreadsheetname#.xls">
<cfset zzz = ExpandPath( "./#Spreadsheet#" )>
<cfoutput>#zzz#<br></cfoutput>


<cfset objSheet = objPOI.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />
  
<!--- this gives objsheet.Query as a result set --->

 
<cfoutput>
	<!--- OPTIONAL - clear out any referees --->
	<cfif NOT StructKeyExists(url, "ClearAllReferees") >
		ClearAllReferees parameter must be specified<br><br><br>
		LoadRefereesFromSpreadsheet.cfm?LeagueCode=#LeagueCode#&ClearAllReferees=No<br><br>
		<cfabort>
	</cfif> 
</cfoutput>
<cfif url.ClearAllReferees IS "Yes" >
	<cfquery name="DelFixtures" datasource="#ThisDB#">
		DELETE FROM 
			referee
		WHERE 
			leaguecode='#ThisLeagueCodePrefix#'
		AND NOT (LongCol IS NULL);
	</cfquery>
</cfif>

	<cfquery Name="QReferees" dbtype="query" >
		SELECT
			Column1 as Forename,
			Column2 as Surname,
			Column3 as AddressLine1,
			Column4 as AddressLine2,
			Column5 as AddressLine3,
			Column6 as PostCode,
			Column7 as HomeTel,
			Column8 as WorkTel,
			Column9 as MobileTel,
			Column10 as EmailAddress1,
			Column11 as EmailAddress2,
			Column12 as RefLevel,
			Column13 as Notes,
			Column14 as FAN,
			Column15 as DOB
		FROM
			objsheet.query
	</cfquery>
	
	<cfoutput query="QReferees">
			<span class="pix10">
			#Forename#,
			#Surname#,
			#AddressLine1#,
			#AddressLine2#,
			#AddressLine3#,
			#PostCode#,
			#HomeTel#,
			#WorkTel#,
			#MobileTel#,
			#EmailAddress1#,
			#EmailAddress2#,
			#RefLevel#,
			#Notes#,
			#FAN#,
			#DateFormat(DOB, 'YYYY-MM-DD')#<br></span>
	</cfoutput>
	
	
	
	<cfoutput query="QReferees">
		<cfquery name="InsrtReferee" datasource="#request.DSN#" >
			INSERT INTO referee 
							(longcol, 
							mediumcol,
							shortcol, 
							notes, 
							LeagueCode,
							EmailAddress1, 
							EmailAddress2, 
							Level, 
							PromotionCandidate,
							Restrictions, 
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
			VALUES (	'#surname#, #forename#' , 
						'',
						'',
						'#Notes#',
						'#ThisLeagueCodePrefix#',
						'#EmailAddress1#',
						'#EmailAddress2#',
						'#RefLevel#',
						'No',
						'',
						'#surname#',
						'#forename#',
						<cfif Trim(DOB) IS "">'0000-00-00',<cfelse>'#DateFormat(DOB, 'YYYY-MM-DD')#',</cfif>
						<cfif Trim(FAN) IS "">NULL,<cfelse>'#FAN#',</cfif>
						'',
						'#AddressLine1#',
						'#AddressLine2#',
						'#AddressLine3#',
						'#PostCode#',
						'#HomeTel#',
						'#WorkTel#',
						'#MobileTel#' )
		</cfquery>
	</cfoutput>

