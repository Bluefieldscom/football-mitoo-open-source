<!--- Called by LUList.cfm --->

<cfquery name="NoticeboardList" datasource="Marketplace" >
	SELECT
		ID ,
		Hide ,
		ShowEverywhere ,
		ShowForTheseCounties ,
		ShowForTheseLeagues ,
		Priority ,
		StartDate ,
		EndDate ,
		ImageFile ,
		AdvertTitle ,
		AdvertHTML ,
		EmailAddr ,
		ContactName ,
		TelephoneNumbers ,
		Notes
	FROM
		noticeboard as Noticeboard
	ORDER BY
		Priority, StartDate DESC, AdvertTitle
</cfquery>
