<!--- called by RefsHist.cfm  --->

<CFQUERY NAME="QReferee" datasource="#request.DSN#">
	SELECT
		CONCAT(
		CASE WHEN LENGTH(TRIM(AddressLine1)) > 0 THEN CONCAT(AddressLine1,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(AddressLine2)) > 0 THEN CONCAT(AddressLine2,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(AddressLine3)) > 0 THEN CONCAT(AddressLine3,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(PostCode)) > 0 THEN CONCAT(PostCode,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(HomeTel)) > 0 THEN CONCAT("Home: ",HomeTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(WorkTel)) > 0 THEN CONCAT("Work: ",WorkTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(MobileTel)) > 0 THEN CONCAT("Mobile: ",MobileTel,"<br />") ELSE "" END
		) 
		as RefDetails,
	
		CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN LongCol
		ELSE CONCAT(Forename, " ", Surname)
		END
		as RefsName ,
		Notes as RefsNotes,
		PromotionCandidate,
		Restrictions,
		Level,
		EmailAddress1,
		EmailAddress2,
		PostCode
	FROM
		referee 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #RI# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>