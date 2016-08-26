<!---
qry_import_process.cfm
Purpose:	Process all the tables in the Access table by extracting data 
			and inserting into a .CSV file.
			The CSV file is only created if there is data in the table, and
			data is only imported if the table had data.
			Certain older years did not have particular tables, and in these
			cases, a check is made to test their existence. As with above,
			if the table didn't exist, no CSV is created, and nothing is imported.
			
			Where required, ID numbers are extracted and have the current MySQL table 
			Max(ID) value added prior to insertion.
			
			Referential integrity checking is turned off prior to insertion of those
			tables that require it.
	
			Data is imported by a bulk insert into each MySQL table from the relevant 
			CSV file.
			
			All table data are inserted	with a LeagueCode column that relates,
			without numeric suffix, to the league in question. This will be used to
			differentiate leagues in a particular year.
			
			
Created:	14 July 2004
Modified:	27 July 2004
By:			Terry Riley
Called by:	qry_import_process.cfm
Notes:		1) When this is from last year (03) into (04), 
			we can ignore fixture, matchreport, appearance and suspension tables
			2) SMS removed 11/July
			3) Referee, KORound and Committee tables can be imported (without ID)
			and with LeagueCode added
			4) What happens with MatchNo? Where do we have to be sure to get NULL 
			when field is empty?
			5) SELECT NULL AS ID changed where appropriate to SELECT '' AS ID
--->

<cfparam name="attributes.source" default="">

