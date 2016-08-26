<!--- called by LeagueInfoUpdate.cfm --->
<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012 <!--- AND ListFind("Yellow",request.SecurityLevel)---> >
	<cfquery name="QThisTeamDetails" datasource="#request.DSN#" >
		SELECT
			ID
		FROM
			teamdetails
		WHERE
			LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
			AND TeamID = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
			AND OrdinalID = <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
	</cfquery>
	<cfset ThisTeamDetailsID = QThisTeamDetails.ID >
	<!--- snapshot before --->
	<cfinclude template="qry_QTeamDetailsBefore.cfm">
</cfif>

<cfquery name="UpdateTeamDetails" datasource="#request.DSN#" >
	UPDATE
		teamdetails
	SET
		<cfif RIGHT(request.dsn,4) GE 2012 AND ListFind("Silver,Skyblue",request.SecurityLevel) >
			VenueID = #Form.VenueID# ,
			PitchNoID = #Form.PitchNoID# ,
		</cfif>
		ShirtColour1           =  '#TRIM(Form.ShirtColour1)#',
		ShortsColour1          =  '#TRIM(Form.ShortsColour1)#',		
		SocksColour1           =  '#TRIM(Form.SocksColour1)#',		
		ShirtColour2           =  '#TRIM(Form.ShirtColour2)#',
		ShortsColour2          =  '#TRIM(Form.ShortsColour2)#',		
		SocksColour2           =  '#TRIM(Form.SocksColour2)#',
		<!---
		URLTeamWebsite         =  '#TRIM(Form.URLTeamPhoto)#',
		URLTeamPhoto           =  '#TRIM(Form.URLTeamPhoto)#',
		--->
		Contact1Name           =  '#TRIM(Form.Contact1Name)#',
		Contact1JobDescr       =  '#TRIM(Form.Contact1JobDescr)#',
		Contact1Address        =  '#TRIM(Form.Contact1Address)#',
		Contact1TelNo1         =  '#TRIM(Form.Contact1TelNo1)#',
		Contact1TelNo1Descr    =  '#TRIM(Form.Contact1TelNo1Descr)#',
		Contact1TelNo2         =  '#TRIM(Form.Contact1TelNo2)#',
		Contact1TelNo2Descr    =  '#TRIM(Form.Contact1TelNo2Descr)#',
		Contact1TelNo3         =  '#TRIM(Form.Contact1TelNo3)#',
		Contact1TelNo3Descr    =  '#TRIM(Form.Contact1TelNo3Descr)#',
		Contact1Email1         =  '#Replace(Replace(TRIM(Form.Contact1Email1),",","","All")   ,";","","All")#',
		Contact1Email2         =  '#Replace(Replace(TRIM(Form.Contact1Email2),",","","All")   ,";","","All")#',
		Contact2Name           =  '#TRIM(Form.Contact2Name)#',
		Contact2JobDescr       =  '#TRIM(Form.Contact2JobDescr)#',
		Contact2Address        =  '#TRIM(Form.Contact2Address)#',
		Contact2TelNo1         =  '#TRIM(Form.Contact2TelNo1)#',
		Contact2TelNo1Descr    =  '#TRIM(Form.Contact2TelNo1Descr)#',
		Contact2TelNo2         =  '#TRIM(Form.Contact2TelNo2)#',
		Contact2TelNo2Descr    =  '#TRIM(Form.Contact2TelNo2Descr)#',
		Contact2TelNo3         =  '#TRIM(Form.Contact2TelNo3)#',
		Contact2TelNo3Descr    =  '#TRIM(Form.Contact2TelNo3Descr)#',
		Contact2Email1         =  '#Replace(Replace(TRIM(Form.Contact2Email1),",","","All")   ,";","","All")#',
		Contact2Email2         =  '#Replace(Replace(TRIM(Form.Contact2Email2),",","","All")   ,";","","All")#',
		Contact3Name           =  '#TRIM(Form.Contact3Name)#',
		Contact3JobDescr       =  '#TRIM(Form.Contact3JobDescr)#',
		Contact3Address        =  '#TRIM(Form.Contact3Address)#',
		Contact3TelNo1         =  '#TRIM(Form.Contact3TelNo1)#',
		Contact3TelNo1Descr    =  '#TRIM(Form.Contact3TelNo1Descr)#',
		Contact3TelNo2         =  '#TRIM(Form.Contact3TelNo2)#',
		Contact3TelNo2Descr    =  '#TRIM(Form.Contact3TelNo2Descr)#',
		Contact3TelNo3         =  '#TRIM(Form.Contact3TelNo3)#',
		Contact3TelNo3Descr    =  '#TRIM(Form.Contact3TelNo3Descr)#',
		Contact3Email1         =  '#Replace(Replace(TRIM(Form.Contact3Email1),",","","All")   ,";","","All")#',
		Contact3Email2         =  '#Replace(Replace(TRIM(Form.Contact3Email2),",","","All")   ,";","","All")#',
		<cfif StructKeyExists(form, "ShowHideContact1Address")>
			ShowHideContact1Address  =  1,
		<cfelse>
			ShowHideContact1Address  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact2Address")>
			ShowHideContact2Address  =  1,
		<cfelse>
			ShowHideContact2Address  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact3Address")>
			ShowHideContact3Address  =  1,
		<cfelse>
			ShowHideContact3Address  =  0,
		</cfif>
		
		<cfif StructKeyExists(form, "ShowHideContact1TelNo1")>
			ShowHideContact1TelNo1  =  1,
		<cfelse>
			ShowHideContact1TelNo1  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact2TelNo1")>
			ShowHideContact2TelNo1  =  1,
		<cfelse>
			ShowHideContact2TelNo1  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact3TelNo1")>
			ShowHideContact3TelNo1  =  1,
		<cfelse>
			ShowHideContact3TelNo1  =  0,
		</cfif>
		
		<cfif StructKeyExists(form, "ShowHideContact1TelNo2")>
			ShowHideContact1TelNo2  =  1,
		<cfelse>
			ShowHideContact1TelNo2  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact2TelNo2")>
			ShowHideContact2TelNo2  =  1,
		<cfelse>
			ShowHideContact2TelNo2  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact3TelNo2")>
			ShowHideContact3TelNo2  =  1,
		<cfelse>
			ShowHideContact3TelNo2  =  0,
		</cfif>

		<cfif StructKeyExists(form, "ShowHideContact1TelNo3")>
			ShowHideContact1TelNo3  =  1,
		<cfelse>
			ShowHideContact1TelNo3  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact2TelNo3")>
			ShowHideContact2TelNo3  =  1,
		<cfelse>
			ShowHideContact2TelNo3  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact3TelNo3")>
			ShowHideContact3TelNo3  =  1,
		<cfelse>
			ShowHideContact3TelNo3  =  0,
		</cfif>
		
		<cfif StructKeyExists(form, "ShowHideContact1Email1")>
			ShowHideContact1Email1  =  1,
		<cfelse>
			ShowHideContact1Email1  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact2Email1")>
			ShowHideContact2Email1  =  1,
		<cfelse>
			ShowHideContact2Email1  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact3Email1")>
			ShowHideContact3Email1  =  1,
		<cfelse>
			ShowHideContact3Email1  =  0,
		</cfif>
		
		<cfif StructKeyExists(form, "ShowHideContact1Email2")>
			ShowHideContact1Email2  =  1,
		<cfelse>
			ShowHideContact1Email2  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact2Email2")>
			ShowHideContact2Email2  =  1,
		<cfelse>
			ShowHideContact2Email2  =  0,
		</cfif>
		<cfif StructKeyExists(form, "ShowHideContact3Email2")>
			ShowHideContact3Email2  =  1
		<cfelse>
			ShowHideContact3Email2  =  0
		</cfif>
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TeamID = <cfqueryparam value = #ThisTeamID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
		AND OrdinalID = <cfqueryparam value = #ThisOrdinalID# cfsqltype="CF_SQL_INTEGER" maxlength="8">
