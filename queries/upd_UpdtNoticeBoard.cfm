<!--- called by Action.cfm                         #ThisTableName# will be noticeboard OR noticeboard_old --->
<CFQUERY name="UpdtNoticeboard" datasource="MarketPlace">
	UPDATE
		#form.ThisTableName#
	SET
		<cfif StructKeyExists(form, "Hide")>
			Hide = '1'
		<cfelse>
			Hide = '0'
		</cfif>,
		<cfif StructKeyExists(form, "ShowEverywhere")>
			ShowEverywhere = '1'
		<cfelse>
			ShowEverywhere = '0'
		</cfif>,
		ShowForTheseCounties = '#Form.ShowForTheseCounties#' ,
		ShowForTheseLeagues = '#Form.ShowForTheseLeagues#' ,
		Priority = #Form.Priority# ,
		StartDate = '#DateFormat(Form.StartDate,"YYYY-MM-DD")#' ,
		EndDate = '#DateFormat(Form.EndDate,"YYYY-MM-DD")#' ,
		ImageFile = '#Form.ImageFile#' ,
		AdvertTitle = '#Form.AdvertTitle#' ,
		AdvertHTML = '#Form.AdvertHTML#' ,
		EmailAddr = '#Form.EmailAddr#' ,
		ContactName = '#Form.ContactName#' ,
		TelephoneNumbers = '#Form.TelephoneNumbers#' ,
		Notes = '#Form.Notes#' 
	WHERE
		ID = #ID#
</cfquery>
