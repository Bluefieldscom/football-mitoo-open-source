<!--- called by GatherTeamsUnderClubProcess2.cfm --->

<cfquery name="QUmbrella" datasource="zmast">
	SELECT 
		t.longcol as teamname,
		CASE
			WHEN ci.clubname is null
			THEN ''
			ELSE ci.clubname
			END
			as umbrella_clubname , 
		CASE
			WHEN ci.id is null
			THEN ''
			ELSE ci.id
			END
			as cid , 
		CASE
			WHEN ci.location is null
			THEN ''
			ELSE ci.location
			END
			as location, 
		li.namesort as league,
		li.countieslist as countieslist,
		t.LeagueCode as LgCode,
		t.ID as fmTeamID,
		li.id as LIID01,
		(SELECT id from zmast.leagueinfo where id=ti.leagueinfoid AND leaguecodeyear=#form.Year# AND leaguecodeprefix=t.LeagueCode) as LIID02
	FROM 
		fm#form.Year#.team t LEFT OUTER JOIN zmast.teaminfo ti ON t.id = ti.fmteamid
		LEFT OUTER JOIN zmast.leagueinfo li ON t.leaguecode=li.leaguecodeprefix  
		LEFT OUTER JOIN zmast.clubinfo ci ON (ti.ClubInfoID = ci.ID AND ti.leagueinfoid=li.id)
	WHERE 
		li.leaguecodeyear=#form.Year#
		AND	left(longcol,#Len(Trim(form.ClubNamePrefix))#)='#form.ClubNamePrefix#'  
		AND t.id NOT IN (SELECT id FROM fm#form.Year#.team WHERE (LEFT(Notes,7) = 'NoScore' OR ShortCol = 'GUEST') )
		AND countieslist NOT LIKE '%TEST%'
	ORDER BY
		t.longcol,ci.location

</cfquery>

