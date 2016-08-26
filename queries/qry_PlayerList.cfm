<!--- Called by LUList.cfm, RefereeDetailsXLS.cfm --->

<CFQUERY NAME="PlayerList" datasource="#request.DSN#">
	SELECT 
		mediumCol, 
		shortCol, 
		notes, 
		FAN,
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			AddressLine1,
			AddressLine2,
			AddressLine3,
			PostCode,
			Email1,
		</cfif>
		surname, 
		forename
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ShortCol <> 0
	ORDER BY
		 Surname, Forename, shortcol
</CFQUERY>
