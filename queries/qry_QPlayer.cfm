<!--- called by PlayersHist.cfm --->
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012>
	<CFQUERY NAME="QPlayer" datasource="#request.DSN#">
		SELECT
			Surname, 
			Forename, 
			Notes,
			AddressLine1,
			AddressLine2,
			AddressLine3,
			Postcode,
			Email1			
		FROM
			player
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #PI# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</CFQUERY>
<cfelse>
	<CFQUERY NAME="QPlayer" datasource="#request.DSN#">
		SELECT
			Surname, Forename, <!--- LongCol as PlayersName--->
			Notes
		FROM
			player
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' 
							cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = <cfqueryparam value = #PI# 
							cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</CFQUERY>
</cfif>