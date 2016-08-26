<cfparam name="LeagueName" default="">
<cfparam name="SeasonName" default=""> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><cfoutput>Download Documents</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<cfinclude template="InclLeagueInfo.cfm">
</head>

<body>

<!---  
                                                               ****************
                                                               *  Documents   *
                                                               ****************
--->
	<cfinclude template="queries/qry_QDocuments.cfm">
	<table width="100%" border="0" class="bg_contrast">
		<tr>
			<td colspan="2"  bgcolor="white">
				<cfif BadgeJpeg IS "blank">
				<cfelse>
				<cfoutput>
				<center>
				<span class="pix16brand">
				<IMG border="0" src="LeagueBadges/#BadgeJpeg#.jpg">
				<br>
				#LeagueName#<br><br>Download Documents<br><br>
				</span>
				</center>
				</cfoutput>
				</cfif>
			</td>
		</tr>
	
		<cfif QDocuments.RecordCount IS 0 >
			<tr>
				<td height="200" bgcolor="White"><center><span class="pix16brand">There are no documents available for downloading</span></center></td>
			</tr>
		<cfelse>
			<cfoutput query="QDocuments" group="GroupName">
				<tr>
					<cfif Trim(GroupName) IS "">
						<td height="30" colspan="2"><span class="pix16brand">&nbsp;</span></td>
					<cfelse>
						<td colspan="2"><span class="pix16brand">#GroupName#</span></td>
					</cfif>
				</tr>
				<cfoutput >
					<tr>
						<td width="5%" height="25" align="center" bgcolor="White"><span class="pix13">.#Extension# </span></td>
						<td height="25" bgcolor="White"><a href="fmstuff/#Extension#/#LeagueCodePrefix#/#Filename#.#Extension#"><span class="pix13bold">#Description#</span></a></td>
					</tr>
				</cfoutput>
			</cfoutput>
		</cfif>
	</table>
	<br><br><br><br><br><br><br><br><br>

