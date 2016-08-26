<!--- called by InclTblChooseOrdinal.cfm --->

<CFQUERY NAME="GetOrdinal" datasource="#request.DSN#">
	SELECT	
		ID,
		LongCol as OrdinalName
	FROM 	
		ordinal as Ordinal
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
		AND ID NOT IN
			(SELECT ID 
				FROM ordinal as Ordinal 
				WHERE LeagueCode = <cfqueryparam value = '#request.filter#' 
					cfsqltype = "CF_SQL_VARCHAR" maxlength = "5">
				AND MediumCol = 'KO' )					
	ORDER BY
		OrdinalName
</CFQUERY>
