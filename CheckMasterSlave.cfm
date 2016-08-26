<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>Check Slave</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
	<CFQUERY NAME="CheckSlave" datasource="fmpagecount">
		SELECT 
			p.CounterLeagueCode,
			p.CounterValue,
			p.LastHit,
			l.namesort
		FROM 
			`fmpagecount`.`pagecounter` p,
			`zmast`.`leagueinfo` l
		WHERE
			p.CounterLeagueCode = l.DefaultLeagueCode
		ORDER BY
			p.LastHit DESC
		LIMIT 0, 15
	</CFQUERY>
<table border="1" align="center" cellpadding="4" cellspacing="0">
		<tr>
			<td><span class="pix13bold">League Name</span></td>
			<td><span class="pix13bold">League Code</span></td>
			<td><span class="pix13bold">Counter</span></td>
			<td><span class="pix13bold">Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Time</span></td>
		</tr> 

	<cfoutput query="CheckSlave">
		<tr>
			<td><span class="pix13">#namesort#</span></td>
			<td><span class="pix13">#CounterLeagueCode#</span></td>
			<td align="right"><span class="pix13">#NumberFormat(CounterValue, '9,999,999,999') #</span></td>
			<td><span class="pix13">#DateFormat(LastHit, 'DD MMM')#&nbsp;&nbsp;&nbsp;&nbsp;#TimeFormat(LastHit, 'long')#</span></td>
		</tr> 
	</cfoutput>	
</table>	
	
</body>
</html>
