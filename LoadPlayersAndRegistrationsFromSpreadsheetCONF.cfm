<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfset TableName = "player" >

<cfinclude template="InclLoadPreliminaries.cfm">

<cfif ThisLeagueCodePrefix IS "CONF">
	<!---
	--->
	<!--- delete all the registrations --->
	<cfquery name="DelRegistrations" datasource="#ThisDB#">
		DELETE FROM 
			register
		WHERE 
			LeagueCode = '#ThisLeagueCodePrefix#'
	</cfquery>

	<!--- delete all the players except Own Goal --->
	<cfquery name="DelPlayers" datasource="#ThisDB#">
		DELETE FROM 
			player
		WHERE 
			LeagueCode = '#ThisLeagueCodePrefix#'
			AND NOT (Surname = 'OwnGoal')
	</cfquery>

	<table class="pix10">
		<tr>
			<td>
				<cfoutput>
					<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix10">
				</cfoutput>
						<cfset ListOfTeamIDs = "">
						<cfset TeamNamesAllOK = "Yes">
						<cfoutput query="objsheet.Query">
							<tr>
								<cfquery Name="QTeamName" datasource="#ThisDB#">
									SELECT
										ID 
									FROM
										team 
									WHERE
										LeagueCode = '#ThisLeagueCodePrefix#'
										AND MediumCol = '#Column4#'
								</cfquery>
								<cfif QTeamName.RecordCount IS 1>
									<cfset TeamID = QTeamName.ID >
									<cfset ListOfTeamIDs = ListAppend(ListOfTeamIDs,#TeamID#)>
								<cfelse>
									<cfset TeamNamesAllOK = "No">
									<!--- ERROR FOUND --->
									<td>#Column1#</td>
									<td>#Column2#</td>
									<td>#Column3#</td>
									<td>#Column4#</td>
									<td>#Column5#</td>
									<td>#Column6#</td>
									<td>#Column7#</td>
									<td>#Column8#</td>
									<cfif Column9 IS '0000-00-00'>
										<td>-</td>
									<cfelse>
										<td>#DateFormat(Column9, 'DD/MM/YYYY')#</td>
									</cfif>
								</cfif>
							</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
	</table>
	<span class="pix13">
		<cfif TeamNamesAllOK IS "No">
			Team Names NOT OK so aborting... 
			<cfabort>
		<cfelse>
			<br>Team Names OK<br> 
			<cfflush>
		</cfif>
	</span>

	<cfoutput query="objsheet.Query">

		<!--- make sure this player's reg no is unique  --->
		<cfquery name="QDuplicateRegNo" datasource="#ThisDB#">
			SELECT
				*
			FROM
				player
			WHERE
				LeagueCode = 'CONF'
				AND shortcol = #Column5# <!--- Column5 is ESAPlayerID e.g. 107216 --->
		</cfquery>
		<cfif QDuplicateRegNo.RecordCount IS 0>
			<!--- we can insert this player --->
			<cfquery name="InsrtPlayer" datasource="#ThisDB#" >
				INSERT INTO player 
					(Surname, Forename, MediumCol, ShortCol, Notes, LeagueCode) 
				VALUES ( 	'#Column7#', 
							'#Column6#',
							<cfif Column9 IS '0000-00-00'>
								NULL,
							<cfelse>
								'#DateFormat(Column9, 'YYYY-MM-DD')#',
							</cfif>
							#Column5#,
							'#Column8#',
							'#ThisLeagueCodePrefix#')
			</cfquery>
		<cfelse>
			<!--- don't insert this player, and do not add another registration ....just report the fact........--->
			<span class="pix10">
			#Column7# #Column6# Multiple Registration <br>
			</span>
			<cfflush>
		</cfif>
	</cfoutput>
<cfelse>

	<!---
	Column1 = Surname
	Column2 = Forenames
	Column3 = DOB  --------------- IMPORTANT this must be in YYYY-MM-DD format as a text field, not as a date value
	Column4 = RegNo
	Column5 = Notes
	Column6 = Firstday  --------------- IMPORTANT this must be in YYYY-MM-DD format as a text field, not as a date value
	Column7 = RegType
	Column8 = TeamName
	--->

<table class="pix10">
	<tr>
		<td>
			<cfoutput>
				<table border="1" cellpadding="#Thiscellpadding#" cellspacing="#Thiscellspacing#" class="pix10">
			</cfoutput>
					<cfset ListOfTeamIDs = "">
					<cfset TeamNamesAllOK = "Yes">

					<cfoutput query="objsheet.Query">
						<tr>
							<!--- Get Team ID from TeamName 
							make all dates 0000-00-00 if blank,
							In SQLyog do: update team set mediumcol=longcol where leaguecode='conf';
							and adjust so that the spreadsheet club name matches mediumcol
							--->
								<cfquery Name="QTeamName" datasource="#ThisDB#">
									SELECT
										ID 
									FROM
										team 
									WHERE
										LeagueCode = '#ThisLeagueCodePrefix#'
										AND MediumCol = '#Column4#'
								</cfquery>
							
							<cfif QTeamName.RecordCount IS 1>
								<cfset TeamID = QTeamName.ID >
								<cfset ListOfTeamIDs = ListAppend(ListOfTeamIDs,#TeamID#)>
							<cfelse>
								<cfif ThisLeagueCodePrefix IS "CONF">
									<cfset TeamNamesAllOK = "No">
									<!--- ERROR FOUND --->
									<td>#Column1#</td>
									<td>#Column2#</td>
									<td>#Column3#</td>
									<td>#Column4#</td>
									<td>#Column5#</td>
									<td>#Column6#</td>
									<td>#Column7#</td>
									<td>#Column8#</td>
								</cfif>
							</cfif>
						</tr>
					</cfoutput>
				</table>
			</td>
		</tr>
</table>

<cfif TeamNamesAllOK IS "No">
	<br><br> Team Names NOT OK so aborting... 
	<cfabort>
</cfif>

		
<cfquery name="DelRegistrations" datasource="#ThisDB#">
	DELETE FROM 
		register
	WHERE 
		LeagueCode = '#ThisLeagueCodePrefix#'
</cfquery>
<cfquery name="DelPlayers" datasource="#ThisDB#">
	DELETE FROM 
		player
	WHERE 
		LeagueCode = '#ThisLeagueCodePrefix#'
		AND NOT (Surname = 'OwnGoal')
</cfquery>

<cfoutput query="objsheet.Query">

		<!--- make sure this player is not already registered to another team  --->
				<cfquery name="QDuplicateRegNo" datasource="#ThisDB#">
					SELECT
						*
					FROM
						player
					WHERE
						LeagueCode = <cfqueryparam value = '#ThisLeagueCodePrefix#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
						AND shortcol = #Column4#
				</cfquery>
				<cfif QDuplicateRegNo.RecordCount IS 1>		
					DUPLICATE Registration Number #Column4# for #Column2# #Column1# - #Column8#<br>
				<cfelse>
					<cfquery name="InsrtPlayer" datasource="#ThisDB#" >
						INSERT INTO player 
							(Surname, Forename, MediumCol, ShortCol, Notes, LeagueCode) 
						VALUES ( <cfqueryparam value = '#Column1#' cfsqltype="CF_SQL_VARCHAR" maxlength="20">, 
							<cfqueryparam value = '#Column2#' cfsqltype="CF_SQL_VARCHAR" maxlength="35">, 				
							<cfif IsDate(Column3)>'#Column3#'<cfelse>NULL</cfif>,
							<cfqueryparam value = #Column4# cfsqltype="CF_SQL_INTEGER" maxlength="10">, 
							<cfqueryparam value = '#Column5#' cfsqltype="CF_SQL_LONGVARCHAR">,
							<cfqueryparam value = '#ThisLeagueCodePrefix#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> )
					</cfquery>
					<!--- Get the ID of this new row in the Player table --->
					<cfquery name="QPlayerID" datasource="#ThisDB#">
						SELECT
							ID
						FROM
							player
						WHERE
							LeagueCode = <cfqueryparam value = '#ThisLeagueCodePrefix#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
							AND ShortCol = <cfqueryparam value = #Column4# cfsqltype="CF_SQL_INTEGER" maxlength="10">
					</cfquery>	
					<cfif QPlayerID.RecordCount IS NOT 1>
						aborted..678 ....
						<cfabort >
					</cfif>
					<cfif Column7 IS "Non-Contract">
						<cfset RegType = "A">
					<cfelseif Column7 IS "Contract">
						<cfset RegType = "B">
					<cfelseif Column7 IS "Short Loan">
						<cfset RegType = "C">
					<cfelseif Column7 IS "Long Loan">
						<cfset RegType = "D">
					<cfelseif Column7 IS "Work Experience">
						<cfset RegType = "E">
					<cfelseif Column7 IS "Lapsed">
						<cfset RegType = "G">
					<cfelseif Column7 IS "Temporary">
						<cfset RegType = "F">
					<cfelse>
						<cfset RegType = "X">
					</cfif>
			
				<!--- Get the TeamID  --->
					<CFQUERY NAME="QTeamID" datasource="#ThisDB#">
						SELECT
							ID
						FROM
							team
						WHERE
							LeagueCode = <cfqueryparam value = '#ThisLeagueCodePrefix#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
							AND MediumCol = '#Column8#'
					</CFQUERY>
					<cfif QTeamID.RecordCount IS 1>
						<cfquery name="QAddRegistration" datasource="#ThisDB#" >
							INSERT INTO
								register
								(TeamID, PlayerID, FirstDay, RegType, LeagueCode) 
							VALUES
								( #QTeamID.ID#, #QPlayerID.ID#, '#Column6#', '#RegType#', '#ThisLeagueCodePrefix#' )
						</cfquery>
					</cfif>
				</cfif>
</cfoutput>


</cfif>