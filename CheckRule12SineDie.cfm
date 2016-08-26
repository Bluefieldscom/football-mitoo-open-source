<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<!---  Rule12 spreadsheet must be in this format 
A column1 as npd,               
B column2 as surname,
C column3 as forename,
D column4 as DOB,
E column5 as address,
F column6 as StartDate of suspension

The spreadsheet should be put in the same directory as the .cfm code 

--->

<cfset ThisDB = "fm#Right(url.LeagueCode,4)#">                                     <!--- e.g. "fm2009" --->
<cfset Thiscellpadding = "2" >
<cfset Thiscellspacing = "2" >
<!--- e.g. CheckRule12SineDie.cfm?LeagueCode=SDWFL2009 --->
<cfset objPOI = CreateObject( 
  "component", 
  "POIUtility" 
  ).Init() 
  />

<cfset spreadsheetname = "Rule12">
<cfset Spreadsheet = "#spreadsheetname#.xls">
<cfset objSheet = objPOI.ReadExcel( 
  FilePath = ExpandPath( "./#Spreadsheet#" ),
  HasHeaderRow = false,
  SheetIndex = 0
  ) />

<cfquery Name="QBanned" dbtype="query">
	SELECT
		column1 as npd,
		UPPER(column2) as surname,
		UPPER(column3) as forename,
		column4 as DOB,
		column5 as address,
		column6 as StartDate
	FROM
		objsheet.query
	ORDER BY
		surname, forename
</cfquery>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
	<tr>
		<td><span class="pix10bold">Matching<br />Surname</span></td>
		<td><span class="pix10bold">Forenames</span></td>
		<td><span class="pix10bold">Matching<br />Date of Birth</span></td>
		<td><span class="pix10bold">Reg No<br /></span><span class="pix10boldnavy">FAN</span></td>
		<td><span class="pix10boldnavy">Effective Date</span></td>
		<td><span class="pix10bold">Notes<br /></span><span class="pix10boldnavy">Address</span></td>
	</tr>
	<cfoutput query="QBanned">
		<cfset ThisSurname = '#UCASE(QBanned.surname)#'>
		<cfset ThisDOB = '#DateFormat(QBanned.DOB, "YYYY-MM-DD")#'>
		<cfinclude template = "queries/qry_QSurnamesDobs.cfm">
		<cfif QSurnamesDobs.RecordCount GT 0>
		<cfloop query="QSurnamesDobs">
			<cfinclude template = "queries/qry_QRegister.cfm">
			<cfif QRegister.RecordCount GT 0>
				<cfloop query="QRegister">
				<cfif QRegister.currentlyregistered IS "Yes">
					<tr bgcolor="pink">
						<td><a href="LUList.cfm?LeagueCode=#LeagueCode#&TblName=Player&FirstNumber=#QSurnamesDobs.RegNo#&LastNumber=#QSurnamesDobs.RegNo#"><span class="pix10bold">#QSurnamesDobs.surname#</span></a></td>
						<td><span class="pix10bold">#QSurnamesDobs.forename#</span></td>
						<td><span class="pix10bold">#dateformat(QSurnamesDobs.DOB, 'DD/MM/YYYY')#</span></td>
						<td><span class="pix10bold">#QSurnamesDobs.RegNo#</span></td>
						<td><span class="pix10bold">&nbsp;</span></td>
						<td width="45%"><span class="pix10bold">#QSurnamesDobs.notes#</span></td>
					</tr>
					<tr bgcolor="pink">
						<td  valign="top"><span class="pix10boldnavy">#QBanned.surname#</span></td>
						<td  valign="top"><span class="pix10boldnavy">#QBanned.forename#</span></td>
						<td  valign="top"><span class="pix10boldnavy">#dateformat(QBanned.DOB, 'DD/MM/YYYY')#</span></td>
						<td  valign="top"><span class="pix10boldnavy">#QBanned.npd#</span></td>
						<td  valign="top"><span class="pix10boldnavy">#dateformat(QBanned.StartDate, 'DD/MM/YYYY')#</span></td>
						<td  valign="top"><span class="pix10boldnavy">#QBanned.Address#</span></td>
					</tr>
				<cfelse>
					<tr>
						<td><a href="LUList.cfm?LeagueCode=#LeagueCode#&TblName=Player&FirstNumber=#QSurnamesDobs.RegNo#&LastNumber=#QSurnamesDobs.RegNo#"><span class="pix10">#QSurnamesDobs.surname#</span></a></td>
						<td><span class="pix10">#QSurnamesDobs.forename#</span></td>
						<td><span class="pix10">#dateformat(QSurnamesDobs.DOB, 'DD/MM/YYYY')#</span></td>
						<td><span class="pix10">#QSurnamesDobs.RegNo#</span></td>
						<td><span class="pix10">&nbsp;</span></td>
						<td width="45%"><span class="pix10">#QSurnamesDobs.notes#</span></td>
					</tr>
					<tr>
						<td  valign="top"><span class="pix10navy">#QBanned.surname#</span></td>
						<td  valign="top"><span class="pix10navy">#QBanned.forename#</span></td>
						<td  valign="top"><span class="pix10navy">#dateformat(QBanned.DOB, 'DD/MM/YYYY')#</span></td>
						<td  valign="top"><span class="pix10navy">#QBanned.npd#</span></td>
						<td  valign="top"><span class="pix10navy">#dateformat(QBanned.StartDate, 'DD/MM/YYYY')#</span></td>
						<td  valign="top"><span class="pix10navy">#QBanned.Address#</span></td>
					</tr>
				</cfif>
				<cfinclude template = "queries/qry_QAppearanceF.cfm">
				<cfif QAppearanceF.RecordCount GT 0>
					<tr>
						<td colspan="6"><span class="pix10boldred">appearances = #QAppearanceF.RecordCount#</span></td>
					</tr>
				</cfif>
				<tr>
					<td height="40" colspan="6"><span class="pix10">&nbsp;</span></td>
				</tr>
				</cfloop>				
			</cfif>
		</cfloop>
		</cfif>
				
	</cfoutput>	
</table>
