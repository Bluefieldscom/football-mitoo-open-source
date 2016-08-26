<!--- called by Action.cfm --->
<cfquery name="QUpdtRefereeRecord" datasource="#request.DSN#" >
	UPDATE
		referee 
	SET 
		LongCol = '#TRIM(Form.Surname)#, #TRIM(Form.Forename)#',
		<cfif NOT ListFind("Yellow",request.SecurityLevel) >
			MediumCol = <cfqueryparam value = '#TRIM(Form.MediumCol)#' cfsqltype="CF_SQL_VARCHAR" maxlength="25">, 
			ShortCol = <cfqueryparam value = '#TRIM(Form.ShortCol)#' 	cfsqltype="CF_SQL_VARCHAR" maxlength="15">,
			Restrictions = '#Form.Restrictions#',
		</cfif>
		
		<cfif Form.Notes IS "">
			Notes = NULL ,
		<cfelse>
			Notes = '#TRIM(Form.Notes)#' ,
		</cfif>
		EmailAddress1 = '#TRIM(Form.EmailAddress1)#' ,
		EmailAddress2 = '#TRIM(Form.EmailAddress2)#' ,
		<cfif Form.Level neq "">Level = #Form.Level# ,</cfif>
		PromotionCandidate = '#Form.PromotionCandidate#',
		Surname = '#TRIM(Form.Surname)#',
		Forename = '#TRIM(Form.Forename)#',
		<cfif Form.DateOfBirth neq "">DateOfBirth = '#Form.DateOfBirth#',</cfif>
		<cfif Form.FAN neq "">FAN = '#TRIM(Form.FAN)#',</cfif>
		ParentCounty = '#TRIM(Form.ParentCounty)#',
		AddressLine1 = '#TRIM(Form.AddressLine1)#',
		AddressLine2 = '#TRIM(Form.AddressLine2)#',
		AddressLine3 = '#TRIM(Form.AddressLine3)#',
		PostCode = '#TRIM(Form.PostCode)#',
		<cfif StructKeyExists(form, "ShowHideAddress")>
			ShowHideAddress  =  1,
		<cfelse>
			ShowHideAddress  =  0,
		</cfif>
		HomeTel = '#TRIM(Form.HomeTel)#',
		WorkTel = '#TRIM(Form.WorkTel)#',
		MobileTel = '#TRIM(Form.MobileTel)#'
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
