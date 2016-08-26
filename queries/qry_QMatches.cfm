<!--- called by Unsched.cfm --->
<!---
Present the user with a list of ALL the games still to be played for the specified
League and Division. Obviously, don't show him those games which have already
been made into fixtures - see "NOT IN" clause in SQL
For Cup matches (Knock Out competitions) don't show any fixtures involving
knocked out teams
--->

<CFQUERY NAME="QMatches" datasource="#request.DSN#"> 
SELECT
	<cfif PlayOne IS "Yes" >
		(SELECT COUNT(*) 
			FROM fixture AS f 
			WHERE f.HomeID = c1.ID 
			AND f.AwayID = c2.ID) AS HomeCount,
		(SELECT COUNT(*) 
			FROM fixture AS f 
			WHERE f.AwayID = c1.ID 
			AND f.HomeID = c2.ID) AS AwayCount,
	</cfif>
	<cfif PlayThree IS "Yes" >
		(SELECT COUNT(*) 
			FROM fixture AS f 
			WHERE f.HomeID = c1.ID 
			AND f.AwayID = c2.ID) AS HomeCount,
		(SELECT COUNT(*) 
			FROM fixture AS f 
			WHERE f.AwayID = c1.ID 
			AND f.HomeID = c2.ID) AS AwayCount,
	</cfif>
	<cfif PlayFour IS "Yes" >
		(SELECT COUNT(*) 
			FROM fixture AS f 
			WHERE f.HomeID = c1.ID 
			AND f.AwayID = c2.ID) AS HomeCount,
		(SELECT COUNT(*) 
			FROM fixture AS f 
			WHERE f.AwayID = c1.ID 
			AND f.HomeID = c2.ID) AS AwayCount,
	</cfif>
	c1.ID as HomeID,
	c2.ID as AwayID,
	t1.longcol as HomeTeam,
	t2.longcol as AwayTeam,
	t1.shortcol as HomeGuest,
	t2.shortcol as AwayGuest,
	t1.ID as HomeTeamID,
	t2.ID as AwayTeamID,
	ordinal1.ID as HomeOrdinalID,
	ordinal2.ID as AwayOrdinalID,
	ordinal1.longcol as HomeOrdinal,
	ordinal2.longcol as AwayOrdinal,
	LEFT(m1.longcol,3) as HomeMatchNo,
	LEFT(m2.longcol,3) as AwayMatchNo,
	CONCAT(cast(t1.ID as char), cast(ordinal1.ID as char)) as HomeTeamPlusOrdinal,
	CONCAT(cast(t2.ID as char), cast(ordinal2.ID as char)) as AwayTeamPlusOrdinal
FROM
	constitution AS c1,
	constitution AS c2,
	team AS t1,
	team AS t2,
	ordinal AS ordinal1,
	ordinal AS ordinal2,
	matchno AS m1,
	matchno AS m2
WHERE
	c1.LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c2.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND c1.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
	AND c2.DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	AND
		<cfif Find( "MatchNumbers", QKnockOut.Notes )>
			LEFT(m1.longcol,3) = LEFT(m2.longcol,3) AND
		</cfif>
		<cfif Find( "NoReplays", QKnockOut.Notes )>
			m1.longcol LIKE '%Home%' AND
		</cfif>
	t1.ID = c1.TeamID 
	AND ordinal1.id = c1.OrdinalID 
	AND m1.id = c1.ThisMatchNoID 
	AND t2.ID = c2.TeamID 
	AND ordinal2.id = c2.OrdinalID 
	AND m2.id = c2.ThisMatchNoID 
	AND NOT (c1.ID = c2.ID) 
	<cfif PlayOne IS "No" AND PlayThree IS "No" AND PlayFour IS "No">
		AND c1.ID NOT IN (SELECT fx.HomeID FROM fixture fx WHERE fx.HomeID = c1.ID AND fx.AwayID = c2.ID )
	</cfif>
	<!--- For Knock Out Competitions without MatchNumbers! --->
	<cfif KO IS "Yes" AND NOT Find( "IgnoreLosers", QKnockOut.Notes )>
		AND
		c1.ID IN (#NeverDefeatedList#) AND
		c2.ID IN (#NeverDefeatedList#)
	</cfif>
ORDER BY
	<cfif Find( "MatchNumbers", QKnockOut.Notes )>
		HomeMatchNo <!--- LEFT(m1.longcol,3) --->
	<cfelse>
		HomeTeam, HomeOrdinal, AwayTeam, AwayOrdinal <!--- t1.longcol, ordinal1.longcol, t2.longcol, ordinal2.longcol --->
	</cfif>
</CFQUERY>
