<!--- called by News.cfm  - get rid of any GUEST teams, 'League' or 'Withdrawn' teams from lk_constitution 
<cfset ThisYearsID = "#Right(url.LeagueCode,4)#id"> <!--- e.g. "2010id" --->
<cfloop index="ListElement" list = "#url.inlist#"> 
	<cfinclude template="queries/upd_lk_constitution.cfm">	
</cfloop>
<cflocation url="News.cfm?LeagueCode=#LeagueCode#" addtoken="no">
--->
<!---
update zmast.lk_constitution set 2009id=NULL where 2009id IN 
(select id from fm2009.constitution where teamid in (select id  from fm2009.team where shortcol = 'guest'));
--->