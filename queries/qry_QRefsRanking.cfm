<!--- called by RefsRanking.cfm --->

<CFQUERY NAME="QRefsRanking" datasource="#request.DSN#">	
	SELECT
		r.ID as RefsID,
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Forename, " ", r.Surname)
		END
		as RefsName ,
		r.Surname,
		r.Forename,
		IF(r.ParentCounty='',"&nbsp;",r.ParentCounty) as ParentCounty,
		IF(r.Level=0,"&nbsp;",r.Level) as Level,
		r.mediumCol as RefsCode,
		r.shortCol,
		f.RefereeID,
		COALESCE(SUM(f.RefereeMarksH),0) + COALESCE(SUM(f.RefereeMarksA),0) as SumRefereeMarks,
		COUNT(f.RefereeMarksH) + COUNT(f.RefereeMarksA) as RefereeMarkedGames,
		(COALESCE(SUM(f.RefereeMarksH),0) + COALESCE(SUM(f.RefereeMarksA),0))/(COUNT(f.RefereeMarksH) + COUNT(f.RefereeMarksA)) as TAverage
	FROM
		fixture AS f,
		referee AS r
	WHERE
		r.LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		<cfif ThisLevel IS ""><cfelseif IsNumeric(ThisLevel)>AND r.Level = #ThisLevel#<cfelse></cfif>
		<cfif ThisPCounty IS "ALL"><cfelse>AND r.ParentCounty = '#ThisPCounty#'</cfif>
		AND r.ID = f.RefereeID
	GROUP BY
		RefereeID, RefsName, RefsCode, ShortCol, RefsID <!--- f.RefereeID, r.longCol, r.mediumCol, r.shortCol, r.ID --->
	HAVING
		SumRefereeMarks > 0
		AND RefereeMarkedGames > 0 <!--- COUNT(f.RefereeMarksH + f.RefereeMarksA) > 0 --->
	ORDER BY
		<!--- SUM(f.RefereeMarksH + f.RefereeMarksA) / COUNT(f.RefereeMarksH + f.RefereeMarksA) DESC, r.shortCol --->
		TAverage DESC, shortcol
</CFQUERY>
