<!--- Called by LUList.cfm --->

<CFQUERY NAME="CommitteeList" datasource="#request.DSN#">
	SELECT 
		ID ,
		LongCol,
		MediumCol,
		ShortCol,
		Notes,
		EmailAddress1,
		EmailAddress2,
		Title,
		Surname,
		Forename,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		PostCode,
		HomeTel,
		WorkTel,
		MobileTel
				
	FROM
		committee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND LongCol IS NOT NULL
	ORDER BY
		 ShortCol, LongCol
</CFQUERY>
