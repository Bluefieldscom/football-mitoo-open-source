<!--- called from SuspendPlayer.cfm, LUList.cfm --->
<cftry>

	<cfquery name="QMatchbanHeader" datasource="#request.DSN#" >
	SELECT  
		mb.ID as MatchBanID,
		mbh.SuspensionID, 
		mbh.TeamID, 
		mbh.OrdinalID,
		CASE
		WHEN o.LongCol IS NULL THEN t.LongCol
		ELSE CONCAT(t.LongCol, ' ', o.LongCol)
		END
		as TeamOrdinalDescription,
		s.SuspensionNotes,
		s.FirstDay, 
		s.numberofmatches as NumberOfMatches,
		mb.ItemNumber as ItemNumber,
		LastUpdated as LastUpdtd
	FROM 
		suspension s, 
		matchbanheader mbh, 
		matchban mb,
		team t,
		ordinal o
		
	WHERE
		s.leaguecode= <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND mbh.SuspensionID = #ThisSuspensionID#
		AND s.ID = mbh.SuspensionID
		AND mbh.ID = mb.MatchbanHeaderID
		AND mbh.TeamID = t.ID
		AND mbh.OrdinalID = o.ID
	ORDER BY
		FirstDay,SuspensionID,ItemNumber
	</cfquery>


	<cfcatch type="database">
		<cfmodule template="../dberrorpage.cfm" source="Suspension"><cfabort>
	</cfcatch>
	
</cftry>
