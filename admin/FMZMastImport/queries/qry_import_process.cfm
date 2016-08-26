<!--- 
qry_import_process.cfm 
Purpose:		Import all required data from ZMAST, ZMAST1,3 and 4
				on the same way that it is done for the main data -
				ie via CSV files
				
				The ZMAST tables are truncated prior to data entry
				in order to be sure we have the most up-to date information.
				
				The default league codes are left unchanged, to allow
				for testing of ZMAST-MySQL against the current Access databases
				prior to full roll-out

Created by:		Terry Riley
On:				14 July 2004
Calls:			nothing
Called by:  	index.cfm		
--->

<cfsilent>

	<cfscript>
		variables.LIHasData    		  = 0;
		variables.LoggedInhasdata     = 0;
		variables.LHhasdata           = 0;
		variables.UDhasdata           = 0;
		variables.LUhasdata           = 0;
		variables.Reghasdata          = 0;
		variables.CIhasdata           = 0;
	</cfscript>	

	<!--- 
	before we start, delete all data from ZMAST 
	with MyISAM tables, this appears also to reset auto_number
	--->
	<cfquery name="zapLeagueInfo" datasource="ZMASTX">
		TRUNCATE table leagueInfo
	</cfquery>
	<!--- removed <cfquery name="zapLogins" datasource="ZMAST">
		TRUNCATE table loggedinisno
	</cfquery> --->
	<cfquery name="zapLogHist" datasource="ZMASTX">
		TRUNCATE table loghistory
	</cfquery>
	<cfquery name="zapUsers" datasource="ZMASTX">
		TRUNCATE table Userdetail
	</cfquery>
	<cfquery name="zapLookup" datasource="ZMASTX">
		TRUNCATE table lookuptable
	</cfquery>
	<cfquery name="zapReg" datasource="ZMASTX">
		TRUNCATE table registration
	</cfquery>
	<cfquery name="zapcountyInf" datasource="ZMASTX">
		TRUNCATE table CountyInfo
	</cfquery>						
	
	<!--- retrieve 'old' data --->
	<cfquery name="GetLeagueInfo" datasource="ZMAST9">
		SELECT 
			'' AS ID,
			CountiesList,
			NameSort,
			LeagueName,
			DefaultLeagueCode,
			BadgeJpeg,
			Websitelink,
			Password,
			MatchDayNo,
			DefaultDivisionID,
			LeagueTblCalcMethod,
			DefaultYouthLeague,
			SeasonName,
			SeasonStartDate,
			SeasonEndDate,
			DefaultPlayerRegister,
			DefaultMatchReport,
			DefaultTeamList, 
			DefaultNationalSystem,
			DefaultSuspension,
			DefaultRulesAndFines,
			DefaultSMSService,
			TeamCodeStartNo,
			DefaultHandbook,
			DefaultCommittee,
			DefaultSponsor,
			RefMarksOutOfHundred,
			SMSSeedNumber
		FROM 
			LeagueInfo
	</cfquery>
	<cfif getleagueinfo.recordcount GT 0>
		<cfset variables.LIhasdata = 1>
	</cfif>

	<cfset textoutput = ''>

	<cfset variables.table_name = "leagueinfo">

	<cfset variables.leagueinfo_file_name = #application.csvroot# & 'ZMAST_' & variables.table_name & '.csv'>
	<!--- 
	first delete any existing file with this name 
	this prevents double-writing and causing 'duplicate key' errors 
	--->
	<cfif FileExists(#variables.leagueinfo_file_name#)>
		<cffile action="DELETE" file="#variables.leagueinfo_file_name#">
	</cfif>
	
	<cfloop query="getleagueinfo">
		<cfset textoutput = '"#ID#","#CountiesList#","#NameSort#","#LeagueName#","#DefaultLeagueCode#","#BadgeJpeg#","#Websitelink#","#Password#","#MatchDayNo#","#DefaultDivisionID#","#LeagueTblCalcMethod#","#DefaultYouthLeague#","#SeasonName#","#SeasonStartDate#","#SeasonEndDate#","#DefaultPlayerRegister#","#DefaultMatchReport#","#DefaultTeamList#","#DefaultNationalSystem#","#DefaultSuspension#","#DefaultRulesAndFines#","#DefaultSMSService#","#TeamCodeStartNo#","#DefaultHandbook#","#DefaultCommittee#","#DefaultSponsor#","#RefMarksOutOfHundred#","#SMSSeedNumber#"'>
		<cfif NOT FileExists(#variables.leagueinfo_file_name#)>
			<cffile action="WRITE" 
				file="#variables.leagueinfo_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.leagueinfo_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>

	<cfquery name="GetLogHistory" datasource="ZMAST9">
		SELECT 
			'' AS ID,
			DateTimeStamp, 
			LeagueCode, 
			UserName, 
			LoggedInOK,
			Passwd
		FROM
			LogHistory
	</cfquery>

	<cfif getloghistory.recordcount GT 0>
		<cfset variables.LHhasdata = 1>
		<cfset textoutput = ''>
		<cfset variables.table_name = "loghistory">
		<cfset variables.loghistory_file_name = #application.csvroot# & 'ZMAST_' & variables.table_name & '.csv'>
		
		<cfif FileExists(#variables.loghistory_file_name#)>
			<cffile action="DELETE" file="#variables.loghistory_file_name#">
		</cfif>
		<cfloop query="getloghistory">
			<cfset textoutput = '"#ID#","#DateTimeStamp#","#LeagueCode#","#Username#","#LoggedInOK#","#Passwd#"'>
			<cfif NOT FileExists(#variables.loghistory_file_name#)>
				<cffile action="WRITE" 
					file="#variables.loghistory_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			<cfelse>
				<cffile action="Append" 
					file="#variables.loghistory_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			</cfif>
		</cfloop>
	</cfif>		
	
	<cfquery name="GetUserDetail" datasource="ZMAST9">
		SELECT 
			'' AS ID,
			DateTimeStamp,
			EmailAddr
		FROM
			UserDetail
	</cfquery>

	<cfif getuserdetail.recordcount GT 0>
		<cfset variables.UDhasdata = 1>
		<cfset textoutput = ''>
		<cfset variables.table_name = "userdetail">
		<cfset variables.userdetail_file_name = #application.csvroot# & 'ZMAST_' & variables.table_name & '.csv'>
		
		<cfif FileExists(#variables.userdetail_file_name#)>
			<cffile action="DELETE" file="#variables.userdetail_file_name#">
		</cfif>
		<cfloop query="getuserdetail">
			<cfset textoutput = '"#ID#","#datetimestamp#","#emailaddr#"'>
			<cfif NOT FileExists(#variables.userdetail_file_name#)>
				<cffile action="WRITE" 
					file="#variables.userdetail_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			<cfelse>
				<cffile action="Append" 
					file="#variables.userdetail_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			</cfif>
		</cfloop>
	</cfif>	
	
	<cfquery name="GetLookup" datasource="ZMAST9">
		SELECT
			ID, Tablename
		FROM
			LookupTable
	</cfquery>	
	
	<cfif getlookup.recordcount GT 0>
		<cfset variables.LUhasdata = 1>
	</cfif>
	
	<cfset textoutput = ''>
	<cfset variables.table_name = "lookuptable">
	<cfset variables.lookuptable_file_name = #application.csvroot# & 'ZMAST_' & variables.table_name & '.csv'>

	<cfif FileExists(#variables.lookuptable_file_name#)>
		<cffile action="DELETE" file="#variables.lookuptable_file_name#">
	</cfif>

	<cfloop query="getlookup">
		<cfset textoutput = '"#ID#","#TableName#"'>
		<cfif NOT FileExists(#variables.lookuptable_file_name#)>
			<cffile action="WRITE" 
				file="#variables.lookuptable_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.lookuptable_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>
	
	<cfquery name="GetRegistration" datasource="ZMAST9">
		SELECT
			'' AS ID, 
			DateRegistered, 
			Name, 
			Email, 
			Info,
			LeagueCode
		FROM
			Registration
	</cfquery>

	<cfif GetRegistration.recordcount GT 0>
		<cfset variables.reghasdata = 1>
	</cfif>
	
	<cfset textoutput = ''>
	<cfset variables.table_name = "registration">
	<cfset variables.registration_file_name = #application.csvroot# & 'ZMAST_' & variables.table_name & '.csv'>

	<cfif FileExists(#variables.registration_file_name#)>
		<cffile action="DELETE" file="#variables.registration_file_name#">
	</cfif>

	<cfloop query="getregistration">
		<cfset newInfo = Replace(Info,'"','\"','ALL')>
		<cfset textoutput = '"#ID#","#DateRegistered#","#Name#","#Email#","#newInfo#","#LeagueCode#"'>
		<cfif NOT FileExists(#variables.registration_file_name#)>
			<cffile action="WRITE" 
				file="#variables.registration_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		<cfelse>
			<cffile action="Append" 
				file="#variables.registration_file_name#" 
				output="#textoutput#" 
				addnewline="Yes">
		</cfif>
	</cfloop>
		
	
	<cfquery name="GetCountyInfo" datasource="ZMAST9">
		SELECT 
			'' AS ID, 
			CountyCode, 
			CountyName
		FROM
			CountyInfo
	</cfquery>
		
	<cfif getcountyinfo.recordcount GT 0>
		<cfset variables.CIhasdata = 1>
		<cfset textoutput = ''>
		<cfset variables.table_name = "countyinfo">
		<cfset variables.countyinfo_file_name = #application.csvroot# & 'ZMAST_' & variables.table_name & '.csv'>
	
		<cfif FileExists(#variables.countyinfo_file_name#)>
			<cffile action="DELETE" file="#variables.countyinfo_file_name#">
		</cfif>
		<cfloop query="getcountyinfo">
			<cfset textoutput = '"#ID#","#CountyCode#","#CountyName#"'>
			<cfif NOT FileExists(#variables.countyinfo_file_name#)>
				<cffile action="WRITE" 
					file="#variables.countyinfo_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			<cfelse>
				<cffile action="Append" 
					file="#variables.countyinfo_file_name#" 
					output="#textoutput#" 
					addnewline="Yes">
			</cfif>
		</cfloop>
	</cfif>		

	<cftransaction>
	
	<cfif variables.LIhasdata EQ 1>

		<cfquery name="insertLI" datasource="ZMASTX">
	
			load data infile '#variables.leagueinfo_file_name#'
			INTO table leagueinfo
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'

		</cfquery>

	</cfif>
	
	<cfif variables.LHhasdata EQ 1>
		
		<cfquery name="insertLogHist" datasource="ZMASTX">
			
			load data infile '#variables.loghistory_file_name#'
			INTO table loghistory
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
	
		</cfquery>
	
	</cfif>
	
	<cfif variables.UDhasdata EQ 1>
	
		<cfquery name="insertUD" datasource="ZMASTX">
	
			load data infile '#variables.userdetail_file_name#'
			INTO table userdetail 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'	

		</cfquery>
		
	</cfif>
	
	<cfif variables.LUhasdata EQ 1>
	
		<cfquery name="insertlookup" datasource="ZMASTX">
	
			load data infile '#variables.lookuptable_file_name#'
			INTO table lookuptable 
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
		
		</cfquery>
	
	</cfif>
	
	<cfif variables.reghasdata EQ 1>

		<cfquery name="insertregn" datasource="ZMASTX">
			
			load data infile '#variables.registration_file_name#'
			INTO table registration
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
	
		</cfquery>	

	</cfif>

	<cfif variables.CIhasdata EQ 1>

		<cfquery name="insertCI" datasource="ZMASTX">
			
			load data infile '#variables.countyinfo_file_name#'
			INTO table countyinfo
			fields terminated by ','
			optionally enclosed by '"'
			lines terminated by '\r\n'
	
		</cfquery>	

	</cfif>	
	
	</cftransaction>

</cfsilent>
