<!--- called by SwapHomeAway.cfm --->
<cfquery name="Q10001" datasource="#request.DSN#">
	SELECT
		f.ID,
		f.HomeID, 
		f.AwayID, 
		IF(f.HomeGoals IS NULL, '', f.HomeGoals) as HomeGoals,
		IF(f.AwayGoals IS NULL, '', f.AwayGoals) as AwayGoals,
		IF(f.RefereeMarksH IS NULL, '', f.RefereeMarksH) as RefereeMarksH,
		IF(f.RefereeMarksA IS NULL, '', f.RefereeMarksA) as RefereeMarksA,
		IF(f.HomeSportsmanshipMarks IS NULL, '', f.HomeSportsmanshipMarks) as HomeSportsmanshipMarks,
		IF(f.AwaySportsmanshipMarks IS NULL, '', f.AwaySportsmanshipMarks) as AwaySportsmanshipMarks,
		c.DivisionID
	FROM
		fixture f,
		constitution c
	WHERE
		f.ID = #url.SwapFixtureID#
		AND f.HomeID = c.ID
</cfquery>
