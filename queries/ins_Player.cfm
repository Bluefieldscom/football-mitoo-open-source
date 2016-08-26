<!--- called by InclInsrtLookUp.cfm, InclBatchUpdate1.cfm --->


<!--- applies to season 2012 onwards only via InclInsrtLookUp.cfm only, not batch input --->
<cfif (RIGHT(request.dsn,4) GE 2012) AND StructKeyExists(form, "AddressLine1") >
<cftry>		  
	<cfquery name="InsrtPlayer" datasource="#request.DSN#" result="InsrtPlayer_result">
	INSERT INTO player 
		(Surname, Forename, MediumCol, ShortCol, Notes, LeagueCode, FAN, AddressLine1, AddressLine2, AddressLine3, Postcode, Email1 ) 
	VALUES ( <cfqueryparam value = '#Surname#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="20">, 
			<cfqueryparam value = '#Forename#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="35">, 				
			<cfif IsDate(MediumCol)>
				<cfqueryparam value = '#MediumCol#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="25">
			<cfelse>
				NULL
			</cfif>, 
			<cfqueryparam value = #ShortCol# 
				cfsqltype="CF_SQL_INTEGER" maxlength="10">, 
			<cfqueryparam value = '#Notes#' 
				cfsqltype="CF_SQL_LONGVARCHAR">,
			<cfqueryparam value = '#request.filter#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
			<cfif IsNumeric(FAN)>
				<cfqueryparam value = #FAN# 
					cfsqltype="CF_SQL_INTEGER" maxlength="10">
			<cfelse>
				NULL
			</cfif> ,			
			<cfif TRIM(Form.AddressLine1) IS "">
				NULL
			<cfelse>
				<cfqueryparam value = '#TRIM(Form.AddressLine1)#' cfsqltype="CF_SQL_VARCHAR" maxlength="40"> 
			</cfif> ,			
			<cfif TRIM(Form.AddressLine2) IS "">
				NULL
			<cfelse>
				<cfqueryparam value = '#TRIM(Form.AddressLine2)#' cfsqltype="CF_SQL_VARCHAR" maxlength="40"> 
			</cfif> ,			
			<cfif TRIM(Form.AddressLine3) IS "">
				NULL
			<cfelse>
				<cfqueryparam value = '#TRIM(Form.AddressLine3)#' cfsqltype="CF_SQL_VARCHAR" maxlength="40"> 
			</cfif> ,			
			<cfif TRIM(Form.Postcode) IS "">
				NULL
			<cfelse>
				<cfqueryparam value = '#TRIM(Form.Postcode)#' cfsqltype="CF_SQL_VARCHAR" maxlength="10"> 
			</cfif> ,
			<cfif TRIM(Form.Email1) IS "">
				NULL
			<cfelse>
				<cfqueryparam value = '#TRIM(Form.Email1)#' cfsqltype="CF_SQL_VARCHAR" maxlength="80"> 
			</cfif>  			
						
				 )
	</cfquery>
		<cfcatch type="Database">
			<cfif cfcatch.NativeErrorCode IS "1062">
				<cfif cfcatch.detail contains "key 3">
				<!--- duplicate values on Leaguecode,LongCol(Name),MediumCol(DOB) - Check2 --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="namedob">
				<cfelse>
				<!--- duplicate values on Leaguecode,Shortcol(unique ID) - Check --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="indexno">
				</cfif>
				<cfabort>
			</cfif>
		</cfcatch>
		<cfcatch type="Any">
			<!--- for all other errors, most likely non-numeric codes --->
			<cfmodule template="../dberrorpage.cfm" 
				source="Player" errortype="baddata">
			<cfabort>
		</cfcatch>
</cftry>


<cfelse>
<!--- applies to season 2011 and earlier --->


<cftry>		  
	<cfquery name="InsrtPlayer" datasource="#request.DSN#" result="InsrtPlayer_result">
	INSERT INTO player 
		(Surname, Forename, MediumCol, ShortCol, Notes, LeagueCode, FAN) 
	VALUES ( <cfqueryparam value = '#Surname#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="20">, 
			<cfqueryparam value = '#Forename#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="35">, 				
			<cfif IsDate(MediumCol)>
				<cfqueryparam value = '#MediumCol#' 
					cfsqltype="CF_SQL_VARCHAR" maxlength="25">
			<cfelse>
				NULL
			</cfif>, 
			<cfqueryparam value = #ShortCol# 
				cfsqltype="CF_SQL_INTEGER" maxlength="10">, 
			<cfqueryparam value = '#Notes#' 
				cfsqltype="CF_SQL_LONGVARCHAR">,
			<cfqueryparam value = '#request.filter#' 
				cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
			<cfif IsNumeric(FAN)>
				<cfqueryparam value = #FAN# 
					cfsqltype="CF_SQL_INTEGER" maxlength="10">
			<cfelse>
				NULL
			</cfif> 			
				 )
	</cfquery>
		<cfcatch type="Database">
			<cfif cfcatch.NativeErrorCode IS "1062">
				<cfif cfcatch.detail contains "key 3">
				<!--- duplicate values on Leaguecode,LongCol(Name),MediumCol(DOB) - Check2 --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="namedob">
				<cfelse>
				<!--- duplicate values on Leaguecode,Shortcol(unique ID) - Check --->
					<cfmodule template="../dberrorpage.cfm" 
						source="Player" errortype="duplicatekey" message="indexno">
				</cfif>
				<cfabort>
			</cfif>
		</cfcatch>
		<cfcatch type="Any">
			<!--- for all other errors, most likely non-numeric codes --->
			<cfmodule template="../dberrorpage.cfm" 
				source="Player" errortype="baddata">
			<cfabort>
		</cfcatch>
</cftry>
</cfif>
