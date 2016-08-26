<!--- called by RegListPDF.cfm--->

<CFQUERY NAME="QRegistDPDF" datasource="#request.DSN#">
	SELECT
		p.Surname,
		p.Forename ,
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			p.AddressLine1, p.AddressLine2, p.AddressLine3, p.Postcode, p.Email1,
		</cfif>
		
		p.MediumCol as PlayerDOB ,
		p.ShortCol as PlayerRegNo ,
		p.notes as PlayerNotes ,
		t.LongCol as ClubName , 
		r.ID as RID ,
		r.PlayerID as RPID ,
		r.TeamID as RTID
	FROM
		register AS r, 
		player AS p, 
		team AS t
	WHERE
		t.LeagueCode = <cfqueryparam value = '#request.filter#'	cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND	r.TeamID = <cfqueryparam value = #TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND	r.PlayerID=p.ID 
		AND r.TeamID=t.ID
	ORDER BY
		Surname, Forename
</CFQUERY>

