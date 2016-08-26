<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>

<cfif NOT StructKeyExists(url, "Prefix")>
	Prefix parameter missing from url<br><br><br>
	e.g. &prefix='abc'
	<cfabort>
</cfif>
<cfset ParamLength = #len(url.prefix)#>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfquery name="ClubUmbrellaReport1" datasource="zmast">
SELECT
	team.id as TID,
	longcol as TeamName,
	leaguecode,
	countieslist
FROM
	fm2008.team,
	zmast.leagueinfo
WHERE
	left(longcol,#ParamLength#)='#url.prefix#'
	AND shortcol<>'guest' 
	AND team.id NOT IN (SELECT t.id FROM fm2008.team t, zmast.clubinfo ci, zmast.leagueinfo li, zmast.teaminfo ti 
						WHERE li.leaguecodeyear='2008' AND t.id=ti.fmteamid AND ci.id=ti.clubinfoid AND li.id=ti.leagueinfoid)
	AND leagueinfo.leaguecodeyear='2008'
	AND leagueinfo.countieslist NOT LIKE '%TEST%'
	AND team.leaguecode=leagueinfo.leaguecodeprefix
ORDER BY
	longcol,leaguecode
</cfquery>
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="2">
<cfoutput query="ClubUmbrellaReport1">
	<tr>
		<td><span class="pix13"><a href="UpdateForm.cfm?TblName=Team&ID=#TID#&LeagueCode=#leaguecode#2008" target="_blank">#TID#</a></span></td>
		<td><span class="pix13">#TeamName#</span></td>
		<td><span class="pix13">#leaguecode#</span></td>
		<td><span class="pix10">#countieslist#</span></td>
	</tr>
</cfoutput>
</table>
