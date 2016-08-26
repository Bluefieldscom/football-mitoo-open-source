<!--- called by InclNewChunkPart2.cfm --->

<cfquery name="QSponsorStuff" dbtype="query">
	SELECT
		ID as SponsorID,
		Button as SponsorButton,
		SponsorsName
	FROM
		QSponsorInfo
	WHERE
		TID = <cfqueryparam value = #TeamID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND OID = <cfqueryparam value = #OrdinalID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
