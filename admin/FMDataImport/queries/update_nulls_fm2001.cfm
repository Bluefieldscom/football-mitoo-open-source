<!---
update_nulls_fmxxxx.cfm
Purpose:	loop through all tables in a database and replace empty fields with
			NULL, if that is how the table is configured
Created:	14 July 2004
By:			Terry Riley
Calls:		nothing
Called by:	qry_update_nulls.cfm
Passes:		nothing
Notes:		Can't find another, less awkward way to do this in view of the way
			that 'show tables' presents its data
--->
<cfquery name="gettables" datasource="fm2001">
	show tables
</cfquery>

<cfloop query="gettables">
	<cfset tablename = #tables_in_fm2001#>
	<cfquery name="getit" datasource="fm2001">
		explain #tablename#
	</cfquery>
	<cfloop query="getit">
		<cfif #getit.null# IS "YES">
			<cfquery name="changeit" datasource="fm2001">
				UPDATE #tablename#
				SET #getit.field# = NULL
				WHERE LENGTH(TRIM(#getit.field#)) = 0
			</cfquery>
		</cfif>
	</cfloop>
</cfloop>
<!--- this is for numeric fields in fixture table --->

<cfquery datasource="fm2001">
	UPDATE fixture
	SET AwayGoals = NULL WHERE AwayGoalsNull = 1
</cfquery>
<cfquery datasource="fm2001">
	UPDATE fixture
	SET HomeGoals = NULL WHERE HomeGoalsNull = 1
</cfquery>
<cfquery datasource="fm2001">
	UPDATE fixture
	SET RefereeMarksH = NULL WHERE RefereeMarksHNull = 1
</cfquery>
<cfquery datasource="fm2001">
	UPDATE fixture
	SET RefereeMarksA = NULL WHERE RefereeMarksANull = 1
</cfquery>
<cfquery datasource="fm2001">
	UPDATE fixture
	SET AsstRef1Marks = NULL WHERE AsstRef1MarksNull = 1
</cfquery>
<cfquery datasource="fm2001">
	UPDATE fixture
	SET AsstRef2Marks = NULL WHERE AsstRef2MarksNull = 1
</cfquery>
<cfquery datasource="fm2001">
	UPDATE fixture
	SET HomeSportsmanshipMarks = NULL WHERE HomeSportsmanshipMarksNull = 1
</cfquery>
<cfquery datasource="fm2001">
	UPDATE fixture
	SET AwaySportsmanshipMarks = NULL WHERE AwaySportsmanshipMarksNull = 1
</cfquery>

<cfquery datasource="fm2001">
	UPDATE suspension
	SET FirstDay = NULL WHERE FirstDayNull = 1
</cfquery>
<cfquery datasource="fm2001">
	UPDATE suspension
	SET LastDay = NULL WHERE LastDayNull = 1
</cfquery>


