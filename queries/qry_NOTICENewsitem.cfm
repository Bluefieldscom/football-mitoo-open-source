<!--- called by InclCheckNewsItemForm.cfm --->

<!--- before adding a NOTICE Newsitem make sure there isn't one there already --->

<CFQUERY NAME="QNOTICENewsitem" datasource="#request.DSN#">
	SELECT
		longcol
	FROM
		newsitem
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND longcol = 'NOTICE'
</CFQUERY>

	
