<!--- called by ConstitList.cfm --->

<CFQUERY NAME="QConstit" datasource="#request.DSN#">
	SELECT
		<!--- d.LongCol as division ,  --->
		t.LongCol as team , 
		t.ShortCol as Guest , 
		o.LongCol as Ordinal ,
		c.ID as CID ,
		c.DivisionID as CDID ,
		c.TeamID as CTID ,
		c.OrdinalID as COID ,
		c.ThisMatchNoID as TMNID ,
		c.NextMatchNoID as NMNID ,
		c.PointsAdjustment,
		c.MatchBanFlag,
		ThisMatch.LongCol as ThisMatchNumber ,
		NextMatch.LongCol as NextMatchNumber
	FROM
		constitution AS c, 
		division AS d, 
		team AS t, 
		ordinal AS o, 
		matchno AS ThisMatch, 
		matchno AS NextMatch
	WHERE
		c.LeagueCode 		= <cfqueryparam value = '#request.filter#' 
								cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND c.DivisionID 	= <cfqueryparam value = #DivisionID# 
								cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND c.DivisionID    = d.ID 
		AND c.TeamID        = t.ID 
		AND c.OrdinalID     = o.ID 
		AND c.ThisMatchNoID = ThisMatch.ID 
		AND c.NextMatchNoID = NextMatch.ID 
	ORDER BY
		<!---  division, d.LongCol, --->
		<cfif Find( "MatchNumbers", QKnockOut.Notes )>
			<cfif StructKeyExists(url, "S") >
				<cfif URL.S IS 2>
					ThisMatchNoID,
				<cfelseif URL.S IS 3>
				NextMatchNoID, ThisMatchNoID, 
				</cfif>
			</cfif>
		</cfif>
	  Team, Ordinal <!--- t.LongCol, o.LongCol --->
</CFQUERY>
