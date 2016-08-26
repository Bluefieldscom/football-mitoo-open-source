<!--- called by inclAwaySponsorIcon --->

<CFQUERY name="QAwaySponsor" dbtype="query">
	SELECT
		ID as AwaySponsorID,
		Button as AwaySponsorButton
	FROM
		QSponsorInfo
	WHERE
		TID = <cfqueryparam value = #AwayTeamID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OID = <cfqueryparam value = #AwayOrdinalID# 
					cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
