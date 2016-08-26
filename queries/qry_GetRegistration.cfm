<!--- called from RegisterPlayer.cfm --->

<CFQUERY NAME="GetRegistration" datasource="#request.DSN#">
	SELECT
		r.ID as RID,
		r.TeamID as TeamID,
		r.FirstDay,
		r.LastDay,
		r.RegType,
		r.PlayerID as PlayerID,
		p.Surname, p.Forename,
		p.ShortCol as RegNo,
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			p.AddressLine1,
			p.AddressLine2,
			p.AddressLine3,
			p.Postcode,
		</cfif>
		p.Notes
		
	FROM
		register AS r, 
		player AS p
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
			cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND r.ID = <cfqueryparam value = #RI# 
			cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND p.ID = r.PlayerID
</CFQUERY>
