<!--- called by PlayerTeamDetailsXLS.cfm, PlayerTeamDetails2XLS.cfm, RegisteredList1.cfm and RegisteredList2.cfm --->

<CFQUERY NAME="QThisClubsRegisteredPlayers" datasource="#request.DSN#">
	SELECT
		p.ID as PlayerID,
		LENGTH(CONCAT(p.Surname,p.Forename)) as NameLength,
		p.Surname,
		p.Forename,
		p.MediumCol as PlayerDOB ,
		p.ShortCol as PlayerRegNo ,
		p.Notes as PlayerNotes ,
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			p.AddressLine1, p.AddressLine2, p.AddressLine3, p.Postcode, p.Email1, p.FAN,
		</cfif>
		r.ID as RegistrationID,
		r.FirstDay as FirstDayOfRegistration,
		r.LastDay as LastDayOfRegistration,
		r.RegType,
		s.FirstDay as FirstDayOfSuspension, 
		s.LastDay as LastDayOfSuspension,
		s.NumberOfMatches,
		CURRENT_DATE BETWEEN 
			CASE
			WHEN r.FirstDay IS NULL
			THEN '1900-01-01'
			ELSE r.FirstDay
			END
	 	AND 
			CASE
			WHEN r.LastDay IS NULL
			THEN '2999-12-31'
			ELSE r.LastDay
			END 
		as CurrentRegistration,
		(CURRENT_DATE NOT BETWEEN 
			CASE
			WHEN r.FirstDay IS NULL
			THEN '1900-01-01'
			ELSE r.FirstDay
			END
	 	AND 
			CASE
			WHEN r.LastDay IS NULL
			THEN '2999-12-31'
			ELSE r.LastDay
			END)
		AND (CURRENT_DATE >
			CASE
			WHEN r.FirstDay IS NULL
			THEN '1900-01-01'
			ELSE r.FirstDay
			END)
		as ExpiredRegistration
		
	FROM
		(player AS p LEFT OUTER JOIN register AS r 
			ON p.ID = r.PlayerID) 
			LEFT OUTER JOIN suspension AS s 
				ON s.PlayerID = p.ID
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.TeamID = <cfqueryparam value = #TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
	<!---
						
	AND
	CURRENT_DATE BETWEEN 
		CASE
		WHEN r.FirstDay IS NULL
		THEN '1900-01-01'
		ELSE r.FirstDay
		END
	 AND 
		CASE
		WHEN r.LastDay IS NULL
		THEN '2999-12-31'
		ELSE r.LastDay
		END
	--->
			AND p.ID = r.PlayerID
	ORDER BY

	<cfif SortSeq IS "Name">
		Surname, Forename
	<cfelseif SortSeq IS "RegNo">
		PlayerRegNo
	<cfelseif SortSeq IS "DoB">
		PlayerDOB, Surname, Forename
	<cfelseif SortSeq IS "Age">
		PlayerDOB DESC, Surname, Forename
	<cfelseif SortSeq IS "RegType">
		RegType, Surname, Forename
	<cfelseif SortSeq IS "FirstDay">
		FirstDayOfRegistration, Surname, Forename
	<cfelseif SortSeq IS "LastDay">
		LastDayOfRegistration, Surname, Forename		
	</cfif>
	, RegistrationID, FirstDayOfSuspension
</CFQUERY>



