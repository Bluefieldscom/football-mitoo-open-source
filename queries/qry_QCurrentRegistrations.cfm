<!--- called by CurrentRegistrationsXLS.cfm --->

<CFQUERY NAME="QCurrentRegistrations" datasource="#request.DSN#">
	SELECT
		p.ID as PlayerID,
		p.Surname,
		p.Forename,
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			p.AddressLine1, p.AddressLine2, p.AddressLine3, p.Postcode, p.Email1, p.FAN,
		</cfif>
		p.MediumCol as PlayerDOB ,
		p.ShortCol as PlayerRegNo ,
		p.Notes as PlayerNotes ,
		t.LongCol as ClubName,
		r.FirstDay,
		r.LastDay,
		r.RegType
	FROM
		register AS r, 
		player AS p, 
		team AS t
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	AND  (
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
		END )
		AND p.ID = r.PlayerID 
		AND t.ID = r.TeamID
	ORDER BY
		ClubName,Surname,Forename
</CFQUERY>
