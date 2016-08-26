<!--- called by RegCheck.cfm --->

<cfquery name="QRegInsert" datasource="zmast" >
INSERT INTO	registration3
	( DateRegistered, 
	LeagueCode, 
	Forename, 
	Surname, 
	Email, 
	OtherComments, 
	TeamsInvolved, 
	RoleList, 
	Other,
	HowFoundOut, 
	HowLongUsing, 
	AgeRange ) 
	VALUES
	( #CreateODBCDateTime(Now())#,
	<cfqueryparam value = '#LeagueCode#' cfsqltype="CF_SQL_VARCHAR" maxlength="10">,
	'#Trim(form.Forename)#',
	'#Trim(form.Surname)#',
	'#ThisInputEmailAddr#',
	'#Trim(form.OtherComments)#',
	'#Trim(form.TeamsInvolved)#',
	'#form.RoleList#',
	'#Trim(form.Other)#',
	'#Trim(form.HowFoundOut)#',
	'#Trim(form.HowLongUsing)#',
	'#form.AgeRange#' );
</cfquery>