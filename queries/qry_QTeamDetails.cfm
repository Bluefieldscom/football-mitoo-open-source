<!--- called by TeamDetailsXLS.cfm --->
<cfquery name="QTeamDetails" datasource="#request.DSN#">	
	SELECT 
		CASE
			WHEN o.longcol IS NULL THEN t.longcol
			ELSE CONCAT(t.longcol, ' ', o.longcol)
			END
			as TeamName,
		td.ShirtColour1, 
		td.ShortsColour1, 
		td.SocksColour1, 
		td.ShirtColour2, 
		td.ShortsColour2, 
		td.SocksColour2, 
		td.Contact1Name, 
		td.Contact1JobDescr, 
		td.Contact1Address, 
		td.Contact1TelNo1, 
		td.Contact1TelNo1Descr, 
		td.Contact1TelNo2, 
		td.Contact1TelNo2Descr, 
		td.Contact1TelNo3, 
		td.Contact1TelNo3Descr, 
		td.Contact1Email1, 
		td.Contact1Email2, 
		td.Contact2Name, 
		td.Contact2JobDescr, 
		td.Contact2Address, 
		td.Contact2TelNo1, 
		td.Contact2TelNo1Descr, 
		td.Contact2TelNo2, 
		td.Contact2TelNo2Descr, 
		td.Contact2TelNo3, 
		td.Contact2TelNo3Descr, 
		td.Contact2Email1, 
		td.Contact2Email2, 
		td.Contact3Name, 
		td.Contact3JobDescr, 
		td.Contact3Address, 
		td.Contact3TelNo1, 
		td.Contact3TelNo1Descr, 
		td.Contact3TelNo2, 
		td.Contact3TelNo2Descr, 
		td.Contact3TelNo3, 
		td.Contact3TelNo3Descr, 
		td.Contact3Email1, 
		td.Contact3Email2, 
		td.ShowHideContact1Address, 
		td.ShowHideContact1TelNo1, 
		td.ShowHideContact1TelNo2, 
		td.ShowHideContact1TelNo3, 
		td.ShowHideContact1Email1, 
		td.ShowHideContact1Email2, 
		td.ShowHideContact2Address, 
		td.ShowHideContact2TelNo1, 
		td.ShowHideContact2TelNo2, 
		td.ShowHideContact2TelNo3, 
		td.ShowHideContact2Email1, 
		td.ShowHideContact2Email2, 
		td.ShowHideContact3Address, 
		td.ShowHideContact3TelNo1, 
		td.ShowHideContact3TelNo2, 
		td.ShowHideContact3TelNo3, 
		td.ShowHideContact3Email1, 
		td.ShowHideContact3Email2,
		td.venueid,
		td.pitchnoid,
		(SELECT count(id) from constitution WHERE teamid=td.teamid AND ordinalid=td.ordinalid) AS ccount
	FROM 
		teamdetails td, 
		team t,
		ordinal o
	WHERE
		td.LeagueCode = '#request.filter#'
		AND td.TeamID = t.ID
		AND td.OrdinalID = o.ID
	HAVING
		ccount > 0
	ORDER BY
		t.longcol,o.longcol
</cfquery>
