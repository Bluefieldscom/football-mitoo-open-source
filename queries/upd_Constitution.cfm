<!--- called by InclUpdtConstit.cfm --->

<CFQUERY name="UpdtConstit" datasource="#request.DSN#">
	UPDATE
		constitution
	SET
		DivisionID = <cfqueryparam value = #DivisionID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		TeamID = <cfqueryparam value = #TeamID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		OrdinalID = <cfqueryparam value = #OrdinalID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		ThisMatchNoID = <cfqueryparam value = #ThisMatchNoID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		NextMatchNoID = <cfqueryparam value = #NextMatchNoID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">,
		PointsAdjustment =  <cfqueryparam value = #PointsAdjustment# cfsqltype="CF_SQL_NUMERIC" >,
		MatchBanFlag =  <cfqueryparam value = #MatchBanFlag# cfsqltype="CF_SQL_NUMERIC" >
		
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = <cfqueryparam value = #ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

