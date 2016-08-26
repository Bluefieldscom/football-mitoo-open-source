<!--- called by SeeSameSurnameForename.cfm --->

<cfquery name="QSurnameForename" datasource="#request.DSN#" >
	SELECT
		p.ID,
		p.surname,
		p.forename,
		p.MediumCol,
		p.ShortCol,
		p.Notes,
		t.LongCol as TeamName
	FROM
		((player AS p LEFT OUTER JOIN register AS r 
			ON p.ID = r.PlayerID) 
			LEFT OUTER JOIN team AS t 
				ON r.TeamID = t.ID) 
		WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND p.surname = '#URL.sname#'
	ORDER BY
		p.forename, ShortCol
</cfquery>
