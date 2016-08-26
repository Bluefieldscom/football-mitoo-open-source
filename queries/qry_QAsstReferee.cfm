<!--- called by AsstRefsRanking.cfm --->

<CFQUERY NAME="QAsstReferee" datasource="#request.DSN#">
	SELECT
		CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN LongCol
		ELSE CONCAT(Forename, " ", Surname)
		END
		as RefsName,
		MediumCol as RefsCode
	FROM
		referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #RI# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
