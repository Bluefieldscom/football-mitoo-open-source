<!--- Called by Noticeboard.cfm --->

<cfquery name="QNoticeboard" datasource="MarketPlace" >
	SELECT
		ID ,
		StartDate ,
		EndDate,
		ImageFile ,
		ShowEverywhere ,
		ShowForTheseCounties ,
		ShowForTheseLeagues ,
		AdvertTitle ,
		AdvertHTML ,
		ContactName ,
		TelephoneNumbers ,
		EmailAddr
	FROM
		noticeboard
	WHERE
		NOT Hide 
		AND ( #CreateODBCDate(Now())# BETWEEN StartDate AND EndDate )
	ORDER BY
		Priority, StartDate DESC, AdvertTitle
</cfquery>