<!--- to reject a non-registered mdb, list it and continue --->
<cftry>
	<cfquery name="testsource" datasource="#attributes.source#">
		SELECT MAX(ID) FROM constitution
	</cfquery>
	<cfcatch type="Database">
		<!--- add the mdb to the failed list --->
		<cfset application.failedlist = ListAppend(application.failedlist,#attributes.source#)>
		<!--- exit this part of the loop and continue with next one --->
		<cfexit>
	</cfcatch>
</cftry>

<cfsilent>
<cfif attributes.source IS NOT "">
	<!--- set counters to zero --->
	<cfscript>
		variables.teamHasData    = 0;
		variables.Fixhasdata     = 0;
		variables.Rephasdata     = 0;
		variables.KOhasdata      = 0;
		variables.Refhasdata     = 0;
		variables.Consthasdata   = 0;
		variables.Divhasdata     = 0;
		variables.Playerhasdata  = 0;
		variables.Reghasdata     = 0;
		variables.Sushasdata     = 0;
		variables.Apphasdata     = 0;
		variables.Commhasdata    = 0;
		variables.Sponhasdata    = 0;
		variables.Ordhasdata     = 0;
		variables.MatchNohasdata = 0;
		variables.Newshasdata    = 0;
		
		//variables.ZMASTcount     = 0;
	
		variables.commexists     = 1;
		variables.reportexists   = 1;
		variables.appexists      = 1;
		variables.regexists      = 1;
		variables.playerexists   = 1;
		variables.susexists      = 1;
		variables.sponexists	 = 1;
		variables.newsexists     = 1;
	</cfscript>	

	<cfif IsNumeric(RIGHT(attributes.source,2))>
		<cfset LeagueCode = #UCASE(LEFT(attributes.source, Len(attributes.source)-2))#>
	<cfelse>
		<cfset LeagueCode = UCASE(attributes.source)>
	</cfif>
	
	<!--- grab relevant current MySQL FM database maxes --->	
	<cfinclude template="qry_getmaxes.cfm">
		
	<!--- special one-off for MatchNo --->
	<cfif variables.maxMatchNoID IS 0>
		<cfquery name="GetMatchNos" datasource="HERTS03">
			SELECT
				ID, Long
			FROM MatchNo
		</cfquery>
	</cfif>

	<!--- retrieve 'old' data --->
	<cfquery name="GetRefs" datasource="#attributes.source#">
		SELECT 
			(ID+#variables.maxRefID#) AS NewRefID,
			long AS LongCol, 
			medium AS mediumCol, 
			short AS shortCol, 
			notes
		FROM
			Referee
	</cfquery>
	<cfif getrefs.recordcount GT 0>
		<cfset variables.Refhasdata = 1>
	</cfif>

	<cfset textoutput = ''>

	<cfset variables.table_name = "referee">

	<cfset variables.referee_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>
	<!--- 
	first delete any existing file with this name 
	this prevents double-writing and causing 'duplicate key' errors 
	--->
	<cfif FileExists(#variables.referee_file_name#)>
		<cffile action="DELETE" file="#variables.referee_file_name#">
	</cfif>
	
	<cfloop query="getrefs">
		<cfset newnotes = Replace(notes,'"','\"','ALL')>	
		<cfset textoutput = '"#NewRefID#","#LongCol#","#mediumCol#","#shortCol#","#newnotes#","#LeagueCode#"'>
		<cfif NOT FileExists(#variables.referee_file_name#)>
			<cffile action="WRITE" 
				file="#variables.referee_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.referee_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>

	<cftry>
	<cfquery name="GetComm" datasource="#attributes.source#">
		SELECT 
			'' AS ID,
			long AS LongCol, 
			medium AS mediumCol, 
			short AS shortCol, 
			notes
		FROM
			Committee
	</cfquery>
	<cfcatch type="database">
		<cfscript>
		// if not exist
		variables.commexists = 0;
		</cfscript>
	</cfcatch>
	</cftry>
	<cfif variables.commexists EQ 1 AND getcomm.recordcount GT 0>
		<cfset variables.commhasdata = 1>
		<cfset textoutput = ''>
		<cfset variables.table_name = "committee">
		<cfset variables.committee_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>
		
		<cfif FileExists(#variables.committee_file_name#)>
			<cffile action="DELETE" file="#variables.committee_file_name#">
		</cfif>
		<cfloop query="getComm">
			<cfset newnotes = Replace(notes,'"','\"','ALL')>
			<cfset textoutput = '"#ID#","#longCol#","#mediumCol#","#shortCol#","#newnotes#","#LeagueCode#"'>
			<cfif NOT FileExists(#variables.committee_file_name#)>
				<cffile action="WRITE" 
					file="#variables.committee_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			<cfelse>
				<cffile action="Append" 
					file="#variables.committee_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			</cfif>
		</cfloop>
	</cfif>	
	
	<cftry>
	<cfquery name="GetSpons" datasource="#attributes.source#">
		SELECT 
			'' AS ID,
			lastupdated,
			button,
			DID,
			(TID+#variables.maxTeamID#) AS NewTID, 
			(OID+#variables.maxOrdID#) AS NewOID, 
			sponsorsHTML, SponsorsName, notes, TeamHTML
		FROM
			Sponsor
	</cfquery>
	<cfcatch type="database">
		<cfscript>
		// if not exist
		variables.sponexists = 0;
		</cfscript>
	</cfcatch>
	</cftry>	
	<cfif variables.sponexists EQ 1 AND getspons.recordcount GT 0>
		<cfset variables.sponhasdata = 1>
		<cfset textoutput = ''>
		<cfset variables.table_name = "sponsor">
		<cfset variables.sponsor_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>
		
		<cfif FileExists(#variables.sponsor_file_name#)>
			<cffile action="DELETE" file="#variables.sponsor_file_name#">
		</cfif>
		<cfloop query="getspons">
			<cfset newnotes = Replace(notes,'"','\"','ALL')>
			<cfset newsponsorsHTML = Replace(sponsorsHTML,'"','\"','ALL')>
			<cfset newteamHTML = Replace(teamHTML,'"','\"','ALL')>			
			<cfset textoutput = '"#ID#","#lastupdated#","#button#","#DID#","#NewTID#","#NewOID#","#newsponsorsHTML#","#SponsorsName#","#newnotes#","#newteamHTML#","#LeagueCode#"'>
			<cfif NOT FileExists(#variables.sponsor_file_name#)>
				<cffile action="WRITE" 
					file="#variables.sponsor_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			<cfelse>
				<cffile action="Append" 
					file="#variables.sponsor_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			</cfif>
		</cfloop>
	</cfif>	
	
	<cfquery name="GetCons" datasource="#attributes.source#">
		SELECT
			(ID+#variables.maxConstitID#) AS NewConstitID,
			(DivisionID+#variables.maxDivID#) AS NewDivID, 
			(TeamID+#variables.maxTeamID#) AS NewTeamID, 
			(OrdinalID+#variables.maxOrdID#) AS NewOrdID, 
			ThisMatchNoID, 
			NextMatchNoID
		FROM
			Constitution
	</cfquery>	
	
	<cfif getcons.recordcount GT 0>
		<cfset variables.consthasdata = 1>
	</cfif>
	
	<cfset textoutput = ''>
	<cfset variables.table_name = "constitution">
	<cfset variables.constitution_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>

	<cfif FileExists(#variables.constitution_file_name#)>
		<cffile action="DELETE" file="#variables.constitution_file_name#">
	</cfif>

	<cfloop query="getcons">
		<cfset textoutput = '"#NewConstitID#","#NewDivID#","#NewTeamID#","#NewOrdID#","#ThisMatchNoID#","#NextMatchNoID#","#LeagueCode#"'>
		<cfif NOT FileExists(#variables.constitution_file_name#)>
			<cffile action="WRITE" 
				file="#variables.constitution_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.constitution_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>
	
	<cfquery name="GetKO" datasource="#attributes.source#">
		SELECT
			(ID+#variables.maxKOID#) AS NewKOID, 
			long AS LongCol, 
			medium AS mediumCol, 
			short AS shortCol, 
			notes
		FROM
			KORound
	</cfquery>

	<cfif GetKO.recordcount GT 0>
		<cfset variables.kohasdata = 1>
	</cfif>
	
	<cfset textoutput = ''>
	<cfset variables.table_name = "koround">
	<cfset variables.koround_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>

	<cfif FileExists(#variables.koround_file_name#)>
		<cffile action="DELETE" file="#variables.koround_file_name#">
	</cfif>

	<cfloop query="getko">
		<cfset newnotes = Replace(notes,'"','\"','ALL')>
		<cfset textoutput = '"#NewKOID#","#longCol#","#mediumCol#","#shortCol#","#newnotes#","#LeagueCode#"'>
		<cfif NOT FileExists(#variables.koround_file_name#)>
			<cffile action="WRITE" 
				file="#variables.koround_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.koround_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>
		
	
	<!--- 
	equivalent years only (ie 04 to fm2004).Will not apply with 03 to fm2004 
	--->
	<cfif application.year EQ application.newyear>
	
		<cftry>
		<cfquery name="GetNews" datasource="#attributes.source#">
			SELECT 
				(ID+#variables.maxNewsID#) AS NewNewsID, 
				Long AS longcol, 
				Medium AS mediumcol, 
				Short AS shortcol, 
				notes
			FROM
				NewsItem
		</cfquery>
		<cfcatch type="database">
			<cfscript>
			// if not exist
			variables.newsexists = 0;
			</cfscript>
		</cfcatch>
		</cftry>	
		<cfif variables.newsexists EQ 1 AND getnews.recordcount GT 0>
			<cfset variables.newshasdata = 1>
			<cfset textoutput = ''>
			<cfset variables.table_name = "newsitem">
			<cfset variables.newsitem_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>
		
			<cfif FileExists(#variables.newsitem_file_name#)>
				<cffile action="DELETE" file="#variables.newsitem_file_name#">
			</cfif>
			<cfloop query="getnews">
				<cfset newnotes = Replace(notes,'"','\"','ALL')>
				<cfset textoutput = '"#NewNewsID#","#longCol#","#mediumCol#","#shortCol#","#newnotes#","#LeagueCode#"'>
				<cfif NOT FileExists(#variables.newsitem_file_name#)>
					<cffile action="WRITE" 
						file="#variables.newsitem_file_name#" 
						output="#textoutput#" 
						addnewline="Yes">
				<cfelse>
					<cffile action="Append" 
						file="#variables.newsitem_file_name#" 
						output="#textoutput#" 
						addnewline="Yes">
				</cfif>
			</cfloop>
		</cfif>		

		<cfquery name="GetFixtures" datasource="#attributes.source#">
			SELECT
				(ID+#variables.maxFixtureID#) AS NewID,
				(HomeID+#variables.maxConstitID#) AS NewHomeID, 
				(AwayID+#variables.maxConstitID#) AS NewAwayID, 
				MatchNumber, 
				FixtureDate, 
				HomeGoals, 
				AwayGoals, 
				Result, 
				(RefereeID+#variables.maxRefID#) AS NewRefereeID, 
				RefereeMarksH, 
				RefereeMarksA,
				(AsstRef1ID+#variables.maxRefID#) AS NewAsstRef1ID, 
				AsstRef1Marks,
				(AsstRef2ID+#variables.maxRefID#) AS NewAsstRef2ID,
				AsstRef2Marks, 
				HomeSportsmanshipMarks, 
				AwaySportsmanshipMarks, 
				(KORoundID+#variables.maxKOID#) AS NewKORoundID, 
				FixtureNotes, 
				HomePointsAdjust, 
				AwayPointsAdjust
			FROM
				Fixture
		</cfquery>
		
		<cfif getfixtures.recordcount GT 0>
			<cfset variables.Fixhasdata = 1>
		</cfif>
		
		<cfset textoutput = ''>
		<cfset variables.table_name = "fixture">
		<cfset variables.fixture_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>
		
		<cfif FileExists(#variables.fixture_file_name#)>
			<cffile action="DELETE" file="#variables.fixture_file_name#">
		</cfif>
		
		<cfloop query="getfixtures">
			<cfset newfixturenotes = Replace(fixturenotes,'"','\"','ALL')>
			<cfif HomeGoals GT "">
				<cfset HomeGoalsNull = 0>
			<cfelse>
				<cfset HomeGoalsNull = 1>
			</cfif>
			<cfif AwayGoals GT "">
				<cfset AwayGoalsNull = 0>
			<cfelse>
				<cfset AwayGoalsNull = 1>
			</cfif>
			<cfif RefereeMarksH GT "">
				<cfset RefereeMarksHNull = 0>
			<cfelse>
				<cfset RefereeMarksHNull = 1>
			</cfif>
			<cfif RefereeMarksA GT "">
				<cfset RefereeMarksANull = 0>
			<cfelse>
				<cfset RefereeMarksANull = 1>
			</cfif>
			<cfif AsstRef1Marks GT "">
				<cfset AsstRef1MarksNull = 0>
			<cfelse>
				<cfset AsstRef1MarksNull = 1>
			</cfif>
			<cfif AsstRef2Marks GT "">
				<cfset AsstRef2MarksNull = 0>
			<cfelse>
				<cfset AsstRef2MarksNull = 1>
			</cfif>
			<cfif HomeSportsmanshipMarks GT "">
				<cfset HomeSportsmanshipMarksNull = 0>
			<cfelse>
				<cfset HomeSportsmanshipMarksNull = 1>
			</cfif>
			<cfif AwaySportsmanshipMarks GT "">
				<cfset AwaySportsmanshipMarksNull = 0>
			<cfelse>
				<cfset AwaySportsmanshipMarksNull = 1>
			</cfif>															
			<cfset textoutput = '"#NewID#","#NewHomeID#","#NewAwayID#","#MatchNumber#","#FixtureDate#","#HomeGoals#","#AwayGoals#","#Result#","#NewRefereeID#","#RefereeMarksH#","#RefereeMarksA#","#NewAsstRef1ID#","#AsstRef1Marks#","#NewAsstRef2ID#","#AsstRef2Marks#","#HomeSportsmanshipMarks#","#AwaySportsmanshipMarks#","#NewKORoundID#","#newFixtureNotes#","#HomePointsAdjust#","#AwayPointsAdjust#","#LeagueCode#","#HomeGoalsNull#","#AwayGoalsNull#","#RefereeMarksHNull#","#RefereeMarksANull#","#AsstRef1MarksNull#","#AsstRef2MarksNull#","#HomeSportsmanshipMarksNull#","#AwaySportsmanshipMarksNull#"'>
			<cfif NOT FileExists(#variables.fixture_file_name#)>
				<cffile action="WRITE" 
					file="#variables.fixture_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			<cfelse>
				<cffile action="Append" 
					file="#variables.fixture_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			</cfif>
		</cfloop>
			
	
		<cftry>
			<cfquery name="GetReps" datasource="#attributes.source#">
				SELECT 
					'' AS ID, 
					Long, Medium,
					(Short+#variables.maxFixtureID#) AS NewFixID,
					notes
				FROM 
					MatchReport
			</cfquery>
			<cfcatch type="database">
				<cfscript>
				// if failed, set to 0
				variables.reportexists = 0;
				</cfscript>
			</cfcatch>
		</cftry>
		<cfif variables.reportexists EQ 1 AND getreps.recordcount GT 0>
			<cfset variables.rephasdata = 1>
			<cfset textoutput = ''>
			<cfset variables.table_name = "matchreport">
			<cfset variables.matchreport_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>

			<cfif FileExists(#variables.matchreport_file_name#)>
				<cffile action="DELETE" file="#variables.matchreport_file_name#">
			</cfif>
			
			<cfloop query="getReps">
				<cfset newnotes = Replace(notes,'"','\"','ALL')>
				<cfset textoutput = '"#ID#","#Long#","#Medium#","#NewFixID#","#newnotes#","#LeagueCode#"'>
				<cfif NOT FileExists(#variables.matchreport_file_name#)>
					<cffile action="WRITE" 
						file="#variables.matchreport_file_name#" 
						output="#textoutput#" 
						addnewline="Yes">
				<cfelse>
					<cffile action="Append" 
						file="#variables.matchreport_file_name#" 
						output="#textoutput#" 
						addnewline="Yes">
				</cfif>
			</cfloop>
		</cfif>			
		
		<cftry>
			<cfquery name="GetApps" datasource="#attributes.source#">
				SELECT
					'' AS ID,
					(FixtureID+#variables.maxFixtureID#) AS NewFixtureID,
					HomeAway,
					(PlayerID+#variables.maxPlayerID#) AS NewPlayerID,
					GoalsScored, 
					Card
				FROM Appearance
			</cfquery>
			<cfcatch type="database">
				<cfscript>
				// if failed, set to 0
				variables.appexists = 0;
				</cfscript>
			</cfcatch>
		</cftry>

		<cfif variables.appexists EQ 1 AND getapps.recordcount GT 0>
			<cfset variables.apphasdata = 1>
			<cfset textoutput = ''>
			<!--- <cfset variables.data = "#application.DSN#"> --->
			<cfset variables.table_name = "appearance">
			<cfset variables.appearance_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>

			<cfif FileExists(#variables.appearance_file_name#)>
				<cffile action="DELETE" file="#variables.appearance_file_name#">
			</cfif>
			
			<cfloop query="getapps">
				<cfset textoutput = '"#ID#","#NewFixtureID#","#HomeAway#","#NewPlayerID#","#GoalsScored#","#Card#","#LeagueCode#"'>
				<cfif NOT FileExists(#variables.appearance_file_name#)>
					<cffile action="WRITE" 
						file="#variables.appearance_file_name#" 
						output="#textoutput#" 
						addnewline="Yes">
				<cfelse>
					<cffile action="Append" 
						file="#variables.appearance_file_name#" 
						output="#textoutput#" 
						addnewline="Yes">
				</cfif>
			</cfloop>
		</cfif>
		
		<cftry>
			<cfquery name="GetSus" datasource="#attributes.source#">
				SELECT
					'' AS ID,
					(PlayerID+#variables.maxPlayerID#) AS NewPlayerID,
					FirstDay,
					LastDay
				FROM
					Suspension
			</cfquery>
			<cfcatch type="database">
				<cfscript>
				// if failed, set to 0
				variables.susexists = 0;
				</cfscript>
			</cfcatch>
		</cftry>
		<cfif variables.susexists EQ 1 AND getsus.recordcount GT 0>
			<cfset variables.sushasdata = 1>
			<cfset textoutput = ''>
			<cfset variables.table_name = "suspension">
			<cfset variables.suspension_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>
		
			<cfif FileExists(#variables.suspension_file_name#)>
				<cffile action="DELETE" file="#variables.suspension_file_name#">
			</cfif>
			
			<cfloop query="getSus">
				<cfif FirstDay GT "">
					<cfset FirstDayNull = 0>
				<cfelse>
					<cfset FirstDayNull = 1>
				</cfif>
				<cfif LastDay GT "">
					<cfset LastDayNull = 0>
				<cfelse>
					<cfset LastDayNull = 1>
				</cfif>				
				<cfset textoutput = '"#ID#","#NewPlayerID#","#firstday#","#lastday#","#LeagueCode#","#FirstDayNull#","#LastDayNull#"'>
				<cfif NOT FileExists(#variables.suspension_file_name#)>
					<cffile action="WRITE" 
						file="#variables.suspension_file_name#" 
						output="#textoutput#" 
						addnewline="Yes">
				<cfelse>
					<cffile action="Append" 
						file="#variables.suspension_file_name#" 
						output="#textoutput#" 
						addnewline="Yes">
				</cfif>
			</cfloop>
		</cfif>			
	
	</cfif>
	<!--- end of equivalent year data --->	

	<cfquery name="GetDivs" datasource="#attributes.source#">
		SELECT
			(ID+#variables.maxDivID#) AS newID, 
			Long AS LongCol, 
			medium AS mediumCol, 
			short AS shortCol, 
			notes
		FROM
			Division
	</cfquery>
	<cfif getdivs.recordcount GT 0>
		<cfset variables.divhasdata = 1>
	</cfif>
	<cfset textoutput = ''>
	<cfset variables.table_name = "division">
	<cfset variables.division_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>

	<cfif FileExists(#variables.division_file_name#)>
		<cffile action="DELETE" file="#variables.division_file_name#">
	</cfif>

	<cfloop query="getDivs">
		<cfset newnotes = Replace(notes,'"','\"','ALL')>
		<cfset textoutput = '"#newID#","#longCol#","#mediumCol#","#shortCol#","#newnotes#","#LeagueCode#"'>
		<cfif NOT FileExists(#variables.division_file_name#)>
			<cffile action="WRITE" 
				file="#variables.division_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.division_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>

	
	<cfquery name="GetTeams" datasource="#attributes.source#">
		SELECT
			(ID+#variables.maxTeamID#) AS newID,
			long AS LongCol,
			medium AS mediumCol,
			short AS shortCol,
			notes
		FROM
			Team
	</cfquery>
	<cfif getteams.recordcount GT 0>
		<cfset variables.teamhasdata = 1>
	</cfif>
	<cfset textoutput = ''>
	<cfset variables.table_name = "team">
	<cfset variables.team_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>

	<cfif FileExists(#variables.team_file_name#)>
		<cffile action="DELETE" file="#variables.team_file_name#">
	</cfif>

	<cfloop query="getTeams">
		<cfset newnotes = Replace(notes,'"','\"','ALL') >
		<cfset textoutput = '"#newID#","#longCol#","#mediumCol#","#shortCol#","#newnotes#","#LeagueCode#"'>
		<cfif NOT FileExists(#variables.team_file_name#)>
			<cffile action="WRITE" 
				file="#variables.team_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.team_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>

	
	<cftry>
		<cfquery name="GetRegs" datasource="#attributes.source#">
			SELECT
				(ID+#variables.maxRegID#) AS newID, 
				(TeamID+#variables.maxTeamID#) AS newTeamID, 
				(PlayerID+#variables.maxPlayerID#) AS newPlayerID
			FROM
				Register
		</cfquery>	
		<cfcatch type="database">
			<cfscript>
			// if fails, set to 0
			variables.regexists = 0;
			</cfscript>
		</cfcatch>
	</cftry>
	<cfif variables.regexists EQ 1 AND getregs.recordcount GT 0>
		<cfset variables.reghasdata = 1>
		<cfset textoutput = ''>
		<cfset variables.table_name = "register">
		<cfset variables.register_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>
		
		<cfif FileExists(#variables.register_file_name#)>
			<cffile action="DELETE" file="#variables.register_file_name#">
		</cfif>
		
		<cfloop query="getRegs">
			<cfset textoutput = '"#newID#","#newTeamID#","#newPlayerID#","#LeagueCode#"'>
			<cfif NOT FileExists(#variables.register_file_name#)>
				<cffile action="WRITE" 
					file="#variables.register_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			<cfelse>
				<cffile action="Append" 
					file="#variables.register_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			</cfif>
		</cfloop>
	</cfif>	
	
	
	<cftry>
		<cfquery name="GetPlayers" datasource="#attributes.source#">
			SELECT
				(ID+#variables.maxPlayerID#) AS newID, 
				Long AS LongCol, 
				medium AS mediumCol, 
				short AS shortCol, 
				notes
			FROM
				Player
		</cfquery>	
		<cfcatch type="database">
			<cfscript>
			// if fails, set to 0
			variables.playerexists = 0;
			</cfscript>
		</cfcatch>
	</cftry>
	<cfif variables.playerexists EQ 1 AND getplayers.recordcount GT 0>
		<cfset variables.playerhasdata = 1>
		<cfset textoutput = ''>
		<cfset variables.table_name = "player">
		<cfset variables.player_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>

		<cfif FileExists(#variables.player_file_name#)>
			<cffile action="DELETE" file="#variables.player_file_name#">
		</cfif>
		
		<cfloop query="getPlayers">
			<cfset newnotes = Replace(notes,'"','\"','ALL')>
			<cfset textoutput = '"#newID#","#longCol#","#mediumCol#","#shortCol#","#newnotes#","#LeagueCode#"'>
			<cfif NOT FileExists(#variables.player_file_name#)>
				<cffile action="WRITE" 
					file="#variables.player_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			<cfelse>
				<cffile action="Append" 
					file="#variables.player_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			</cfif>
		</cfloop>
	</cfif>	
	
	<cfquery name="GetOrds" datasource="#attributes.source#">
		SELECT
			(ID+#variables.maxOrdID#) AS newID, 
			Long AS LongCol, 
			medium AS mediumCol, 
			short AS shortCol, 
			notes
		FROM
			Ordinal
	</cfquery>		
	<cfif getords.recordcount GT 0>
		<cfset variables.ordhasdata = 1>
	</cfif>
	<cfset textoutput = ''>
	<cfset variables.table_name = "ordinal">
	<cfset variables.ordinal_file_name = #application.csvroot# & #application.DSN# & '_' & variables.table_name & '_' & leaguecode & '.csv'>
	
	<cfif FileExists(#variables.ordinal_file_name#)>
		<cffile action="DELETE" file="#variables.ordinal_file_name#">
	</cfif>
	
	<cfloop query="getOrds">
		<cfset newnotes = Replace(notes,'"','\"','ALL')>
		<cfset textoutput = '"#newID#","#longCol#","#mediumCol#","#shortCol#","#newnotes#","#LeagueCode#"'>
		<cfif NOT FileExists(#variables.ordinal_file_name#)>
			<cffile action="WRITE" 
				file="#variables.ordinal_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.ordinal_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>

	<!--- end of extraction routines --->
	
	<cftransaction>
	<!--- for the imports only --->
	
	<cfif variables.sponexists EQ 1 AND variables.sponhasdata EQ 1>

			<cfquery name="insertspons" datasource="#application.DSN#">
	
				load data infile '#variables.sponsor_file_name#'
				INTO table sponsor
				fields terminated by ','
				optionally enclosed by '"'
				lines terminated by '\r\n'
	
			</cfquery>

	</cfif>
			
	<cfif variables.refhasdata EQ 1>
		<cfquery name="insertrefs" datasource="#application.DSN#">
	
			load data infile '#variables.referee_file_name#'
			INTO table referee
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
	
		</cfquery>		

	</cfif>
	
	<cfif variables.kohasdata EQ 1>
		
		<cfquery name="insertKO" datasource="#application.DSN#">
			
			load data infile '#variables.koround_file_name#'
			INTO table koround 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
	
		</cfquery>
	
	</cfif>
	
	<cfif variables.commexists EQ 1 AND variables.commhasdata EQ 1>
	
		<cfquery name="insertcomm" datasource="#application.DSN#">
	
			load data infile '#variables.committee_file_name#'
			INTO table committee 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'	

		</cfquery>
		
	</cfif>
	
	<cfquery name="SetFKOff" datasource="#application.DSN#">
		SET FOREIGN_KEY_CHECKS=0
	</cfquery>
	
	<cfif variables.maxMatchNoID IS 0>
		<!--- only once per league  from the HERTS03 database --->
		<cfloop query="GetMatchNos">
			<cfquery name="InsertMatchNos" datasource="#application.DSN#">
				INSERT INTO MatchNo
					(ID, LongCol)
				VALUES 
					(#ID#, '#Long#')
			</cfquery>
		</cfloop>
	</cfif>
	
	<!--- insert, adding the current max(divID), also used above, to the current ID --->
	<cfif variables.consthasdata EQ 1>
	
		<cfquery name="insertconst" datasource="#application.DSN#">
	
			load data infile '#variables.constitution_file_name#'
			INTO table constitution 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
		
		</cfquery>
	
	</cfif>
	
	<cfif variables.divhasdata EQ 1>

		<cfquery name="insertdivs" datasource="#application.DSN#">
			
			load data infile '#variables.division_file_name#'
			INTO table division
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
	
		</cfquery>	

	</cfif>

	<cfif variables.teamhasdata EQ 1>
		<cfquery name="insertteams" datasource="#application.DSN#">
		
			load data infile '#variables.team_file_name#'
			INTO table team 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'

		</cfquery>
	</cfif>
	
	<cfif variables.regexists EQ 1 AND variables.reghasdata EQ 1>
	
		<cfquery name="insertregs" datasource="#application.DSN#">
			load data infile '#variables.register_file_name#'
			INTO table register 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'

		</cfquery>

	</cfif>
	
	<cfif variables.playerexists EQ 1 AND variables.playerhasdata EQ 1>
	
		<cfquery name="insertplayers" datasource="#application.DSN#">
			
			load data infile '#variables.player_file_name#'
			INTO table player 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'

		</cfquery>

	</cfif>
	
	<cfif variables.ordhasdata EQ 1>
	
		<cfquery name="insertords" datasource="#application.DSN#">
		
			load data infile '#variables.ordinal_file_name#'
			INTO table ordinal 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
	
		</cfquery>
	
	</cfif>
	<!--- equivalent years only --->
	<cfif application.year EQ application.newyear>

		<cfif variables.newsexists EQ 1 AND variables.newshasdata EQ 1>
			<cfquery name="insertnews" datasource="#application.DSN#">
	
				load data infile '#variables.newsitem_file_name#'
				INTO table newsitem
				fields terminated by ','
				optionally enclosed by '"'
				lines terminated by '\r\n'
		
			</cfquery>
		</cfif>

		<cfif variables.fixhasdata EQ 1>
			<cfquery name="insertfix" datasource="#application.DSN#">
			
				load data infile '#variables.fixture_file_name#'
				INTO table fixture 
				fields terminated by ','
				optionally enclosed by '"'
				lines terminated by '\r\n'
	
			</cfquery>
		</cfif>
		
		<cfif variables.reportexists EQ 1 AND variables.rephasdata EQ 1>
			
			<cfquery name="insertreps" datasource="#application.DSN#">
				load data infile '#variables.matchreport_file_name#'
				INTO table matchreport 
				fields terminated by ','
				optionally enclosed by '"'
				lines terminated by '\r\n'
	
			</cfquery>

		</cfif>
		
		<cfif variables.appexists EQ 1 AND variables.apphasdata EQ 1>
		
			<cfquery name="insertapps" datasource="#application.DSN#">
		
				load data infile '#variables.appearance_file_name#'
				INTO table appearance 
				fields terminated by ','
				optionally enclosed by '"'
				lines terminated by '\r\n'
	
			</cfquery>
		
		</cfif>
		
		<cfif variables.susexists EQ 1 AND variables.sushasdata EQ 1>
		
			<cfquery name="insertsus" datasource="#application.DSN#">
			
				load data infile '#variables.suspension_file_name#'
				INTO table suspension 
				fields terminated by ','
				optionally enclosed by '"'
				lines terminated by '\r\n'
	
			</cfquery>
		
		</cfif>
		
	</cfif><!--- end equivalent year import specials --->
	
	<cfquery name="SetFKOn" datasource="#application.DSN#">
		SET FOREIGN_KEY_CHECKS=1
	</cfquery>

	</cftransaction>
	
	<cfset NewLeagueCode = LeagueCode & RIGHT(application.newyear,2)>
	
	<cfif application.newyear NEQ application.year>
		<!--- 
		copy data into new row only if 03->04 
		otherwise, the record should already exist 
		and should be updated for defaultIDs like divisionID 
		The suffix is being left as a 2-digit figure. This will
		allow limited testing of ZMAST without having to convert
		all the suffixes to four-digit (which will be needed before
		going live with all-MySQL
		--->
				
		<cfquery name="addZmast" datasource="ZMAST">
			INSERT INTO leagueinfo 
				(SELECT '' AS ID,
				countieslist, namesort, leaguename, 
				'#NewLeagueCode#' AS defaultleaguecode, badgejpeg,
				websitelink, pwd, matchdayno, defaultdivisionid+#variables.maxDivID#,
				leaguetblcalcmethod, defaultyouthleague,
				'#application.newseasonname#' AS seasonname,
				'#application.newseasonstartdate#' AS seasonstartdate,
				'#application.newseasonenddate#' AS seasonenddate,
				1 AS defaultplayerregister, 1 AS defaultmatchreport,
				1 AS defaultteamlist, defaultnationalsystem,
				1 AS defaultsuspension, 0 AS defaultrulesandfines,
				0 AS defaultsmsservice, 9999 AS teamcodestartno,
				0 AS defaulthandbook, 1 AS defaultcommittee,
				1 AS defaultsponsor, refmarksoutofhundred, 
				0 as smsseednumber 
			FROM leagueinfo 
			WHERE defaultleaguecode = '#attributes.source#')
		</cfquery>
		<cfscript>variables.ZMASTcount = variables.ZMASTcount+1;</cfscript>	

	<cfelse>
		<cfquery name="updateZmastLeagueinfo" datasource="ZMAST">
			UPDATE leagueinfo 
			SET defaultdivisionid = defaultdivisionid+#variables.maxDivID#,
				defaultLeagueCode = '#leaguecode##application.newyear#',
				defaultplayerregister = 1,
				defaultmatchreport = 1,
				defaultteamlist = 1,
				defaultsuspension = 1,
				defaulthandbook = 0,
				defaultSMSService = 0,
				defaultRulesandFines = 0,
				teamcodestartno = 9999,
				defaultcommittee = 1,
				defaultsponsor = 1,
				SMSseednumber = 0
			WHERE defaultleaguecode = '#attributes.source#'
		</cfquery>	
		
		<!--- set the league code in past registrations to the new one --->
		<cfquery name="updateZmastRegistration" datasource="ZMAST">
			UPDATE Registration 
			SET LeagueCode = '#leaguecode##application.newyear#'
			WHERE leaguecode = '#attributes.source#'
		</cfquery>		
		
		<!--- set the league code in past counts to the new one --->
		<cfquery name="updatePagecounter" datasource="fmpagecount">
			UPDATE pagecounter
			SET CounterLeagueCode = '#leaguecode##application.newyear#'
			WHERE CounterLeagueCode = '#attributes.source#'
		</cfquery>
			
	</cfif>
	
</cfif>
</cfsilent>
<!--- finito! - go to next one in loop --->
