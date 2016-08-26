<!--- called by InclConstit02.cfm --->

<CFQUERY NAME="GetMatchNo" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol
	FROM
		matchno
	ORDER BY
		LongCol
</CFQUERY>
