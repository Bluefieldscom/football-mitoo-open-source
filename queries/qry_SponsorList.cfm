<!--- Called by LUList.cfm --->

<cfquery name="SponsorList" datasource="#request.DSN#" >
	SELECT
		ID,
		LastUpdated,
		Button,
		DID,
		TID,
		OID,
		SponsorsHTML,
		SponsorsName,
		Notes,
		TeamHTML
	FROM
		sponsor
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	ORDER BY
		ID
</cfquery>
