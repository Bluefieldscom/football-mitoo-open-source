<!--- Called by RegistListForm.cfm --->
<cfquery name="LookUpAltPWD" datasource="zmast">
	SELECT 
		altPwd 
	FROM 
		alternativepwd
	WHERE
		LeagueCode = '#LeagueCode#'
		AND fmPwd = '#SecretWord#'
		AND PwdType = 'T'
</cfquery>
