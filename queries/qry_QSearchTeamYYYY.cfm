<!--- caled by inclFindOtherTeams --->
<cfquery name="QSearchTeam" datasource="#request.DSN#">
	SELECT
		t.ID as fmTeamID,
		t.LongCol as ClubName,
		z.ID as LeagueInfoID,
		z.CountiesList as CountiesList,
		z.Namesort as LeagueName,
		z.SeasonName as Season
	FROM 
		fm#YYYY#.team t,
		zmast.leagueinfo z 
	WHERE 
		t.longcol LIKE '%#ThisToken#%'
		AND z.LeagueCodeYear = '#YYYY#'
		AND z.CountiesList NOT LIKE '%TEST%'
		AND t.ID NOT IN (SELECT ID FROM fm#YYYY#.team WHERE LeagueCode = t.LeagueCode AND Notes LIKE '%NOSCORE%') 
		AND t.ID NOT IN (SELECT ID FROM fm#YYYY#.team WHERE LeagueCode = t.LeagueCode AND ShortCol = 'GUEST')
		AND z.LeagueCodePrefix=t.leaguecode
	ORDER BY
		t.longcol, LeagueName;
</cfquery>
