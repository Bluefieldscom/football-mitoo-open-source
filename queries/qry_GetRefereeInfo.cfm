<!--- called by RefereeListForm.cfm --->
<cfquery name="GetRefereeInfo" datasource="#request.DSN#">
	SELECT
	CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN LongCol
		WHEN LENGTH(TRIM(Forename)) = 0
		THEN Surname
		ELSE CONCAT(Surname, ", ", Forename )
		END
		as RefsFullName,
	
		longcol, 
		mediumcol, 
		shortcol, 
		notes, 
		LeagueCode, 
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
		HomeTel, 
		WorkTel, 
		MobileTel
	FROM
		referee
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #RefereeID#
</cfquery>
