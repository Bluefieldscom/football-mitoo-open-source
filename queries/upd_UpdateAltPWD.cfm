<!--- called by RegistListForm.cfm --->
<cftry>
	<cfquery name="UpdateAltPWD" datasource="zmast">				
		UPDATE 
			alternativepwd 
		SET
			altPwd = '#AltSecretWord#'  
		WHERE
			LeagueCode = '#LeagueCode#'
			AND fmPwd = '#SecretWord#'
			AND PwdType = 'T'
	</cfquery>
	<cfcatch type="database">
		<cfset AltPWDMessage = "ERROR: Your chosen password has already been used.">
	</cfcatch>
</cftry>
