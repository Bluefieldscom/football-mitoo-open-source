<!--- called by InclCheckOfficials.cfm --->

<CFQUERY NAME="QCheckReferee" datasource="#request.DSN#">
	SELECT
		CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN LongCol
		ELSE CONCAT(Forename, " ", Surname)
		END
		as RName ,
		Notes as RNotes
	FROM
		referee 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #Form.RefereeID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
