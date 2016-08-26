<!--- called by Action.cfm --->

<!--- this is intended for Referee, Rule? and Team NOT Player --->
<cfquery name="QUpdtTblNameRecord" datasource="#request.DSN#" >
	UPDATE
		#LCase(TblName)# z 
	SET 
		z.LongCol = <cfqueryparam value = '#Form.LongCol#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="50">, 
		z.MediumCol = <cfqueryparam value = '#Form.MediumCol#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="25">, 
		z.ShortCol = <cfqueryparam value = '#Form.ShortCol#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="15">,
		z.Notes = '#Trim(Form.Notes)#'
	WHERE 
		z.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND z.ID = <cfqueryparam value = #Form.ID# 
						cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
