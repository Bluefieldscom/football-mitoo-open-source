<!--- called by InclInsrtPitchAvailable.cfm --->

<CFQUERY name="QCheckDuplicateHG" datasource="#request.DSN#">
	SELECT
		t.LongCol as TeamName,
		o.LongCol as OrdinalName,
		p.LongCol as PitchName
	FROM
		pitchavailable AS h,
		team AS t,
		ordinal AS o,
		pitchno AS p
	WHERE
		h.LeagueCode     = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND h.TeamID     = <cfqueryparam value = #Form.TeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND h.OrdinalID  = <cfqueryparam value = #Form.OrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND p.ID = <cfqueryparam value = #Form.PitchNoID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
		AND t.ID = h.TeamID 
		AND o.ID = h.OrdinalID 
		AND p.ID = h.PitchNoID
</CFQUERY>