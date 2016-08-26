<cfparam name="LeagueName" default="">
<cfparam name="SeasonName" default=""> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><cfoutput>News - #SeasonName# - #LeagueName#</cfoutput></title>
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">

</head>

<body>

<!---  
                                                               ****************
                                                               *  News Items  *
                                                               ****************
--->
<cfif ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cfinclude template="queries/qry_QNews_v1.cfm">
	<table width="100%" border="0">
		<tr>
			<td><center><span class="pix13bold"><cfoutput>#SeasonName#</cfoutput></span></center></td>
		</tr>
		<tr>
			<td><center><span class="pix24bold"><cfoutput>#LeagueName#</cfoutput></span></center></td>
		</tr>
		<tr>
			<td><span class="pix10"><cfoutput>#QNews.RecordCount# <cfif QNews.RecordCount IS "1">News Item<cfelse>News Items</cfif></cfoutput></span></td>
		</tr>
		<cfoutput query="QNews">
			<cfif ShortCol IS "HIDE">
			<tr>
				<td bgcolor="Black"><center><span class="pix10boldwhite">HIDDEN</span></center></td>
			</tr>
			</cfif>
			<tr>
				<td bgcolor="White"><span class="pix18bold">#LongCol#</span></td>
			</tr>
			<tr>
			<tr>
				<td align="LEFT" bgcolor="White">
					<span class="pix13">#Notes#</span><HR>
				</td>
			</tr>
		</cfoutput>
	</table>
<cfelse>
	<cfinclude template="queries/qry_QNews_v2.cfm">
	<table width="100%" border="0">
		<tr>
			<td><center><span class="pix13bold"><cfoutput>#SeasonName#</cfoutput></span></center></td>
		</tr>
		<tr>
			<td><center><span class="pix24bold"><cfoutput>#LeagueName#</cfoutput></span></center></td>
		</tr>

		<tr>
			<td><span class="pix10"><cfoutput>#QNews.RecordCount# <cfif QNews.RecordCount IS "1">News Item<cfelse>News Items</cfif></cfoutput></span></td>
		</tr>
		<cfoutput query="QNews">
			<tr>
				<td bgcolor="White"><span class="pix18bold">#LongCol#</span></td>
			</tr>
			<tr>
				<td align="LEFT" bgcolor="White">
					<span class="pix13">#Notes#</span><HR>
				</td>
			</tr>
		</cfoutput>
	</table>
</cfif>


