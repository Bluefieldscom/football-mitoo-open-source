<!--- called by RegistListForm.cfm --->
<cftry>
	<cfquery name="InsertAltPWD" datasource="zmast">
		INSERT INTO 
			alternativepwd
			(LeagueCode, fmPwd, altPwd, PwdType, IDName	)
			values
			('#LeagueCode#', '#SecretWord#', '#AltSecretWord#', 'T', '#form.TeamInfo#' )
	</cfquery>
	<cfcatch type="database">
		<cfset AltPWDMessage = "ERROR: Your chosen password has already been used.">
	</cfcatch>
</cftry>
