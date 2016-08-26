<!--- Called by CommitteeDetailsXLS.cfm --->

<CFQUERY NAME="QCommitteeMailout1" datasource="#request.DSN#">
	SELECT

		(SELECT Namesort FROM `zmast`.`leagueinfo` WHERE LeagueCodePrefix = LeagueCode
		      AND  LeagueCodeYear= #LeagueCodeYear# ) as LeagueName,
		LeagueCode,
		longCol as Position,
		CASE
		WHEN LENGTH(TRIM(Title)) = 0 AND LENGTH(TRIM(Forename)) = 0 AND LENGTH(TRIM(Surname)) = 0
		THEN MediumCol
		ELSE CONCAT(Title, " ", Forename, " ", Surname)
		END
		as MemberName,
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
		(SELECT SQL_NO_CACHE CounterValue FROM `FMPageCount`.`pagecounter` WHERE CounterLeagueCode = CONCAT(LeagueCode,2010)) as PageRequests

	FROM
		committee
	WHERE
		NoMailOut = 0
	ORDER BY
		PageRequests desc, LeagueCode, shortCol
</CFQUERY>	
