<!--- Drop temporary columns: --->

<cfquery datasource="#application.DSN#">
	ALTER TABLE fixture
		DROP COLUMN `HomeGoalsNull`,
		DROP COLUMN `AwayGoalsNull`,
		DROP COLUMN `RefereeMarksHNull`,
		DROP COLUMN `RefereeMarksANull`,
		DROP COLUMN `AsstRef1MarksNull`,         
		DROP COLUMN `AsstRef2MarksNull`,
		DROP COLUMN `HomeSportsmanshipMarksNull`,
		DROP COLUMN `AwaySportsmanshipMarksNull`
</cfquery>

<cfquery datasource="#application.DSN#">
	ALTER TABLE suspension
		DROP COLUMN `FirstdayNull`,
		DROP COLUMN `LastDayNull`
</cfquery>