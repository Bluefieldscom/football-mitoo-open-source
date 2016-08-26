<!--- called from TeamList.cfm --->

<cfquery NAME="QPlayersWhoDidNotPlay" datasource="#request.DSN#">
SELECT
	p.ID as PlayerID ,
	CASE
		WHEN p.Surname = '' THEN 'MISSING SURNAME' 
		ELSE p.Surname
	END
	as PlayerSurname,
	CASE
		WHEN p.Forename = '' THEN 'MISSING FORENAME' 
		ELSE p.Forename
	END
	as PlayerForename,
	p.MediumCol as PlayerDOB ,
	p.ShortCol as PlayerRegNo ,
	CASE
		WHEN (Length(Trim(p.Notes)) = 0 OR p.Notes IS NULL)  THEN ' ' 
		ELSE TRIM(p.Notes)
	END
	as PlayerNotes
FROM
	fixture AS f, 
	player AS p, 
	register AS r, 
	constitution AS c, 
	team AS t
WHERE
	c.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
 	AND f.ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	AND 
	f.FixtureDate BETWEEN 
		CASE
		WHEN r.FirstDay IS NULL
		THEN '1900-01-01'
		ELSE r.FirstDay
		END
	 AND 
		CASE
		WHEN r.LastDay IS NULL
		THEN '2999-12-31'
		ELSE r.LastDay
		END
		
	<cfif IsDate(CutOffDate)>
		<cfif YearBandNo IS 3  > <!--- three years allowed --->
			AND	
				CASE
				WHEN p.MediumCol IS NULL
				THEN 1
				ELSE p.MediumCol BETWEEN '#DateFormat(DateAdd("d", 1, CutOffDate),"YYYY-MM-DD")#' AND '#DateFormat(DateAdd("yyyy", 3, CutOffDate),"YYYY-MM-DD")#'
				END
		<cfelseif YearBandNo IS 2  > <!--- two years allowed --->
			AND	
				CASE
				WHEN p.MediumCol IS NULL
				THEN 1
				ELSE p.MediumCol BETWEEN '#DateFormat(DateAdd("d", 1, CutOffDate),"YYYY-MM-DD")#' AND '#DateFormat(DateAdd("yyyy", 2, CutOffDate),"YYYY-MM-DD")#'
				END
		<cfelse> <!---  default only one year allowed --->
			AND	
				CASE
				WHEN p.MediumCol IS NULL
				THEN 1
				ELSE p.MediumCol BETWEEN '#DateFormat(DateAdd("d", 1, CutOffDate),"YYYY-MM-DD")#' AND '#DateFormat(DateAdd("yyyy", 1, CutOffDate),"YYYY-MM-DD")#'
				END
		</cfif>
	</cfif>
	AND
	<cfif HA IS "H">
		f.HomeID = c.ID
	<cfelse>
		f.AwayID = c.ID
	</cfif> 
	AND
	<cfif QPlayersWhoPlayed.RecordCount GT 0>
		p.ID NOT IN (#PlayerIDList#) AND
	</cfif>
 	c.TeamID = t.ID 
	AND t.ID = r.TeamID 
	AND r.PlayerID = p.ID
UNION <!--- this is for "Own Goal" --->
SELECT
	p.ID as PlayerID ,
	'        OG' as PlayerSurname, <!--- this is how get it to sort into first position , use spaces --->
	'        OG' as PlayerForename,
	p.MediumCol as PlayerDOB ,
	p.ShortCol as PlayerRegNo,
	' '	as PlayerNotes
FROM
	player p
WHERE
	p.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
 	AND p.ShortCol = 0 <!--- this is how we recognise "Own Goal" --->
 	<cfif QPlayersWhoPlayed.RecordCount GT 0>
		AND p.ID NOT IN (#PlayerIDList#)
	</cfif>
ORDER BY
  	PlayerSurname, PlayerForename
</cfquery>

