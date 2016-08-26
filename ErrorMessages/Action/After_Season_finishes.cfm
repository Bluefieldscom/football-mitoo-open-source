<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>Error Message</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<cfoutput>
<span class="pix24boldred">
Season finishes #DateFormat(SeasonFinish, 'DDDD, DD MMMM YYYY')#<BR><BR>
Proposed Match Date is #DateFormat(MatchDate, 'DDDD, DD MMMM YYYY')#<BR><BR>
Not within season!
Press the Back button on your browser.....
</span>
<CFABORT>
</cfoutput>
</html>
