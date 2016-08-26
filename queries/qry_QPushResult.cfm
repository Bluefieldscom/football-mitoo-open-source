<!--- called by InclPushResultToGR.cfm --->
	<cfquery name="QPushResult" datasource="#request.dsn#">
		
		SELECT 
			zmlkd.id AS division_id
		FROM 
			fixture f
			JOIN constitution c ON c.id = f.HomeID
			JOIN zmast.lk_division zmlkd ON c.divisionID = zmlkd.#RIGHT(request.dsn,4)#id
		WHERE
			f.id = <cfqueryparam value = #id# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND f.leaguecode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	
	</cfquery>

