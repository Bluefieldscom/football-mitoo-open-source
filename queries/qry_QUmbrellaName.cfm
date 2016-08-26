<!--- called by GatherTeamsUnderClubProcess2.cfm --->

<cfquery name="QUmbrellaName" datasource="zmast" >
	SELECT
		ID,
		ClubName,
		Location
	FROM
		clubinfo
	WHERE
		ID = <cfqueryparam value = #url.ClubInfoID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
