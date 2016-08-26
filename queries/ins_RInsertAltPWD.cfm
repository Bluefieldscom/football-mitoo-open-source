<!--- called by RefereeListForm.cfm --->
<cftry>
	<cfquery name="RInsertAltPWD" datasource="zmast">
		INSERT INTO 
			alternativepwd
			(LeagueCode, fmPwd, altPwd, PwdType, IDName	)
			values
			('#LeagueCode#', '#RSecretWord#', '#AltRSecretWord#', 'R', '#form.RefereeInfo#' )
	</cfquery>
	<cfcatch type="database">
		<cfset AltPWDMessage = "ERROR: Your chosen password has already been used.">
	</cfcatch>
</cftry>

