<!--- called by SecurityCheck.cfm --->
<cfquery name="QPWDThisLeague" datasource="zmast" > <!--- current league --->
	SELECT 
		pwd, 
		cfmpwd,
		cfmlist
	FROM identity WHERE leaguecodeprefix = '#request.CurrentLeagueCodePrefix#';
</cfquery>

<!--- cfmpwd and cfmlist were added just for the North West Counties Football League  (John Deal requested it) so a person could update Team Sheets only
without needing to log in as each club separateley, the log in SecurityLevel is Orange --->

<cfset ThisPWD = TRIM(QPWDThisLeague.pwd) >
<!--- Create the three character password from the First, Third and Last characters of the full password --->
<cfset ThisPWD3 = "#LEFT(ThisPWD,1)##MID(ThisPWD,3,1)##RIGHT(ThisPWD,1)#">
<cfset ThisPWD3 = UCase(ThisPWD3) >

