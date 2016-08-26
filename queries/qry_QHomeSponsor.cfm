<!--- called by inclHomeSponsorIcon --->

<CFQUERY name="QHomeSponsor" dbtype="query">
	SELECT
		ID as HomeSponsorID,
		Button as HomeSponsorButton
	FROM
		QSponsorInfo
	WHERE
		TID = <cfqueryparam value = #HomeTeamID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND OID = <cfqueryparam value = #HomeOrdinalID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
