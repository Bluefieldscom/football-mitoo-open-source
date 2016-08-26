<!--- called by qry_GetTblName.cfm --->

<CFQUERY NAME="GetTblName" datasource="#request.DSN#">
	SELECT
		ID,
		surname, forename,
		CONCAT(surname, ' ', forename) as LongCol,
		MediumCol,
		ShortCol,
		Notes,
		FAN
		<!--- applies to season 2012 onwards only --->
		<cfif RIGHT(request.dsn,4) GE 2012>
			,
			AddressLine1,
			AddressLine2,
			AddressLine3,
			PostCode,
			Email1
		</cfif>
	FROM
		player
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #URL.ID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
