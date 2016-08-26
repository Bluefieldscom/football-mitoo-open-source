<!--- called by Action.cfm --->

<cfquery name="QUpdtCommitteeRecord" datasource="#request.DSN#" >
	UPDATE
		committee 
	SET 
		LongCol = '#TRIM(Form.LongCol)#',
		MediumCol = '#TRIM(Form.Title)# #TRIM(Form.Forename)# #TRIM(Form.Surname)#',
		ShortCol = <cfqueryparam value = '#TRIM(Form.ShortCol)#' 	cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
		<cfif Form.Notes IS "">
			Notes = NULL ,
		<cfelse>
			Notes = '#TRIM(Form.Notes)#' ,
		</cfif>
		EmailAddress1 = '#TRIM(Form.EmailAddress1)#' ,
		EmailAddress2 = '#TRIM(Form.EmailAddress2)#' ,
		Title = '#TRIM(Form.Title)#',
		Surname = '#TRIM(Form.Surname)#',
		Forename = '#TRIM(Form.Forename)#',
		AddressLine1 = '#TRIM(Form.AddressLine1)#',
		AddressLine2 = '#TRIM(Form.AddressLine2)#',
		AddressLine3 = '#TRIM(Form.AddressLine3)#',
		PostCode = '#TRIM(Form.PostCode)#',
		HomeTel = '#TRIM(Form.HomeTel)#',
		WorkTel = '#TRIM(Form.WorkTel)#',
		MobileTel = '#TRIM(Form.MobileTel)#',
		
		
		
		<cfif StructKeyExists(form, "ShowHideEmailAddress1")>
			ShowHideEmailAddress1  =  1,
		<cfelse>
			ShowHideEmailAddress1  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideEmailAddress2")>
			ShowHideEmailAddress2  =  1,
		<cfelse>
			ShowHideEmailAddress2  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideHomeTel")>
			ShowHideHomeTel  =  1,
		<cfelse>
			ShowHideHomeTel  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideWorkTel")>
			ShowHideWorkTel  =  1,
		<cfelse>
			ShowHideWorkTel  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideMobileTel")>
			ShowHideMobileTel  =  1,
		<cfelse>
			ShowHideMobileTel  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideAddress")>
			ShowHideAddress  =  1,
		<cfelse>
			ShowHideAddress  =  0,
		</cfif>
		NoMailOut  =  '#form.NoMailOut#',
		<cfif StructKeyExists(form, "CCEmailAddress1")>
			CCEmailAddress1  =  1,
		<cfelse>
			CCEmailAddress1  =  0,
		</cfif>
		<cfif StructKeyExists(form, "CCEmailAddress2")>
			CCEmailAddress2  =  1 
		<cfelse>
			CCEmailAddress2  =  0 
		</cfif>
	WHERE 
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5"> 
		AND ID = <cfqueryparam value = #Form.ID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>
