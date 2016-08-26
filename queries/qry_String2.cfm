<!--- Called by LUList.cfm --->

<CFQUERY NAME="#STRING2#" datasource="#request.DSN#">		<!--- e.g.QUERY NAME="RefereeList" --->
	SELECT 
		*
	FROM
		#LCase(STRING1)#
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' 
						cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND LongCol IS NOT NULL
	 <cfif #STRING1# IS "Team">
	 	AND ID NOT IN(SELECT ID FROM team WHERE LEFT(Notes,7) = 'NoScore')
	 </cfif>
	 <cfif #STRING1# IS "Rule">
		AND ID NOT IN(SELECT ID FROM rule WHERE LongCol = 'Checked' OR LongCol = 'Payment')
	 </cfif>
	  <!--- We are suppressing the "Winners of Match nnn" with NoScore
	and suppressing 'blank' records too. --->
	ORDER BY
		 <cfif #STRING1# IS "Referee">
		 ShortCol
		 <cfelseif  #STRING1# IS "MatchReport">
		 ID DESC
		 <cfelseif #STRING1# IS "Division">
		 MediumCol
		 <cfelseif #STRING1# IS "NewsItem">
		 MediumCol
		 <cfelseif #STRING1# IS "KORound">
		 MediumCol
		 <cfelseif #STRING1# IS "Rule">
		 ShortCol
		 <cfelseif #STRING1# IS "Ordinal">
		 MediumCol, LongCol
		 <cfelseif #STRING1# IS "Committee">
		 Shortcol, LongCol
		 <cfelse>
		 LongCol
		 </cfif>
</CFQUERY>
