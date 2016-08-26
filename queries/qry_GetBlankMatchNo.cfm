<!--- called by InclConstit02.cfm --->

<CFQUERY NAME="GetBlankMatchNo" datasource="#request.DSN#">
	SELECT
		ID
	FROM
		matchno as MatchNo
	WHERE
		LongCol IS NULL
</CFQUERY>
