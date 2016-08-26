<!--- Called by InclLookUpCommittee.cfm --->

<CFQUERY NAME="QCommittee" datasource="#request.DSN#">
	SELECT 
		LongCol,
		CASE
		WHEN LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN MediumCol
		ELSE CONCAT(Title, " ", Forename, " ", Surname)
		END
		as MemberName ,
		ShortCol,
		Notes,
		Title,
		Surname,
		Forename,
		EmailAddress1,
		EmailAddress2,
		HomeTel,
		WorkTel,
		MobileTel,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		PostCode,
		ShowHideEmailAddress1,
		ShowHideEmailAddress2,
		ShowHideHomeTel,
		ShowHideWorkTel,
		ShowHideMobileTel,
		ShowHideAddress,
		NoMailout,
		CCEmailAddress1,
		CCEmailAddress2
	FROM
		committee as Committee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #URL.ID#
</CFQUERY>
