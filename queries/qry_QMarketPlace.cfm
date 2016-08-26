<!--- Called by Marketplace.cfm --->

<cfquery name="QMarketPlace" datasource="MarketPlace" >
	SELECT
		ID, ShowEverywhere, ShowForTheseCounties, ShowForTheseLeagues, AdvertTitle, AdvertHTML
	FROM
		marketplace
	WHERE
		( #CreateODBCDate(Now())# BETWEEN StartDate AND EndDate )
	ORDER BY
		Priority
</cfquery>
