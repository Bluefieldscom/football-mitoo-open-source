<!--- called by RegisteredPlayers.cfm, CheckPlayerDuplicateNoWarnings3.cfm --->
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012>
	<cfquery name="QCheckPDNW3" datasource="#request.DSN#" >
		SELECT 	
			pdnw.ID as WarningID, 
			pdnw.RegNo1, 
			pdnw.RegNo2, 
			p1.ID as PID1,
			p1.surname as Surname1,
			p1.forename as Forename1,
			p1.mediumcol as DoB1,
			p1.notes as Notes1,
			p1.AddressLine1 as AddressLine11,
			p1.AddressLine2 as AddressLine12,
			p1.AddressLine3 as AddressLine13,
			p1.Postcode as Postcode1,
			p1.Email1 as Email11,			
			p2.ID as PID2,
			p2.surname as Surname2,
			p2.forename as Forename2,
			p2.mediumcol as DoB2,
			p2.notes as Notes2,
			p2.AddressLine1 as AddressLine21,
			p2.AddressLine2 as AddressLine22,
			p2.AddressLine3 as AddressLine23,
			p2.Postcode as Postcode2,
			p2.Email1 as Email12			
		FROM 
			playerduplicatenowarnings pdnw,
			player p1,
			player p2
		WHERE
			 pdnw.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			 AND p1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			 AND p2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			 AND pdnw.Reason = 3
			 AND p1.shortcol = pdnw.RegNo1
			 AND p2.shortcol = pdnw.RegNo2
		ORDER BY p1.surname
	</cfquery>
<cfelse>
	<cfquery name="QCheckPDNW3" datasource="#request.DSN#" >
		SELECT 	
			pdnw.ID as WarningID, 
			pdnw.RegNo1, 
			pdnw.RegNo2, 
			p1.ID as PID1,
			p1.surname as Surname1,
			p1.forename as Forename1,
			p1.mediumcol as DoB1,
			p1.notes as Notes1,
			p2.ID as PID2,
			p2.surname as Surname2,
			p2.forename as Forename2,
			p2.mediumcol as DoB2,
			p2.notes as Notes2
		FROM 
			playerduplicatenowarnings pdnw,
			player p1,
			player p2
		WHERE
			 pdnw.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			 AND p1.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			 AND p2.LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			 AND pdnw.Reason = 3
			 AND p1.shortcol = pdnw.RegNo1
			 AND p2.shortcol = pdnw.RegNo2
		ORDER BY p1.surname
	</cfquery>
</cfif>