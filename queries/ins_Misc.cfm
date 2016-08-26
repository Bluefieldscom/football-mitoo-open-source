<!--- called by MoveToMisc.cfm --->

<cfquery name="InsertMiscDivision"  datasource="#request.DSN#" >
INSERT INTO	division
	( 
	longcol, 
	mediumcol, 
	shortcol, 
	notes, 
	LeagueCode
	)
	values
	( 
	'Miscellaneous', 
	'9999', 
	'Misc', 
	'', 
	'#LeagueCodePrefix#'
	)
</cfquery>
