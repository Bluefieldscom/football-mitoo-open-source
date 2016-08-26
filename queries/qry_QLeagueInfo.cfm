<!--- called by RefsPromotionReport.cfm --->

<cfquery name="QLeagueInfo" datasource="zmast">
	SELECT RefMarksOutOfHundred FROM leagueinfo WHERE DefaultLeagueCode = '#DLCode#'
</cfquery>
