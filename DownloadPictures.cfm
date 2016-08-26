<cfparam name="LeagueName" default="">
<cfparam name="SeasonName" default=""> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><cfoutput>Download Pictures</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<cfinclude template="InclLeagueInfo.cfm">
</head>

<body>

<!---  
                                                               ****************
                                                               *  Pictures    *
                                                               ****************
--->
	<cfinclude template="queries/qry_QPictures.cfm">
	<table width="80%" border="0" align="center" cellpadding="10" cellspacing="2">
		<tr>
			<td bgcolor="white">
				<cfif BadgeJpeg IS "blank">
				<cfelse>
				<cfoutput>
				<center>
				<span class="pix16brand">
				<IMG border="0" src="LeagueBadges/#BadgeJpeg#.jpg">
				<br>
				#LeagueName#
				</span>
				</center>
				</cfoutput>
				</cfif>
			</td>
		</tr>
		<cfif QPictures.RecordCount IS 0 >
			<tr>
				<td height="200" bgcolor="White"><center><span class="pix13bold">There are no pictures available</span></center></td>
			</tr>
		<cfelse>
			<cfoutput query="QPictures" group="GroupName">
					<tr align="left">
						<td class="bg_contrast">
						<span class="pix16brand">#GroupName#</span>
						</td>
					</tr>
			
				<cfoutput>
					<tr align="center">
						<td height="40" bgcolor="White">
						<img src="fmstuff/jpg/#LeagueCodePrefix#/#URLEncodedFormat(Filename)#.jpg">
						<br><br>
						<span class="pix10bold">#Description#</span>
						</td>
						<!---<a href="SeePhoto.cfm?LeagueCode=#LeagueCode#&Extension=jpg&LeagueCodePrefix=&Filename=#URLEncodedFormat(Filename)#&Description=#URLEncodedFormat(Description)#" target="#LeagueCode#Photos"><span class="pix13bold">#Description#</span></a></td>--->
					</tr>
				</cfoutput>
			</cfoutput>
		</cfif>
	</table>
	<table><tr><td height="100" bgcolor="White"></td></tr></table>	

