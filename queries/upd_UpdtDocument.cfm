<!--- called by Action.cfm --->

<cfquery name="UpdtNoticeboard" datasource="zmast">
	UPDATE
		leaguedocs
	SET
		Description = '#form.Description#' ,
		GroupName = '#form.GroupName#'
	WHERE
		ID = #ID#
</cfquery>
