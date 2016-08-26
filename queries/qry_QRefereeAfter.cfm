<!--- called by Action.cfm --->
<cfquery name="QRefereeAfter" datasource="#request.DSN#" >
	SELECT 
		longcol,
		mediumcol,
		shortcol,
		notes, 
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
		AND ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
