<!--- called by InclInsrtConstit.cfm --->
<CFQUERY name="QCheckDuplicatePlayer" datasource="#request.DSN#">
SELECT
	Surname, Forename
FROM
	player
WHERE
	LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
	<cfif StructKeyExists(form, "Surname") AND StructKeyExists(form, "Forename")>
		<cfif Form.Surname IS NOT "" AND Form.Forename IS NOT "">
			AND Surname  = '#Form.Surname#'
			AND Forename = '#Form.Forename#'
		</cfif>
	</cfif>
</CFQUERY>
