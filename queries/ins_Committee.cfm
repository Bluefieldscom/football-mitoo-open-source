<!--- called by Action.cfm --->
<cfquery name="InsrtCommittee" datasource="#request.DSN#" >
	INSERT INTO committee 
	(LongCol, MediumCol, ShortCol, Notes, LeagueCode, EmailAddress1, EmailAddress2, 
	Title,
	Surname,
	Forename,
	AddressLine1,
	AddressLine2,
	AddressLine3,
	PostCode,
	HomeTel,
	WorkTel,
	MobileTel,
	ShowHideEmailAddress1,
	ShowHideEmailAddress2,
	ShowHideHomeTel,
	ShowHideWorkTel,
	ShowHideMobileTel,
	ShowHideAddress,
	NoMailout
	) 
	VALUES ('#Trim(LongCol)#', '#Trim(Title)# #Trim(Forename)# #Trim(Surname)#', '#ShortCol#', '#Notes#', 
			<cfqueryparam value = '#request.filter#' 	cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
		'#TRIM(Form.EmailAddress1)#' ,
		'#TRIM(Form.EmailAddress2)#' ,
		'#TRIM(Form.Title)#',
		'#TRIM(Form.Surname)#',
		'#TRIM(Form.Forename)#',
		'#TRIM(Form.AddressLine1)#',
		'#TRIM(Form.AddressLine2)#',
		'#TRIM(Form.AddressLine3)#',
		'#TRIM(Form.PostCode)#',
		'#TRIM(Form.HomeTel)#',
		'#TRIM(Form.WorkTel)#',
		'#TRIM(Form.MobileTel)#',
		<cfif StructKeyExists(form, "ShowHideEmailAddress1")>1<cfelse>0</cfif>,
		<cfif StructKeyExists(form, "ShowHideEmailAddress2")>1<cfelse>0</cfif>,
		<cfif StructKeyExists(form, "ShowHideHomeTel")>1<cfelse>0</cfif>,
		<cfif StructKeyExists(form, "ShowHideWorkTel")>1<cfelse>0</cfif>,
		<cfif StructKeyExists(form, "ShowHideMobileTel")>1<cfelse>0</cfif>,
		<cfif StructKeyExists(form, "ShowHideAddress")>1<cfelse>0</cfif>,
		#Form.NoMailout#
		
			 )
</cfquery>
