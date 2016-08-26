<!--- called by SecurityCheck.cfm --->

<cfquery name="QPWDInsert3" datasource="ZMAST" >
	INSERT INTO	loghistory
			( DateTimeStamp 
			, LeagueCode
			, UserName
			, LoggedInOK
			, Passwd
			) 
	VALUES
			( #DTStamp#
			, <cfqueryparam value = '#form.LeagueCode#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="15">
			, '#form.name# '
			, '1'
			, '*#multi_site_user#*'
			);
</cfquery>
