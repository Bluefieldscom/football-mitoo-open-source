<!--- Insert flag fields: --->

<cfquery datasource="#application.DSN#">
	ALTER TABLE fixture
		ADD COLUMN `HomeGoalsNull` tinyint(1) NOT NULL default '0',
		ADD COLUMN `AwayGoalsNull` tinyint(1) NOT NULL default '0',
		ADD COLUMN `RefereeMarksHNull` tinyint(1) NOT NULL default '0',
		ADD COLUMN `RefereeMarksANull` tinyint(1) NOT NULL default '0',
		ADD COLUMN `AsstRef1MarksNull` tinyint(1) NOT NULL default '0',         
		ADD COLUMN `AsstRef2MarksNull` tinyint(1) NOT NULL default '0',
		ADD COLUMN `HomeSportsmanshipMarksNull` tinyint(1) NOT NULL default '0',
		ADD COLUMN `AwaySportsmanshipMarksNull` tinyint(1) NOT NULL default '0'
</cfquery>

<cfquery datasource="#application.DSN#">
	ALTER TABLE suspension
		ADD COLUMN `FirstdayNull` tinyint(1) NOT NULL default '0',
		ADD COLUMN `LastDayNull` tinyint(1) NOT NULL default '0'
</cfquery>