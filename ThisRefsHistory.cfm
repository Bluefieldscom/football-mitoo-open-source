<link href="fmstyle.css" rel="stylesheet" type="text/css">
<table border="0" align="center" cellpadding="5" cellspacing="5">
<tr>
<cfset ThisID = url.HID >
<cfinclude template="queries/qry_ThisRefsHist.cfm" >
<cfinclude template="queries/qry_ThisRefsHistory.cfm" >
<td valign="top">
<table border="1" cellpadding="2" cellspacing="1">
<cfoutput><tr><td colspan="4" align="center"><span class="pix13boldnavy">#QThisRefsHistory.TeamName#</span></td></tr></cfoutput>
<cfoutput query="QThisRefsHistory" >
<cfif url.MD IS DateFormat(fixturedate, 'YYYY-MM-DD') >
	<cfset thisclass="pix10boldnavy">
<cfelse>
	<cfset thisclass="pix10">
</cfif>
<cfif url.RID IS RID >
	<cfset thisbgcolor="##FFFF80">
<cfelse>
	<cfset thisbgcolor="white">
</cfif>

<tr bgcolor="#thisbgcolor#">

<td><span class="#thisclass#">#venue#</span></td>
<td><span class="#thisclass#">#DateFormat(fixturedate, 'DD MMM')#</span></td>
<td><span class="#thisclass#">#CompCode#</span></td>
<td><span class="#thisclass#"><cfif RefsName IS ''>&nbsp;<cfelse>#RefsName#</cfif></span></td>
</tr>
</cfoutput>
</table>
</td>
<cfset ThisID = url.AID >
<cfinclude template="queries/qry_ThisRefsHist.cfm" >
<cfinclude template="queries/qry_ThisRefsHistory.cfm" >
<td valign="top">
<table border="1" cellpadding="2" cellspacing="1">
<cfoutput><tr><td colspan="4" align="center"><span class="pix13boldnavy">#QThisRefsHistory.TeamName#</span></td></tr></cfoutput>
<cfoutput query="QThisRefsHistory" >
<cfif url.MD IS DateFormat(fixturedate, 'YYYY-MM-DD') >
	<cfset thisclass="pix10boldnavy">
<cfelse>
	<cfset thisclass="pix10">
</cfif>
<cfif url.RID IS RID >
	<cfset thisbgcolor="##FFFF80">
<cfelse>
	<cfset thisbgcolor="white">
</cfif>

<tr bgcolor="#thisbgcolor#">

<td><span class="#thisclass#">#venue#</span></td>
<td><span class="#thisclass#">#DateFormat(fixturedate, 'DD MMM')#</span></td>
<td><span class="#thisclass#">#CompCode#</span></td>
<td><span class="#thisclass#"><cfif RefsName IS ''>&nbsp;<cfelse>#RefsName#</cfif></span></td>
</tr>
</cfoutput>
</table>
</td>

</tr>
</table>