</cfquery>

<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012 <!---AND ListFind("Yellow",request.SecurityLevel)---> >
	<!--- snapshot after --->
	<cfinclude template="qry_QTeamDetailsAfter.cfm">
</cfif>

<!--- applies to season 2012 onwards only --->
<cfif RIGHT(request.dsn,4) GE 2012 <!---AND ListFind("Yellow",request.SecurityLevel)---> >
	<!--- check for any changes --->
	<cfloop index = "ListElement" list = "ID,VenueID,PitchNoID,ShirtColour1,ShortsColour1,SocksColour1,ShirtColour2,ShortsColour2,SocksColour2,URLTeamWebsite,URLTeamPhoto,Contact1Name,Contact1JobDescr,Contact1Address,Contact1TelNo1,Contact1TelNo1Descr,Contact1TelNo2,Contact1TelNo2Descr,Contact1TelNo3,Contact1TelNo3Descr,Contact1Email1,Contact1Email2,Contact2Name,Contact2JobDescr,Contact2Address,Contact2TelNo1,Contact2TelNo1Descr,Contact2TelNo2,Contact2TelNo2Descr,Contact2TelNo3,Contact2TelNo3Descr,Contact2Email1,Contact2Email2,Contact3Name,Contact3JobDescr,Contact3Address,Contact3TelNo1,Contact3TelNo1Descr,Contact3TelNo2,Contact3TelNo2Descr,Contact3TelNo3,Contact3TelNo3Descr,Contact3Email1,Contact3Email2,ShowHideContact1Address,ShowHideContact2Address,ShowHideContact3Address,ShowHideContact1TelNo1,ShowHideContact2TelNo1,ShowHideContact3TelNo1,ShowHideContact1TelNo2,ShowHideContact2TelNo2,ShowHideContact3TelNo2,ShowHideContact1TelNo3,ShowHideContact2TelNo3,ShowHideContact3TelNo3,ShowHideContact1Email1,ShowHideContact2Email1,ShowHideContact3Email1,ShowHideContact1Email2,ShowHideContact2Email2,ShowHideContact3Email2">
		<cfscript>
			ThisFieldName = "#ListElement#" ;
			BeforeValue = "QTeamDetailsBefore.#ThisFieldName#" ;
			BeforeValue = Evaluate(BeforeValue);
			AfterValue = "QTeamDetailsAfter.#ThisFieldName#" ;
			AfterValue = Evaluate(AfterValue);
			SecurityLevel = "#MID(request.SecurityLevel,4,1)#";
		</cfscript>
		<cfif BeforeValue IS NOT AfterValue >
			<cfinclude template="ins_TeamDetailsUpdateLog.cfm">
		</cfif>
	</cfloop>
</cfif>
