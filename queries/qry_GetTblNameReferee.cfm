<!--- called by qry_GetTblName.cfm --->

<CFQUERY NAME="GetTblName" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol,
		MediumCol,
		ShortCol,
		Notes,
		EmailAddress1,
		EmailAddress2,
		Level,
		PromotionCandidate,
		Restrictions,
		Surname, 
		Forename, 
		DateOfBirth, 
		FAN,
		ParentCounty, 
		AddressLine1,
		AddressLine2,
		AddressLine3, 
		PostCode, 
		ShowHideAddress,
		HomeTel, 
		WorkTel, 
		MobileTel ,
		CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN LongCol
		WHEN LENGTH(TRIM(Forename)) = 0
		THEN Surname
		ELSE CONCAT(Surname, ", ", Forename )
		END
		as RefsFullName,
		CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN LongCol
		ELSE CONCAT(LEFT(Forename,1), ". ", Surname)
		END
		as RefsName  
	FROM
		referee as Referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #URL.ID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
