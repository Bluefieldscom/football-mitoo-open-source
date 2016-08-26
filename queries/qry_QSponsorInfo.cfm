<!--- called by inclLeagueInfo.cfm --->

<CFQUERY name="QSponsorInfo" datasource="#request.DSN#">
	SELECT
		ID,
		DID,
		TID,
		OID,
		Button,
		TeamHTML,
		SponsorsHTML,
		SponsorsName
	FROM
		sponsor
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
</CFQUERY>
