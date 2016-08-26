<!--- called by RefAnalysis.cfm --->

<cfquery name="QFourthAnalyse" datasource="#request.DSN#" >
	SELECT
		r.ID as RefID,
		CASE
			WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
			THEN r.LongCol
			ELSE CONCAT(r.Forename, " ", r.Surname)
			END
			as RefsName,
		r.MediumCol,
		r.ShortCol,
		COUNT(r.ID) AS GamesDone
	FROM
		referee AS r,
		fixture AS f
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND f.FourthOfficialID = r.ID
	GROUP BY
		RefID, RefsName, ShortCol, MediumCol
	ORDER BY
		ShortCol, surname, forename
</cfquery>
