<!--- called by ListChoose.cfm --->

<CFQUERY NAME="GetTInfo" dbtype="query">
	SELECT
		TeamID,
		OrdinalID,
		TeamOrdinalDescription
	FROM
		QTeamOrdinal
	ORDER BY
		TeamOrdinalDescription
</CFQUERY>



