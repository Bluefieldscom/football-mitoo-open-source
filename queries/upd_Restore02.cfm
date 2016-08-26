<!--- called from RestoreBackFromMisc.cfm --->
<cfquery name="QRestore02A" datasource="#request.DSN#" >
	SELECT
		ID,
		HomeID
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND AwayID = <cfqueryparam value = #WithdrawnCID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<cfloop query="QRestore02A">
	<cfquery name="QRestore02X" datasource="#request.DSN#" >
		SELECT TeamID, OrdinalID FROM constitution WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #QRestore02A.HomeID#
	</cfquery>
	<!--- get the original HomeID --->
	<cfquery name="QRestore02Y" datasource="#request.DSN#" >
		SELECT
			ID
		FROM
			constitution
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND DivisionID = #ThisDivisionID#		
			AND TeamID = #QRestore02X.TeamID#
			AND OrdinalID = #QRestore02X.OrdinalID#
	</cfquery>
	<cfquery name="QRestore02Z" datasource="#request.DSN#" >
		UPDATE
			fixture
		SET
			AwayID = #Step002.NewCID#,
			HomeID = #QRestore02Y.ID#
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = #QRestore02A.ID#
	</cfquery>
</cfloop>


<cfquery name="QRestore02H" datasource="#request.DSN#" >
	SELECT
		ID,
		AwayID
	FROM
		fixture
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND HomeID = <cfqueryparam value = #WithdrawnCID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<cfloop query="QRestore02H">
	<cfquery name="QRestore02X" datasource="#request.DSN#" >
		SELECT TeamID, OrdinalID FROM constitution WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND ID = #QRestore02H.AwayID#
	</cfquery>
	<!--- get the original AwayID --->
	<cfquery name="QRestore02Y" datasource="#request.DSN#" >
		SELECT
			ID
		FROM
			constitution
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND DivisionID = #ThisDivisionID#		
			AND TeamID = #QRestore02X.TeamID#
			AND OrdinalID = #QRestore02X.OrdinalID#
	</cfquery>
	<cfquery name="QRestore02Z" datasource="#request.DSN#" >
		UPDATE
			fixture
		SET
			HomeID = #Step002.NewCID#,
			AwayID = #QRestore02Y.ID#
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND ID = #QRestore02H.ID#
	</cfquery>
</cfloop>
