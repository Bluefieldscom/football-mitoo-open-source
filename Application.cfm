<cfsilent>

<cfapplication name="Football"
               clientmanagement="no"
               sessionmanagement="yes"
			   setclientcookies="yes"
			   setdomaincookies="yes"
			   sessiontimeout="#CreateTimeSpan(0,0,29,5)#"
			   applicationtimeout="#CreateTimeSpan(1,0,0,0)#"    >

<cfif 1 IS 1 > <!--- <=============== Set to 2 when excluding users --->
	<!--- Carry on...... --->
<cfelse>
	<CFLOCATION url="Suspended.html" ADDTOKEN="NO">
</cfif>

<!--- If you just want to prevent users from logging in to prevent database updates
look at SecurityCheck.cfm and set DoingMaintenance = "No" --->
<!---
<cfset MitooComSeasonRangeStart="2008">
<cfset MitooComSeasonRangeEnd="2012">
--->
<cfset CopyrightYear = "2014">
<cfset UKLocale = SetLocale("English (UK)")>
<cfset Font_Face = "Verdana, Arial, Helvetica" >
<!--- Colours set for use throughout the application --->

<!--- Used for highlighting a Club and a County F.A. Hue 111, Sat 228 Lum 221, Red 216 Green 254 Blue 245--->
<cfset BG_Highlight = "FED8D8" >
<!---<cfset BG_Highlight = "82FDE1" >--->
<!--- Used for highlighting a Referees' Association Hue 41, Sat 239 Lum 219, Red 254 Green 255 Blue 210--->
<cfset BG_Highlight2 = "FEFFD2" >
<!---<cfset BG_Highlight = "82FDE1" >--->

<cfset BG_Color2 = "B8FEF5">
<cfset BG_originalcolor = "D8FEF5">


<!--- Set Session Variables --->
<cflock scope="session" timeout="10" type="exclusive">
	<!--- check status of session.IsInitialized --->
	<cfset request.IsInitialized = StructKeyExists(session, "IsInitialized")>
	<!--- "No" if first time in, "Yes" if in mid session --->
</cflock>

<cfif NOT request.IsInitialized> <!--- first time in --->
	<!--- check again just to be sure --->
	<cfif NOT StructKeyExists(session, "IsInitialized")>
		<cflock scope="session" timeout="10" type="exclusive" >
			<cfset session.SecurityLevel = "White"> <!--- no update rights, public level --->
<!--- this is the current league code prefix that is being updated  --->
			<cfset session.CurrentLeagueCodePrefix = "">
			<cfset session.CurrentLeagueCode = "">
<!---  Yellow League Reports Menu three character password --->
			<cfset session.PWD3 = "xxx" >
<!--- current Team ID used to highlight this team in tables etc --->
			<cfset session.fmTeamID = 0 >
			<cfset session.County = "LondonMiddx">
			<cfset session.RefsID = 0 >
			<cfset session.RefMarksOutOfHundred = "No" >
			<cfset session.SportsmanshipMarksOutOfHundred = "0" >
			<cfset session.SeeOppositionTeamSheet = "0" >
			<cfset session.RefereeMarkMustBeEntered = "0" >
			<cfset session.spare01 = "0" >
			<cfset session.spare02 = "0" >
			<cfset session.HideDoubleHdrMsg = "0" >
			<cfset session.RefereeLowMarkWarning = 0 >			
			<cfset session.LeagueType = "Normal" >
			<cfset session.fmPlayerID = 0 >
			<cfset session.SeasonStartDate = DateFormat(Now(), "YYYY-MM-DD") >
			<cfset session.SeasonEndDate = DateFormat(Now(), "YYYY-MM-DD") >
			<cfset session.IsInitialized = true>
			<cfset session.DropDownTeamName = "">
			<cfset session.DropDownRefereeName = "">
			<cfset session.DropDownTeamID = 0 >
			<cfset session.DropDownRefereeID = 0 >
			<cfset session.YellowKey = "" >
			<cfset session.EmailAddr = "">
			<cfset session.ThisLeaguesList = "">
		</cflock>
	</cfif>
</cfif>

<cflock scope="session" timeout="10" type="readonly">
	<cfset request.SecurityLevel = session.SecurityLevel >
	<cfset request.CurrentLeagueCodePrefix = session.CurrentLeagueCodePrefix >
	<cfset request.CurrentLeagueCode = session.CurrentLeagueCode >
	<cfset request.PWD3 = session.PWD3 >
	<cfset request.fmTeamID = session.fmTeamID >
	<cfset request.County = session.County >
	<cfset request.DropDownTeamName = session.DropDownTeamName >
	<cfset request.DropDownRefereeName = session.DropDownRefereeName >
	<cfset request.DropDownTeamID = session.DropDownTeamID >
	<cfset request.DropDownRefereeID = session.DropDownRefereeID >
	<cfset request.YellowKey = session.YellowKey >
	<cfset request.EmailAddr = session.EmailAddr >
	<cfset request.ThisLeaguesList = session.ThisLeaguesList >
</cflock>

<cfset request.xpath = GetDirectoryFromPath(ExpandPath("application.cfm")) >

