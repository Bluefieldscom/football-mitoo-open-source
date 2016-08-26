<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Untitled</title>
	<meta name="robots" content="noindex,nofollow">
</head>

<body>

<cfsetting showdebugoutput="Yes">

<cfquery name="testing123" datasource="FM2test">
	Select second_field from terrycheck
</cfquery>

<table>
	<cfoutput query="testing123">
		<tr><td>#second_field#</td></tr>
	</cfoutput>
</table>

</body>
</html>