<!--- called by InclPitchAvailable01.cfm --->

<CFQUERY NAME="GetPitchNoInfo" datasource="#request.DSN#">
	SELECT
		ID,
		LongCol
	FROM
		pitchno
	ORDER BY
		LongCol
</CFQUERY>

