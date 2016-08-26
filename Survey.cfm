<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<head>
	<title>Quickie football.mitoo survey</title>
<style type="text/css">
<!--
	td { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; }
	td.pix10 { font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; font-weight:normal; }
-->
</style>
</head>

<cfparam name="LeagueCode" default="xxxxx">

<body>
<FORM name="Survey" id="Survey" ACTION="Survey2.cfm" METHOD="POST" >
<cfoutput>
<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="#LeagueCode#">
</cfoutput>

<div style="border: 1px solid; width:350px;">
<table width="350" border="0" cellspacing="0" cellpadding="10" bgcolor="silver">
	<tr>
		<td colspan=2 align="center" class="pix10"><img src="fmtiny.jpg" alt="*"><p>Please help us to improve this website<BR>by answering a few quick questions</p></td>
	</tr>
	<tr>
		<td valign="top" align="left">
			I am
		</td>
		<td align="left">
			<input name="gender" type="radio" checked value="m">male &nbsp;&nbsp;<input name="gender" type="radio" value="f">female
		</td>
	</tr>
	<tr>
		<td valign="top" align="left">
			age group
		</td>
		<td align="left">
				<input name="agegroup" type="radio" value=1>under 15<BR>
				<input name="agegroup" type="radio" value=2>15 to 20<BR>
				<input name="agegroup" type="radio" value=3 checked>21 to 30<BR>
				<input name="agegroup" type="radio" value=4>31 to 50<BR>
				<input name="agegroup" type="radio" value=5>51 +
		</td>
	</tr>
	<!---
	<tr>
		<td valign="top" align="left">
			I am ....
		</td>
		<td align="left">
				<input name="marriedstatus" type="radio" value="s" checked>single
				<input name="marriedstatus" type="radio" value="m">married
				<input name="marriedstatus" type="radio" value="o">other
			 
		</td>
	</tr>
	--->
	<tr>
		<td valign="top" align="left">I am active as a</td>
		<td align="left">
			<input name="active" type="checkbox" value="p" checked><!-- player -->
        player<br>
        	<input name="active" type="checkbox" value="s"><!-- supporter -->
        supporter<br>
        	<input name="active" type="checkbox" value="c"><!-- coach -->
        coach<br>
        	<input name="active" type="checkbox" value="m"><!-- manager -->
        team manager<br>
        	<input name="active" type="checkbox" value="a"><!-- admin -->
        club administrator<br>
        	<input name="active" type="checkbox" value="r"><!-- ref -->
        referee<br>
			<input name="active" type="checkbox" value="n"><!-- none of the above -->
		none of the above
		</td>		
	</tr>
	<tr>
		<td></td>
		<td class="pix10">please tick all that apply above</td>
	</tr>
	
	<tr>
		<td valign="top" align="left">
				I am a parent
		</td>
		<td align="left">
				<input name="parent" type="radio" value="Y">yes &nbsp;&nbsp;&nbsp;<input name="parent" type="radio" value="N" checked>no<br>
				<br>
				number of children <input name="numberofchildren" type="text" value="0" size="5" maxlength="1">
		</td>
	</tr>
	<tr>
		<td valign="top" align="left">
				I live
		</td>
		<td align="left">
				<input name="reside" type="radio" value=1>inside the M25<BR>
				<input name="reside" type="radio" value=2>outside the M25<BR>
				<input name="reside" type="radio" value=3 checked>outside the UK
		</td>
	</tr>
	<tr>
		<td align="center" colspan=2 class="pix10">
			<p><span style="color:blue;">Thank you.</span></p><p>When you have completed your answers</p>
			<INPUT NAME="Operation" TYPE="submit" VALUE="Please click here">
		</td>
	</tr>
	<tr>
		<td align="center" colspan=2 class="pix10">
			<p>otherwise</p>
			<INPUT NAME="Operation" TYPE="submit" VALUE="cancel">
		</td>
	</tr>

</table>
</div>
</FORM>

</body>
