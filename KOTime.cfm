<!--- Need to be logged in to see this report --->
<cfif NOT ListFind("Silver,Skyblue,Yellow",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif ListFind("Yellow",request.SecurityLevel)>
	<cfif request.YellowKey IS NOT "#request.CurrentLeagueCode##request.DropDownTeamID#" >
		<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
		<cfabort>
	</cfif>
</cfif>

<cfif ListFind("Yellow",request.SecurityLevel) >
	<cfinclude template = "queries/qry_QValidFID.cfm">
	<!--- Is the FID valid for the current team ? Has it been tampered with in the URL ? --->
	<!--- <cfdump var="#QValidFID#"><cfdump var="#request#"> --->
	<cfif QValidFID.RecordCount IS 1>
		<cfif StructKeyExists(url, "HA")>
			<cfif QValidFID.HomeID IS request.DropDownTeamID AND url.HA IS "H" >
				<cfset HA = "H">
			<cfelseif QValidFID.AwayID IS request.DropDownTeamID AND url.HA IS "A" >
				<cfset HA = "A">
			<cfelse>
				<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
				<cfabort>
			</cfif>
		<cfelse>
			<cfif QValidFID.HomeID IS request.DropDownTeamID >
				<cfset HA = "H">
			<cfelseif QValidFID.AwayID IS request.DropDownTeamID >
				<cfset HA = "A">
			<cfelse>
				<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
				<cfabort>
			</cfif>
		</cfif>
	<cfelse>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
	</cfif>
</cfif>


<cfset variables.robotindex="no">
<!--- include toolbars 1 & 2 --->
<cfinclude template="InclBegin.cfm">
<cfoutput>
<cfif StructKeyExists(url, "FID")>
	<cfset ThisFID = url.FID>
</cfif>
<cfif StructKeyExists(form, "FID")>
	<cfset ThisFID = form.FID>
</cfif>


<!--- OK button has been pressed - so update accordingly before re-presenting the latest state of affairs --->
<cfif StructKeyExists(form, "UpdateButton")>
	<cfif IsDate(form.KOTime)>
		<CFQUERY NAME="QFixtures" datasource="#request.DSN#">
			UPDATE fixture SET KOTime = '#TimeFormat(form.KOTime, "HH:mm")#' WHERE ID = #form.FID# AND LeagueCode='#request.filter#'
		</cfquery>
	<cfelse>
		<CFQUERY NAME="QFixtures" datasource="#request.DSN#">
			UPDATE fixture SET KOTime = NULL WHERE ID = #form.FID# AND LeagueCode='#request.filter#'
		</cfquery>
	</cfif>
</cfif>

</cfoutput>
<CFQUERY NAME="QFixtures" datasource="#request.DSN#">
SELECT 
	CASE
	WHEN o1.LongCol IS NULL
	THEN t1.LongCol
	ELSE CONCAT(t1.LongCol, " ", o1.LongCol)
	END
	as HomeTeamName ,
	CASE
	WHEN o2.LongCol IS NULL
	THEN t2.LongCol
	ELSE CONCAT(t2.LongCol, " ", o2.LongCol)
	END
	as AwayTeamName,
	t1.ID as HomeTeamID,
	t2.ID as AwayTeamID,
	k.longcol as RoundName ,
	f.HomeID ,
	f.AwayID ,
	f.FixtureDate ,
	f.FixtureNotes ,
	f.ID as FID,
	f.KOTime,
	d.Longcol as CompetitionName	
FROM
	fixture AS f ,
	division d,
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS o1,
	ordinal AS o2,
	koround AS k 
WHERE
	f.ID = #ThisFID#
	AND c1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND d.ID = c1.DivisionID
	AND f.HomeID = c1.ID 
	AND f.AwayID = c2.ID 
	AND t1.ID = c1.TeamID 
	AND o1.id = c1.OrdinalID 
	AND t2.ID = c2.TeamID 
	AND o2.id = c2.OrdinalID 
	AND f.KORoundID = k.ID

<!--- LIMIT #(Start-1)#,25 --->
<!--- Inital Row Offset is 0, not 1! --->
</CFQUERY>


<!--- This is what happens when the Add/Update/Delete button is pressed.... --->
<CFFORM ACTION="KOTime.cfm" METHOD="post" name="xxxxxxxxx" >
	<!--- pass the LeagueCode in a hidden field --->
	<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="<cfoutput>#LeagueCode#</cfoutput>">
	<INPUT TYPE="HIDDEN" NAME="FID" VALUE="<cfoutput>#ThisFID#</cfoutput>">
		<table width="100%" border="0" cellpadding="5" cellspacing="0" class="loggedinScreen">
		<cfoutput query="QFixtures">
					<tr align="center" >
						<td>
							<span class="pix18bold">#CompetitionName#<cfif TRIM(#RoundName#)IS NOT "" > #RoundName#</cfif></span>
						</td>
					</tr>
					<tr align="center" >
						<td>
							<span class="pix18bold">#HomeTeamName# v #AwayTeamName#</span>
						</td>
					</tr>
					<tr align="center" >
						<td>
							<span class="pix18bold">#DateFormat(FixtureDate, 'DDDD, DD MMM YYYY')#</span>
						</td>
					</tr>
					
					<tr align="center" >
						<td>
							<span class="pix18bold">KO Time <input name="KOTime" type="text" value="#TimeFormat(QFixtures.KOTime, 'h:mm TT')#" size="7"></span><span class="pix10"><br>enter, for example, <strong>10:30</strong> or <strong>15:00</strong> or <strong>7:30 PM</strong> then click on Update button</span>
						</td>
					</tr>
					
					<tr align="center" >
						<td>
							<span class="pix13"><input type="Submit" name="UpdateButton" value="Update"></span>
						</td>
					</tr>
		</cfoutput>
		</table>
</CFFORM>
