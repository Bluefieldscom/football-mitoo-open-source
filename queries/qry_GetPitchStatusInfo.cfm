<!--- called by InclPitchAvailable01.cfm --->

<CFQUERY NAME="GetPitchStatusInfo" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol
	FROM
		pitchstatus
	ORDER BY
		LongCol
</CFQUERY>

