<!--- called by MatchCard.cfm --->

<cfif NOT RIGHT(request.dsn,4) GE 2012>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>


<cftry>

<cfquery name="UpdtFixture1" datasource="#request.DSN#" >
UPDATE
	fixture
SET
	<cfif HomeGoals IS "">
		HomeGoals = NULL,
	<cfelse>
		HomeGoals = <cfqueryparam value = #Form.HomeGoals# cfsqltype="CF_SQL_SMALLINT" maxlength="5">,
	</cfif>
	<cfif AwayGoals IS "">
		AwayGoals = NULL,
	<cfelse>
		AwayGoals = <cfqueryparam value = #Form.AwayGoals# cfsqltype="CF_SQL_SMALLINT" maxlength="5">,
	</cfif>
	<cfif AsstRef1Marks IS "">
		AsstRef1Marks = NULL,
	<cfelse>
		AsstRef1Marks = <cfqueryparam value = #Form.AsstRef1Marks# cfsqltype="CF_SQL_SMALLINT" maxlength="5">,
	</cfif>
	<cfif AsstRef2Marks IS "">
		AsstRef2Marks = NULL,
	<cfelse>
		AsstRef2Marks = <cfqueryparam value = #Form.AsstRef2Marks# cfsqltype="CF_SQL_SMALLINT" maxlength="5">,
	</cfif>
	<cfif ClubsCanInputSportsmanshipMarks IS 0>
		<cfif HomeSportsmanshipMarks IS "">
			HomeSportsmanshipMarks = NULL,
		<cfelse>
			HomeSportsmanshipMarks = <cfqueryparam value = #Form.HomeSportsmanshipMarks# cfsqltype="CF_SQL_SMALLINT" maxlength="5">,
		</cfif>
		<cfif AwaySportsmanshipMarks IS "">
			AwaySportsmanshipMarks = NULL,
		<cfelse>
			AwaySportsmanshipMarks = <cfqueryparam value = #Form.AwaySportsmanshipMarks# cfsqltype="CF_SQL_SMALLINT" maxlength="5">,
		</cfif>
	</cfif>
	<cfif Trim(form.RefMatchCardAnswers) IS "">
		RefMatchCardAnswers = NULL,
	<cfelse>
		RefMatchCardAnswers  =  '#form.RefMatchCardAnswers#',
	</cfif>
	RefMatchCardProblems = #ThisRefMatchCardProblems#
WHERE 
	LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #form.FID#	cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>


	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="appearance"><cfabort>
	</cfcatch>
</cftry>