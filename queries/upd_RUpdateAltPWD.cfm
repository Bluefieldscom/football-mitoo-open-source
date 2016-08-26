<!--- called by RegistListForm.cfm --->
<cftry>
	<cfquery name="RUpdateAltPWD" datasource="zmast">				
		UPDATE 
			alternativepwd 
		SET
			altPwd = '#AltRSecretWord#'  
		WHERE
			LeagueCode = '#LeagueCode#'
			AND fmPwd = '#RSecretWord#'
			AND PwdType = 'R'
	</cfquery>
	<cfcatch type="database">
		<cfset AltPWDMessage = "ERROR: Your chosen password has already been used.">
	</cfcatch>
</cftry>

