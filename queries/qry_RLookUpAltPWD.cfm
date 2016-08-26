<!--- Called by RefereeListForm.cfm --->
<cfquery name="RLookUpAltPWD" datasource="zmast">
	SELECT 
		altPwd,
		IDName
	FROM 
		alternativepwd
	WHERE
		LeagueCode = '#LeagueCode#'
		AND fmPwd = '#RSecretWord#'
		AND PwdType = 'R'
</cfquery>

