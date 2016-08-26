<!--- called by PlayerUnusedNos.cfm --->

<cfquery name="QRegistrationNumber" datasource="#request.DSN#" >
	SELECT
		ShortCol as RegistrationNumber
	FROM
		player 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND shortCol <> 0
	ORDER BY
		RegistrationNumber 
</cfquery>