<!--- remove 500 errors produced by lack of URL.LeagueCode or FORM.LeagueCode --->
<!--- these pages do NOT require LeagueCode --->
<cfset ExemptList = "testadverts.cfm,index.cfm,fmMap.cfm,counties.cfm,help.cfm,about.cfm,listofleagues.cfm,TopCounts.cfm,whatusay.cfm,test_cal.cfm,noticeboard.cfm,XMLCounty.cfm,XMLLeague.cfm,XMLCompetition.cfm,XMLLeagueTable.cfm,webServices.cfc,xxx.cfm">

<cfif NOT Replace(CGI.path_translated,request.xpath, "") EQ "webServices.cfc">
	<cfif StructIsEmpty(URL)
		AND StructIsEmpty(FORM)
		AND ListFindNoCase(ExemptList,Replace(CGI.path_translated,request.xpath, "")) IS 0>
		<!--- <cfif ListFindNoCase(ExemptList,Replace(CGI.path_translated,request.xpath, "")) IS 0> --->
			<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="No">
			<cfabort>
	</cfif>
</cfif>

<!--- 	new section to prevent errors when second query string attached
		like '?ts-cache-632428819617391200 HTTP/1.1'
		which causes an error with cfqueryparam --->
<cfif NOT StructIsEmpty(URL)>
	<!--- loop through key values and find '?' --->
	<cfset URLKeyArray = StructKeyArray(URL)>
	<cfloop index="i" from="1" to="#ArrayLen(URLKeyArray)#">
		<cfif Find("?",URL[URLKeyArray[i]])>
			<!--- if found, create new value without offending string --->
			<cfset thisKeyValue = URL[URLKeyArray[i]]>
			<cfset URL_NewKeyValue = ListFirst(thisKeyValue,"?")>
			<!--- update Structure with new value --->
			<cfset StructUpdate(URL, URLKeyArray[i],URL_NewKeyValue)>
		</cfif>
	</cfloop>
</cfif>
<!--- end new --->

<cfif NOT StructIsEmpty(URL)
	AND NOT StructKeyExists(url, "LeagueCode")
	AND NOT StructKeyExists(url, "amp;LeagueCode")
	AND ListFindNoCase(ExemptList,Replace(CGI.path_translated,request.xpath, "")) IS 0>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="No">
		<cfabort>
</cfif>

<cfif StructKeyExists(url, "LeagueCode")>
	<cfset request.LeagueCode = url.LeagueCode >
	<cfif IsNumeric(RIGHT(request.LeagueCode,4))>
		<cfset request.DSN = 'fm' & RIGHT(request.LeagueCode,4)>
		<cfset request.filter = Left(request.LeagueCode, (Len(TRIM(request.LeagueCode))-4))>
   	<cfelse>
		<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
		<cfabort>
   	</cfif>
</cfif>

<cfif NOT Replace(CGI.path_translated,request.xpath, "") EQ "webServices.cfc">
	<cfif StructKeyExists(form, "LeagueCode")>
		<cfset request.LeagueCode = form.LeagueCode>
		<cfif IsNumeric(RIGHT(request.LeagueCode,4))>
			<cfset request.DSN = 'fm' & RIGHT(request.LeagueCode,4)>
			<cfset request.filter = Left(request.LeagueCode, (Len(TRIM(request.LeagueCode))-4))>
	   	<cfelse>
			<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
			<cfabort>
	   	</cfif>
	</cfif>
</cfif>

<cfif NOT StructKeyExists(request, "filter")>
	<cfset request.filter = "">
</cfif>
<cfif NOT StructKeyExists(request, "LeagueCode")>
	<cfset request.LeagueCode = "">
</cfif>
<!--- 
for Skyblue or Yellow security levels then LeagueCodePrefix must not be altered 
because password is only valid for the specific LeagueCodePrefix 
unless it is a multi site user with a valid leaguecode prefix 
--->

<cfif request.CurrentLeagueCodePrefix IS NOT request.filter >
	<cfif ListFind("Silver",request.SecurityLevel) >
	<!--- NEW: 12th December 2012 Skyblue maintained across sites if multi site administrator --->
	<cfelseif ListFind("Skyblue",request.SecurityLevel) AND ListFindNoCase(request.ThisLeaguesList, request.filter) GT 0 >
	<cfelse>
		<cfset request.SecurityLevel = "White" >
		<cfset StructDelete(session, "fmView")>
		<cfset StructDelete(session, "fmEmail")>
	</cfif>
</cfif>

<cfif request.CurrentLeagueCode IS NOT request.LeagueCode>
	<cfset request.fmTeamID = 0 >
</cfif>

<cfset request.CurrentLeagueCodePrefix = request.filter >
<cfset request.CurrentLeagueCode = request.LeagueCode >
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.SecurityLevel = request.SecurityLevel >
	<cfset session.CurrentLeagueCodePrefix = request.CurrentLeagueCodePrefix >
	<cfset session.CurrentLeagueCode = request.CurrentLeagueCode >
	<cfset session.fmTeamID = request.fmTeamID >
	<cfset session.ThisLeaguesList = request.ThisLeaguesList >
</cflock>

<cfsetting showdebugoutput="no">

</cfsilent>
<!--- <cfdump var="#request#">  --->
