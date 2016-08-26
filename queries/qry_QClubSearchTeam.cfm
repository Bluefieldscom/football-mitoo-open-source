<!--- called from SearchClubForm.cfm --->

<cfquery name="QSearchTeam" datasource="#request.DSN#">
	SELECT
		t.longcol as ClubName,
		t.shortcol,
		t.LeagueCode as ThisLeagueCode,
		t.ID as fmTeamID,
		z.NameSort as LeagueName
	FROM 
		`#request.DSN#`.`team` t,
		`zmast`.`leagueinfo` z 
	WHERE 
		t.longcol LIKE '%#TRIM(srchstring)#%'
		AND right(z.defaultleaguecode,4)='#right(request.DSN,4)#'
		AND t.ID NOT IN (SELECT ID FROM `#request.DSN#`.`team` WHERE LeagueCode = t.LeagueCode AND Notes LIKE '%NOSCORE%') 
		AND z.CountiesList NOT LIKE '%TEST%'
		AND Left(z.defaultleaguecode, length(z.defaultleaguecode)-4)=t.leaguecode
	ORDER BY
		t.longcol, t.shortcol, LeagueName;
</cfquery>
