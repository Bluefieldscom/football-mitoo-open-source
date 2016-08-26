<!--- called by InclConstit02.cfm --->

<CFQUERY NAME="GetPointsAdjustment" datasource="#request.DSN#">
	SELECT
		PointsAdjustment
	FROM
		constitution
	WHERE
		ID = <cfqueryparam value = #url.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>
