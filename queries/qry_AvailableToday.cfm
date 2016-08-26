<!--- called by MtchDay.cfm --->

<!--- get the availability of referees for a specified Match Date from the RefAvailable table --->
<cfquery name="AvailableToday" datasource="#request.DSN#">
	SELECT 
		ra.RefereeID,
		ra.Available,
		CASE
		WHEN ra.Notes IS NULL
		THEN " "
		ELSE TRIM(ra.Notes)
		END
		as AvailabilityNotes,
		CASE
		WHEN LENGTH(TRIM(r.Forename)) = 0 AND LENGTH(TRIM(r.Surname)) = 0
		THEN r.LongCol
		ELSE CONCAT(r.Surname, ", ", r.Forename )
		END
		as RefsName ,
		r.EmailAddress1,
		r.EmailAddress2,
		CONCAT(
		CASE WHEN LENGTH(TRIM(r.AddressLine1)) > 0 THEN CONCAT(r.AddressLine1,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine2)) > 0 THEN CONCAT(r.AddressLine2,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.AddressLine3)) > 0 THEN CONCAT(r.AddressLine3,", ") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.PostCode)) > 0 THEN CONCAT(r.PostCode,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.HomeTel)) > 0 THEN CONCAT("Home: ",r.HomeTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.WorkTel)) > 0 THEN CONCAT("Work: ",r.WorkTel,"<br />") ELSE "" END,
		CASE WHEN LENGTH(TRIM(r.MobileTel)) > 0 THEN CONCAT("Mobile: ",r.MobileTel,"<br />") ELSE "" END
		) as RefDetails,		
		r.PromotionCandidate,
		r.Restrictions,
		r.Level,
		r.Notes as RefNotes
	FROM
		refavailable ra,
		referee r
	WHERE
		ra.LeagueCode = <cfqueryparam value='#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ra.MatchDate = #CreateODBCDate(MDate)#
		AND ra.RefereeID = r.ID
	ORDER BY
		r.ShortCol, RefsName;
</cfquery>

