<!--- called by AsstRefsRanking.cfm --->

<CFQUERY NAME="QAsstRefsRank" datasource="#request.DSN#">
		SELECT
			IF(r.ParentCounty='',"&nbsp;",r.ParentCounty) as ParentCounty,
			IF(r.Level=0,"&nbsp;",r.Level) as RefsLevel,
			r.ID as AsstRefsID,
			CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
			THEN r.LongCol
			ELSE CONCAT(r.Forename, " ", r.Surname)
			END
			as AsstRefsName ,
			r.Surname as Surname,
			r.Forename as Forename,
			r.Shortcol as SortSeq,
			COALESCE(SUM(f.AsstRef1Marks),0) as Marks,
			COALESCE(SUM(f.AsstRef1MarksH),0) as MarksH,
			COALESCE(SUM(f.AsstRef1MarksA),0) as MarksA,
			COUNT(f.AsstRef1Marks) as MarkedGames,
			COUNT(f.AsstRef1MarksH) as MarkedGamesH,
			COUNT(f.AsstRef1MarksA) as MarkedGamesA
		FROM
			fixture AS f,
			referee AS r
		WHERE
			r.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND r.ID = f.AsstRef1ID
		GROUP BY
			f.AsstRef1ID, r.longcol, r.mediumcol, r.shortcol, r.ID
		HAVING
			MarkedGames + MarkedGamesH + MarkedGamesA > 0
		UNION ALL
		SELECT
			IF(r.ParentCounty='',"&nbsp;",r.ParentCounty) as ParentCounty,
			IF(r.Level=0,"&nbsp;",r.Level) as RefsLevel,
			r.ID as AsstRefsID,
			CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
			THEN r.LongCol
			ELSE CONCAT(r.Forename, " ", r.Surname)
			END
			as AsstRefsName ,
			r.Surname as Surname,
			r.Forename as Forename,
			r.Shortcol as SortSeq,
			COALESCE(SUM(f.AsstRef2Marks),0) as Marks,
			COALESCE(SUM(f.AsstRef2MarksH),0) as MarksH,
			COALESCE(SUM(f.AsstRef2MarksA),0) as MarksA,
			COUNT(f.AsstRef2Marks) as MarkedGames,
			COUNT(f.AsstRef2MarksH) as MarkedGamesH,
			COUNT(f.AsstRef2MarksA) as MarkedGamesA
		FROM
			fixture AS f,
			referee AS r
		WHERE
			r.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND r.ID = f.AsstRef2ID
		GROUP BY
			f.AsstRef2ID, r.longcol, r.mediumcol, r.shortcol, r.ID
		HAVING
			MarkedGames + MarkedGamesH + MarkedGamesA > 0
</CFQUERY>

<CFQUERY NAME="QAsstRefsRanking" dbtype="query">
	SELECT
		ParentCounty,
		RefsLevel,
		AsstRefsID,
		AsstRefsName,
		Surname,
		Forename,
		<!--- SUM(Marks) as TMarks, --->
		SUM(MarkedGames) + SUM(MarkedGamesH) + SUM(MarkedGamesA) as TGames,
		(SUM(Marks) + SUM(MarksH) + SUM(MarksA)) / (SUM(MarkedGames) + SUM(MarkedGamesH) + SUM(MarkedGamesA)) as TAverage
	FROM
		QAsstRefsRank
	WHERE	
		AsstRefsName NOT LIKE '%(WITHDRAWN)%'
	GROUP BY
		AsstRefsID, Surname, Forename, AsstRefsName,ParentCounty,RefsLevel
	ORDER BY
		 TAverage DESC, SortSeq
</cfquery>