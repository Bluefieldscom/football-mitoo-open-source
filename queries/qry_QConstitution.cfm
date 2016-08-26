<!--- called by InclUpdtConstit.cfm --->

<CFQUERY name="QConstitution" datasource="#request.DSN#">
	SELECT
		ID ,
		DivisionID ,
		TeamID ,
		OrdinalID ,
		ThisMatchNoID ,
		NextMatchNoID
	FROM
		constitution
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #id# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</CFQUERY>

