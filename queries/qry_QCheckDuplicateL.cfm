<!--- called by InclInsrtConstit.cfm --->
<CFQUERY name="QCheckDuplicateL" datasource="#request.DSN#">
SELECT
	LongCol
FROM
	#LCase(TblName)#
WHERE
	LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	<cfif StructKeyExists(form, "LongCol") >
		<cfif Form.LongCol IS NOT "">
			AND #LCase(Form.TblName)#.LongCol = '#Trim(Form.LongCol)#'
		</cfif>
	</cfif>
</CFQUERY>
