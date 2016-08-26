<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<LINK REL="stylesheet" type="text/css" href="fmstyle.css">

<title>Batch Update</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


</head>

<body>
	<cfif Trim(GetToken(Form.BatchInput, 1, CHR(10) )) IS "{#LeagueCode#NewPlayerRegistrations}">
		<cfinclude template="InclBatchUpdate1.cfm">
		<cfset ThisLeagueID = form.LeagueID >
	<cfelseif LEFT(Form.BatchInput, 19) IS "{BatchLoadFixtures}" >
		<cfinclude template="InclBatchLoadFixtures.cfm">
	<cfelseif LEFT(Form.BatchInput, 31) IS "TemporaryRegistrations Contract" >
		<cfinclude template="InclBatchTempRegContract.cfm">
	<cfelseif LEFT(Form.BatchInput, 35) IS "TemporaryRegistrations Non-Contract" >
		<cfinclude template="InclBatchTempRegNonContract.cfm">
	<cfelse>
		<cfinclude template="InclBatchUpdate2.cfm">
	</cfif>
</body>
</html>
