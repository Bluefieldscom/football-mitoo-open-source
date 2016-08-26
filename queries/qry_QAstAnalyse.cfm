<!--- called by RefAnalysis.cfm --->
<cfquery name="QAstAnalyse_1" datasource="#request.DSN#" >
	SELECT  
		r.ID as RefID ,
		CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
			THEN r.LongCol
			ELSE CONCAT(r.Forename, " ", r.Surname)
			END
			as RefsName,
		r.MediumCol,
		r.ShortCol,
		r.surname,
		r.forename
	FROM
		referee AS r,
		fixture AS f
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.LongCol IS NOT NULL
		AND f.AsstRef1ID = r.ID 
	UNION ALL
	SELECT 
		r.ID as RefID ,
		CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
			THEN r.LongCol
			ELSE CONCAT(r.Forename, " ", r.Surname)
			END
			as RefsName,
		r.MediumCol,
		r.ShortCol,
		r.surname,
		r.forename
	FROM
		referee AS r,
		fixture AS f
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.LongCol IS NOT NULL
		AND f.AsstRef2ID = r.ID		
	UNION ALL
	SELECT 
		r.ID as RefID ,
		CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
			THEN r.LongCol
			ELSE CONCAT(r.Forename, " ", r.Surname)
			END
			as RefsName,
		r.MediumCol,
		r.ShortCol,
		r.surname,
		r.forename 
	FROM
		referee AS r,
		fixture AS f
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.LongCol IS NULL
		AND f.AsstRef1ID = r.ID		
	UNION ALL
	SELECT 
		r.ID as RefID ,
		CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
			THEN r.LongCol
			ELSE CONCAT(r.Forename, " ", r.Surname)
			END
			as RefsName,
		r.MediumCol,
		r.ShortCol,
		r.surname,
		r.forename 
	FROM
		referee AS r,
		fixture AS f
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.LongCol IS NULL
		AND f.AsstRef2ID = r.ID		
</cfquery>

<cfquery name="QAstAnalyse" dbtype="query">
	SELECT 
		RefID,
		RefsName,
		MediumCol,
		ShortCol,
		surname,
		forename,
		COUNT(RefID) AS GamesDone
	FROM
		QAstAnalyse_1
	GROUP BY
		RefID, RefsName, MediumCol, ShortCol, surname, forename
	ORDER BY
		ShortCol, surname, forename
</cfquery>

