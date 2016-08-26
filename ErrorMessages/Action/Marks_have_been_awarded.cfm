<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>Error Message</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
	<span class="pix10">
		<cfoutput>
		Referee Marks (Home) = #Form.RefereeMarksH#<br>
		Referee Marks (Away) = #Form.RefereeMarksA#<br>
		Asst. Ref. 1 Marks = #Form.AsstRef1Marks#<br>
		Asst. Ref. 2 Marks = #Form.AsstRef2Marks#<br>
		Home Sportsmanship Marks = #Form.HomeSportsmanshipMarks#<br>
		Away Sportsmanship Marks = #Form.AwaySportsmanshipMarks#<br><br>
		</cfoutput>
	</span>
	<span class="pix18boldred">
		You are not allowed to delete a fixture where marks have been awarded!<br>	
		If you really want to delete this fixture you must remove all the marks first. <br>
		Be warned that these marks will then be lost forever from the records of the officials and/or teams.<BR><BR>
	</span>
	<span class="pix18boldgreen">
		If you want to expunge all results for a particular team then contact us.<BR>
		This can be done easily and automatically by him.<BR>
		All results, referee and sportsmanship marks will be transferred to a Miscellaneous division.<BR>
		No data will be lost.<BR>
	</span>
	<span class="pix18boldred">
	<BR><BR>Press the Back button on your browser.....
	</span>
</body>
</html>
