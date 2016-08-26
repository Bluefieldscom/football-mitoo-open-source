<!--- called by RefreshLeagueTable.cfm --->
<cfset DateTimeNow = "#DateFormat(Now(),'YYYY-MM-DD')# #TimeFormat(Now(),'HH:MM')#">
<cfquery name="CreateUmbrellaView" datasource="zmast" >
	CREATE OR REPLACE VIEW umbrella AS
	SELECT
			CASE
			WHEN o.LongCol IS NULL THEN t.LongCol
			ELSE CONCAT(t.LongCol, ' ', o.LongCol)
			END
			as club_name,
			CASE
			WHEN o.LongCol IS NULL THEN ''
			ELSE o.LongCol
			END
			as ordinal_name,
			d.longcol as CompetitionName,
			d.mediumcol as CompSortSeq,
			t.LeagueCode as LeagueCode,
			z.NameSort,
			z.LeagueName,
			t.ID as fmTeamID,
			o.ID as fmOrdinalID,
			c.id as fmConstitutionID,
			d.id as fmDivisionID,
			z.leaguecodeyear,
			'#DateTimeNow#' as VDateTimeStamp
		FROM 
			`fm2012`.`constitution` c,
			`fm2012`.`division` d,
			`fm2012`.`team` t,
			`fm2012`.`ordinal` o,
			`zmast`.`leagueinfo` z 
		WHERE 
			z.leaguecodeyear = 2012 
			AND z.leaguecodeprefix=c.leaguecode
			AND c.teamid = t.id
			AND c.ordinalid = o.id
			AND c.divisionid = d.id
			AND t.ID NOT IN (SELECT ID FROM `fm2012`.`team` WHERE LeagueCode = t.LeagueCode AND longcol LIKE '%winners%')
			AND t.ID NOT IN (SELECT ID FROM `fm2012`.`team` WHERE LeagueCode = t.LeagueCode AND longcol LIKE '%WITHDRAWN%')
			AND t.ID NOT IN (SELECT ID FROM `fm2012`.`team` WHERE LeagueCode = t.LeagueCode AND shortcol='GUEST') 
			AND z.CountiesList NOT LIKE '%TEST%' 
	UNION ALL
	SELECT
			CASE
			WHEN o.LongCol IS NULL THEN t.LongCol
			ELSE CONCAT(t.LongCol, ' ', o.LongCol)
			END
			as club_name,
			CASE
			WHEN o.LongCol IS NULL THEN ''
			ELSE o.LongCol
			END
			as ordinal_name,
			d.longcol as CompetitionName,
			d.mediumcol as CompSortSeq,
			t.LeagueCode as LeagueCode,
			z.NameSort,
			z.LeagueName,
			t.ID as fmTeamID,
			o.ID as fmOrdinalID,
			c.id as fmConstitutionID,
			d.id as fmDivisionID,
			z.leaguecodeyear,
			'#DateTimeNow#' as VDateTimeStamp
		FROM 
			`fm2011`.`constitution` c,
			`fm2011`.`division` d,
			`fm2011`.`team` t,
			`fm2011`.`ordinal` o,
			`zmast`.`leagueinfo` z 
		WHERE 
			z.leaguecodeyear = 2011 
			AND z.leaguecodeprefix=c.leaguecode
			AND c.teamid = t.id
			AND c.ordinalid = o.id
			AND c.divisionid = d.id
			AND t.ID NOT IN (SELECT ID FROM `fm2011`.`team` WHERE LeagueCode = t.LeagueCode AND longcol LIKE '%winners%')
			AND t.ID NOT IN (SELECT ID FROM `fm2011`.`team` WHERE LeagueCode = t.LeagueCode AND longcol LIKE '%WITHDRAWN%')
			AND t.ID NOT IN (SELECT ID FROM `fm2011`.`team` WHERE LeagueCode = t.LeagueCode AND shortcol='GUEST') 
			AND z.CountiesList NOT LIKE '%TEST%' 
		ORDER BY
			club_name, LeagueCode,CompSortSeq,leaguecodeyear;
</cfquery>
 