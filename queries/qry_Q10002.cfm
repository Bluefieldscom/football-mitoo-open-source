<!--- called by SwapHomeAway.cfm --->
<cfquery name="Q10002" datasource="#request.DSN#">
	UPDATE
		fixture
	SET
		HomeID = #Q10001.AwayID#, 
		AwayID = #Q10001.HomeID#, 
		HomeGoals = '#Q10001.AwayGoals#',
		HomeGoals = IF('#Q10001.AwayGoals#' = '', NULL, '#Q10001.AwayGoals#'),
		AwayGoals = IF('#Q10001.HomeGoals#' = '', NULL, '#Q10001.HomeGoals#'),
		RefereeMarksH = IF('#Q10001.RefereeMarksA#' = '', NULL, '#Q10001.RefereeMarksA#'),
		RefereeMarksA = IF('#Q10001.RefereeMarksH#' = '', NULL, '#Q10001.RefereeMarksH#'),
		HomeSportsmanshipMarks = IF('#Q10001.AwaySportsmanshipMarks#' = '', NULL, '#Q10001.AwaySportsmanshipMarks#'),
		AwaySportsmanshipMarks = IF('#Q10001.HomeSportsmanshipMarks#' = '', NULL, '#Q10001.HomeSportsmanshipMarks#')
	WHERE
		ID = #Q10001.ID#
</cfquery>
