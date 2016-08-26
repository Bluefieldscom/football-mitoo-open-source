<!--- called by InclInsrtLookUp.cfm --->

<cfquery name="InsrtLookUpTblName" datasource="#request.DSN#" >
	INSERT INTO referee 
	(LongCol, MediumCol, ShortCol, Notes, LeagueCode, EmailAddress1, EmailAddress2, 
	<cfif Level neq "">Level, </cfif>
	PromotionCandidate, Restrictions,
	Surname,
	Forename,
	<cfif DateOfBirth neq "">DateOfBirth,</cfif>
	ParentCounty,
	AddressLine1,
	AddressLine2,
	AddressLine3,
	PostCode,
	ShowHideAddress,	
	HomeTel,
	WorkTel,
	MobileTel
	) 
	VALUES ('#Trim(Surname)#, #Trim(Forename)#', '#MediumCol#', '#ShortCol#', '#Notes#', 
			<cfqueryparam value = '#request.filter#' 	cfsqltype="CF_SQL_VARCHAR" maxlength="5">,
			'#Trim(EmailAddress1)#', '#Trim(EmailAddress2)#', 
			<cfif Level neq "">#Level#, </cfif>
			'#PromotionCandidate#', '#Trim(Restrictions)#',
			'#Trim(Surname)#',
			'#Trim(Forename)#',
			<cfif DateOfBirth neq "">'#DateOfBirth#',</cfif>
			'#Trim(ParentCounty)#',
			'#Trim(AddressLine1)#',
			'#Trim(AddressLine2)#',
			'#Trim(AddressLine3)#',
			'#Trim(PostCode)#',
			<cfif StructKeyExists(form, "ShowHideAddress")>1<cfelse>0</cfif>,
			'#Trim(HomeTel)#',
			'#Trim(WorkTel)#',
			'#Trim(MobileTel)#' 
			 )
</cfquery>
