<!--- called by TeamList.cfm --->
<cfif Trim(Form.HospitalityMarks) IS "">
	<cfquery name="QUpdtHospitalityMarks" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			HospitalityMarks = NULL
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
<cfelse>
	<cfquery name="QUpdtHospitalityMarks" datasource="#request.DSN#" >
		UPDATE
			fixture 
		SET 
			HospitalityMarks = <cfqueryparam value = #Form.HospitalityMarks# cfsqltype="CF_SQL_INTEGER" maxlength="3">
		WHERE 
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
			AND ID = <cfqueryparam value = #FID# cfsqltype="CF_SQL_INTEGER" maxlength="8"> 
	</cfquery>
</cfif>
