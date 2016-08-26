<!--- called by AppearancesQuery.cfm --->

<cfquery name="QAppearanceGetList" datasource="#request.DSN#">
	SELECT
		p.ID
	FROM
		appearance a LEFT JOIN player p ON p.ID = a.PlayerID
		LEFT JOIN fixture f ON f.ID = a.FixtureID,
		constitution c LEFT JOIN division d ON c.DivisionID = d.ID
		LEFT JOIN team t ON c.TeamID = t.ID
		LEFT JOIN ordinal o ON c.OrdinalID = o.ID
	WHERE
		p.LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND t.ID NOT IN (#BadTIDList#) 
		AND	o.ID NOT IN (#BadOIDList#) 
		AND	
		<cfif ListGetAt(Form.OID, 2) IS "ANY TEAM">
		<cfelse>
			o.ID = #ListGetAt(Form.OID, 2)# AND
		</cfif>
		<cfif ListGetAt(Form.TID, 2) IS "ANY CLUB">
		<cfelseif ListGetAt(Form.TID, 2) IS "ANY OTHER CLUB">
			t.ID <> #ListGetAt(Form.TID, 1)# AND														
		<cfelse>
			t.ID = #ListGetAt(Form.TID, 2)# AND
		</cfif>
		d.ID = #ListGetAt(Form.DID, 2)# 
		AND p.shortcol <> 0 
		AND ((a.HomeAway = 'H'  
				AND c.ID = f.HomeID) 
				OR (a.HomeAway = 'A' 
				AND c.ID = f.AwayID)) 
	GROUP BY
		p.ID
	HAVING
		COUNT(a.ID) >= #ListGetAt(Form.NoOfAppearances, 2)#
</cfquery>

<cfif QAppearanceGetList.recordcount GT 0>
	<cfset selectedList = ValueList(QAppearanceGetList.ID)>
<cfelse>
	<cfset selectedList = 0>
</cfif>

<cfquery name="QAppearance" datasource="#request.DSN#" >
			SELECT
				CONCAT(p.Surname, " ", p.Forename) as PlayerName,
				p.Surname as PlayerSurname,
				p.Forename as PlayerForename,
				p.ID as PID
			FROM
				appearance AS a,
				fixture AS f,
				constitution AS c,
				division AS d,
				ordinal AS o,
				team AS t,
				player AS p
			WHERE
				d.LeagueCode = <cfqueryparam value = '#request.filter#' 
								cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
				AND t.ID NOT IN (#BadTIDList#) 
				AND	o.ID NOT IN (#BadOIDList#) 
				AND		
				<cfif ListGetAt(Form.OID, 1) IS "ANY TEAM">
				<cfelse>
					o.ID = #ListGetAt(Form.OID, 1)# AND
				</cfif>
				<cfif ListGetAt(Form.TID, 1) IS "ANY CLUB">
				<cfelseif ListGetAt(Form.TID, 1) IS "ANY OTHER CLUB">
					t.ID <> #ListGetAt(Form.TID, 2)# AND
				<cfelse>
					t.ID = #ListGetAt(Form.TID, 1)# AND
				</cfif>
				d.ID = #ListGetAt(Form.DID, 1)# 
				AND p.shortcol <> 0 
				AND ((a.HomeAway = 'H'  
						AND c.ID = f.HomeID) 
						OR (a.HomeAway = 'A' 
						AND c.ID = f.AwayID))
				AND f.ID = a.FixtureID 
				AND d.ID = c.DivisionID 
				AND t.ID = c.TeamID 
				AND o.ID = c.OrdinalID 
				AND p.ID = a.PlayerID
				AND p.ID IN (#selectedList#)			
			GROUP BY
				PID, PlayerName 
			HAVING
				COUNT(a.ID) >= #ListGetAt(Form.NoOfAppearances, 1)# 
			ORDER BY
				PlayerName 
</cfquery>
