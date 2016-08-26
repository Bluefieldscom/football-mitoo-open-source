<!--- Called by ShowContacts.cfm, InclEmailHomeTeamIcon.cfm --->

<CFQUERY NAME="QCommittee" datasource="#request.DSN#">
	SELECT
		ID,
		longCol,
		CASE
		WHEN LENGTH(TRIM(Title)) = 0 AND LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN MediumCol
		ELSE CONCAT(Title, " ", Forename, " ", Surname)
		END
		as MemberName ,
		shortCol,
		notes,
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
		MobileTel,
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
		committee
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		shortCol
</CFQUERY>	
