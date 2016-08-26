<!--- called by UnregPlayersForDeletion.cfm --->

<cfquery name="QUnregisteredPlayersWithNoSuspensions" datasource="#request.DSN#" >
	SELECT
		*
	FROM
		player
	WHERE
		leaguecode='#request.filter#' 
		AND shortcol <> 0
		AND id not in (SELECT playerid FROM register WHERE leaguecode='#request.filter#') 
		AND id not in (SELECT playerid FROM suspension WHERE leaguecode='#request.filter#')
		AND id not in (SELECT playerid FROM appearance WHERE leaguecode='#request.filter#')
	ORDER BY
		surname;
</cfquery>




