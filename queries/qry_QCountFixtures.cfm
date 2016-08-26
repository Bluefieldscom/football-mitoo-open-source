<!--- called by FutureScheduledDates.cfm --->		
<cfquery name="QCountFixtures" datasource="#request.DSN#">
	SELECT 
		count(*) as cnt
	FROM
		fixture f
	WHERE 
		f.LeagueCode='#LeagueCodePrefix#'
</cfquery>
<cfquery name="QCountSundayFixtures" datasource="#request.DSN#">
	SELECT 
		count(*) as cnt
	FROM
		fixture f
	WHERE 
		f.LeagueCode='#LeagueCodePrefix#'
		AND DATE_FORMAT(fixturedate, '%w') = 0
</cfquery>
<cfquery name="QCountMondayFixtures" datasource="#request.DSN#">
	SELECT 
		count(*) as cnt
	FROM
		fixture f
	WHERE 
		f.LeagueCode='#LeagueCodePrefix#'
		AND DATE_FORMAT(fixturedate, '%w') = 1
</cfquery>
<cfquery name="QCountTuesdayFixtures" datasource="#request.DSN#">
	SELECT 
		count(*) as cnt
	FROM
		fixture f
	WHERE 
		f.LeagueCode='#LeagueCodePrefix#'
		AND DATE_FORMAT(fixturedate, '%w') = 2
</cfquery>
<cfquery name="QCountWednesdayFixtures" datasource="#request.DSN#">
	SELECT 
		count(*) as cnt
	FROM
		fixture f
	WHERE 
		f.LeagueCode='#LeagueCodePrefix#'
		AND DATE_FORMAT(fixturedate, '%w') = 3
</cfquery>
<cfquery name="QCountThursdayFixtures" datasource="#request.DSN#">
	SELECT 
		count(*) as cnt
	FROM
		fixture f
	WHERE 
		f.LeagueCode='#LeagueCodePrefix#'
		AND DATE_FORMAT(fixturedate, '%w') = 4
</cfquery>
<cfquery name="QCountFridayFixtures" datasource="#request.DSN#">
	SELECT 
		count(*) as cnt
	FROM
		fixture f
	WHERE 
		f.LeagueCode='#LeagueCodePrefix#'
		AND DATE_FORMAT(fixturedate, '%w') = 5
</cfquery>
<cfquery name="QCountSaturdayFixtures" datasource="#request.DSN#">
	SELECT 
		count(*) as cnt
	FROM
		fixture f
	WHERE 
		f.LeagueCode='#LeagueCodePrefix#'
		AND DATE_FORMAT(fixturedate, '%w') = 6
</cfquery>

<cfset CBSunday = "0">
<cfset CBMonday = "0">
<cfset CBTuesday = "0">
<cfset CBWednesday = "0">
<cfset CBThursday = "0">
<cfset CBFriday = "0">
<cfset CBSaturday = "0">

<cfset PercentageTarget = 15 >		
<cfif QCountFixtures.cnt GT 0>
	<cfif ((QCountSundayFixtures.cnt / QCountFixtures.cnt) * 100) GT #PercentageTarget# > <!--- more than PercentageTarget percent of fixtures are on Sunday --->
		<cfset CBSunday = "1">
	</cfif>
	<cfif ((QCountMondayFixtures.cnt / QCountFixtures.cnt) * 100) GT #PercentageTarget# > <!--- more than PercentageTarget percent of fixtures are on Monday --->
		<cfset CBMonday = "1">
	</cfif>
	<cfif ((QCountTuesdayFixtures.cnt / QCountFixtures.cnt) * 100) GT #PercentageTarget# > <!--- more than PercentageTarget percent of fixtures are on Tuesday --->
		<cfset CBTuesday = "1">
	</cfif>
	<cfif ((QCountWednesdayFixtures.cnt / QCountFixtures.cnt) * 100) GT #PercentageTarget# > <!--- more than PercentageTarget percent of fixtures are on Wednesday --->
		<cfset CBWednesday = "1">
	</cfif>
	<cfif ((QCountThursdayFixtures.cnt / QCountFixtures.cnt) * 100) GT #PercentageTarget# > <!--- more than PercentageTarget percent of fixtures are on Thursday --->
		<cfset CBThursday = "1">
	</cfif>
	<cfif ((QCountFridayFixtures.cnt / QCountFixtures.cnt) * 100) GT #PercentageTarget# > <!--- more than PercentageTarget percent of fixtures are on Friday --->
		<cfset CBFriday = "1">
	</cfif>
	<cfif ((QCountSaturdayFixtures.cnt / QCountFixtures.cnt) * 100) GT #PercentageTarget# > <!--- more than PercentageTarget percent of fixtures are on Saturday --->
		<cfset CBSaturday = "1">
	</cfif>
</cfif>

<!--- debug code 
<cfoutput>

#QCountFixtures.cnt#<br><br>
#QCountSundayFixtures.cnt#<br>
#QCountMondayFixtures.cnt#<br>
#QCountTuesdayFixtures.cnt#<br>
#QCountWednesdayFixtures.cnt#<br>
#QCountThursdayFixtures.cnt#<br>
#QCountFridayFixtures.cnt#<br>
#QCountSaturdayFixtures.cnt#<br><br>

#CBSunday#<br>
#CBMonday#<br>
#CBTuesday#<br>
#CBWednesday#<br>
#CBThursday#<br>
#CBFriday#<br>
#CBSaturday#<br>
</cfoutput>
<cfabort>
--->