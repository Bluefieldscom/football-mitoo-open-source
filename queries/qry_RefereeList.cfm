<!--- Called by LUList.cfm, RefereeDetailsXLS.cfm --->

<CFQUERY NAME="RefereeList" datasource="#request.DSN#">
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
		ParentCounty,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		PostCode,
		HomeTel,
		WorkTel,
		MobileTel		
	FROM
		referee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol IS NOT NULL
	ORDER BY
		 ShortCol, LongCol, Surname, Forename
</CFQUERY>
