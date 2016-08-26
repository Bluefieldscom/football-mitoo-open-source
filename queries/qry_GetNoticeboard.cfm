<!--- Called by UpdateForm.cfm     #ThisTableName# will be noticeboard OR noticeboard_old --->

<cfquery name="GetNoticeboard" datasource="Marketplace" >
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
		#ThisTableName# as Noticeboard
	WHERE
		ID = <cfqueryparam value = #ID# 
				cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
