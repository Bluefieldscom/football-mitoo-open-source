<cfset variables.robotindex="no">

<cfsilent>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
</cfsilent>
<!--- include toolbar.cfm--->
<cfinclude template="InclBegin.cfm">

<cfset ThisSecurityLevel = "White"> <!--- Jan 09: Terry's suggestion to use a default ThisSecurityLevel of white(?) on the page. --->
<form action="SecurityCheck.cfm" method="post" >
<!--- Please note that the action is directed back to the invoking form, i.e. SecurityCheck.cfm
so we will be using a State Vector to indicate progress through the sequence of events --->

<cfif NOT StructKeyExists(form, "StateVector" )>
	<!---
	***************************************************************************************************
	* first time in , StateVector does not exist, user is presented with the name and password screen *
	***************************************************************************************************
	--->
	<cfoutput>
	<input type="hidden" name="StateVector" value="1">
	<input type="hidden" name="LeagueCode" value="#LeagueCode#">
	</cfoutput>
	<table width="100%" border="0" cellspacing="5" cellpadding="5">
		<tr>
			<td colspan="5" align="center">
				<span class="pix14bold">Your name</span>
				<input type="Text" name="name"  size="15" maxlength="20">
			</td>
		</tr>
		<tr>
			<td colspan="5" align="center">
				<span class="pix14bold">Password</span>
				<input type="Password" name="password"  size="15" maxlength="15" >
			</td>
		</tr>
			<tr>
				<td colspan="2" width="45%"></td>

      <td align="center"><input type="Submit" name="Operation2" value="OK"></td>
				<td colspan="2" width="45%"></td>
			</tr>

    <tr>
	  <td colspan="5" align="center"> <span class="pix10"> With <em>football.mitoo</em>
        having grown tremendously over the past ten years we have been asked by
        the UK Data Commissioner to ask our users with editing rights to review
        our <a href="TermsAndConditions2011-01-07.htm" target="_blank"><strong>terms
        and conditions</strong></a>. <br>
        <br>
We do not intend to change any of the workings of <em>football.mitoo</em> and the site will continue to run in exactly the same way as it has done for the past ten years.
<br><br>
The terms and conditions state that the editors of <em>football.mitoo</em> (yourselves) assume consent from those about whom you are posting data.
<br><br>
<em>football.mitoo</em> has never and will never sell or give away any of your information. Your data is safe with us. 	</span>
	</td>

	</tr>
	<tr>
		<td colspan="5" align="center"><span class="pix9">MY BROWSER: <cfoutput>#cgi.http_user_agent#</cfoutput></span></td>
	</tr>
	</table>

<cfelseif form.StateVector IS "1">
	<INPUT TYPE="HIDDEN" NAME="LEAGUECODE" VALUE="<cfoutput>#LeagueCode#</cfoutput>">
	<!---
	*************************************************************************************************************
	* second time in , StateVector is "1", user has just clicked on OK button, having entered name and password *
	*************************************************************************************************************
	--->
	<!---
											****************************
											* Maintenance Override     *
											* Prevent user Logging In  *
											****************************
	--->
	<cfset DoingMaintenance = "No"> <!---  Julian, set DoingMaintenance = "Yes" or "No" --->

	<!--- Log out to basic public security level i.e. White --->
	<cfset request.SecurityLevel = "White" >
	<cfset request.ThisLeaguesList = "">
	<cflock scope="session" timeout="10" type="exclusive">
		<cfset session.SecurityLevel = request.SecurityLevel >
		<cfset session.ThisLeaguesList = request.ThisLeaguesList >
		<cfif StructKeyExists(session, "LeagueCodePrefix") >
			<cfset request.LeagueCodePrefix = session.LeagueCodePrefix >
		<cfelse>
			<cfset request.LeagueCodePrefix = "" >
		</cfif>
	</cflock>

	<cfif DoingMaintenance IS "Yes">
		<cfset LondonTime = "15.45 hrs London Time">  <!---  Julian, set the time it starts --->
		<link href="fmstyle.css" rel="stylesheet" type="text/css">
		<br /><img src="mitoo_logo1.png" alt="fmlogo" border="0"><br /><br />
		<span class="pix24boldred"><cfoutput>#DateFormat( Now() , "DDDD, DD MMMM YYYY")#</cfoutput><br /></span>
		<span class="pix18bold"><br /><br /><cfoutput>#LondonTime#</cfoutput><br /><br />
		We are doing some site maintenance so you are not allowed to Log In at the moment.<br />
		Normal service should be resumed as soon as possible.<br /><br />Thanks for your patience<br /><br />Julian<br />
		<br />Click on the Back button on your browser to continue.....<br /><br />
		<cfabort>
	<cfelse>
		<cfset StephenHosmerLeaguesList = "MDX,CCFL,SCCC,MCFA,MCYFA,MDXS">
		<cfset BobLangleyLeaguesList = "MDX,CHIS,LCOM,MDXS">
		<cfset BobMorrisonLeaguesList = "HYFL,HSSC">
		<cfset DavidMayesLeaguesList = "ECFL,ECYL,SIFL">
		<cfset DaveBakerLeaguesList = "LSER,GLW,HGFL">
		<cfset TonyPringleLeaguesList = "HOC,ECYL,EJCUP,ECFL,SIFL,ANGLC,CMBS,NPL">
		<cfset PaulMurphyLeaguesList = "ECRNW,CWFL,WCSFL"> <!---Paul Murphy (Acting Referees Appointments Officer) Cornwall County FA --->
		<cfset WarrenMcMahonLeaguesList = "MDX,MDXS">
		<cfset DaveLumleyLeaguesList = "EMCFL,LEICS">
		<cfset IanLeonardLeaguesList = "PWDC1,PWDC7">
		<cfset PeterRobertLeaguesList = "STHRN,ISTH,UCL">
		<cfset ElaineWaumsleyLeaguesList = "SMID,SMFC">


		<cfset DTStamp = CreateODBCDateTime(Now())> <!--- DateTimeStamp --->

		<cfinclude template="queries/qry_QJABPWD.cfm">
		<!--- This query gets the password, JABPWD --->

		<cfinclude template="queries/qry_QThisPWD.cfm">
		<!--- This query gets the password, ThisPWD, for the current LeagueCodePrefix from table identity in zmast
			   There is just one password across all seasons because we look at the prefix only.
			   It also gets the short three character password PWD3
			   NEW: it also gets cfmpwd and cfmlist
				which were added just for the North West Counties Football League  (John Deal requested it) so a person could update Team Sheets only
				without needing to log in as each club separateley, the log in SecurityLevel is Orange
		--->
		<!--- CASE 1: user enters a name of three characters or more and also a correct password --->
		<cfif Len(Trim(form.name)) GREATER THAN 2 AND Compare( form.password , ThisPWD ) IS 0  >
			<cfinclude template="queries/qry_QPWDInsert1.cfm">
			<cfset ThisSecurityLevel = "Skyblue">
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.PWD3 = ThisPWD3 >
				<cfset session.SecurityLevel = ThisSecurityLevel >
			</cflock>

		<!--- CASE 2: Julian enters no name and his master password --->
		<cfelseif Len(Trim(form.name)) IS 0 AND Compare( form.password , JABPWD ) IS 0  >
			<cfinclude template="queries/qry_QPWDInsert2.cfm">
			<cfset ThisSecurityLevel = "Silver">
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.PWD3 = ThisPWD3 >
				<cfset session.SecurityLevel = ThisSecurityLevel >
			</cflock>
	
		<!--- CASE 4: Short three character password used and logged in successfully to see reports in yellow menu --->
		<cfelseif Len(Trim(form.name)) GREATER THAN 2 AND Len(Trim(form.password)) IS 3 >
			<cfif CompareNoCase( form.password , ThisPWD3 ) IS 0  >
				<cfset ThisSecurityLevel = "Yellow">
				<cflock scope="session" timeout="10" type="exclusive">
					<cfset session.PWD3 = ThisPWD3 >
					<cfset session.SecurityLevel = ThisSecurityLevel >
				</cflock>
			</cfif>
			<cfinclude template="queries/qry_QPWDInsert4.cfm">

		<!--- CASE 5: user enters a name of three characters or more and also a correct cfmpwd --->
		<cfelseif Len(Trim(form.name)) GREATER THAN 2 AND Len(Trim(form.password)) GREATER THAN 6 AND Compare( form.password , QPWDThisLeague.cfmpwd ) IS 0  >
			<cfinclude template="queries/qry_QPWDInsert1.cfm">
			<cfset ThisSecurityLevel = "Orange">
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.PWD3 = ThisPWD3 >
				<cfset session.SecurityLevel = ThisSecurityLevel >
				<cfset session.CFMList = QPWDThisLeague.cfmlist >
			</cflock>

		<!--- CASE 6: Log all unsuccessful attempts, including people who have a partial password and want to see reports.... --->
		<cfelseif Len(Trim(form.name)) GREATER THAN 2 AND Len(Trim(form.password)) GREATER THAN 2 >
			<cfset ThisSecurityLevel = "White">
			<cflock scope="session" timeout="10" type="exclusive">
					<cfset session.PWD3 = ThisPWD3 >
					<cfset session.SecurityLevel = ThisSecurityLevel >
			</cflock>
			<cfinclude template="queries/qry_QPWDInsert4.cfm">

		<cfelse>
			<cfset ThisSecurityLevel = "White">
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.PWD3 = ThisPWD3 >
					<cfset session.SecurityLevel = ThisSecurityLevel >
			</cflock>
		</cfif>
	</cfif>

	<cfif ListFind("Silver,Skyblue,Orange,Yellow",ThisSecurityLevel) >
		<!--- Let's see if user has previously agreed to the Terms and Conditions --->
			<cfquery name="QTCAgreed" datasource="zmast">
				SELECT
					ID,
					UserName
				FROM
					tcagreed
				WHERE
					LeagueCodePrefix = '#request.LeagueCodePrefix#'
					AND UserName = '#Trim(form.name)#'
					AND Passwd = '#form.password#'
			</cfquery>
		<!---
		Yes, user has already agreed to Terms and Conditions
		--->
		<cfif QTCAgreed.RecordCount IS 1>
			<cflocation url="News.cfm?LeagueCode=#LeagueCode#&NB=0" ADDTOKEN="NO">
		<!---
		No, user has to agree to Terms and Conditions
		--->
		<cfelseif QTCAgreed.RecordCount IS 0>
			<cfoutput>
			<input type="hidden" name="StateVector" value="2">
			<input type="hidden" name="Name" value="#Trim(form.name)#">
			<input type="hidden" name="Password" value="#form.password#">
			<input type="hidden" name="DTStamp" value="#DTStamp#">
			<input type="hidden" name="ThisLeagueCodePrefix" value="#request.LeagueCodePrefix#">
			<input type="hidden" name="ThisPWD3" value="#ThisPWD3#">

			</cfoutput>
			<table width="100%" border="0" cellspacing="5" cellpadding="5">
				<tr>
					<td colspan="5" align="center">
						<span class="pix10bold">Please <a href="TermsAndConditions2011-01-07.htm" target="_blank">click here</a> to read the Terms and Conditions.</span>
					</td>
				</tr>
				<tr>
					<td width="40%"></td>
					<td><span class="pix10bold">I accept the Terms and Conditions</span></td>
					<td align="center">
					<input type="Submit" name="Operation" value="Yes">
					</td>
					<td align="center">
					<input type="Submit" name="Operation" value="No">
					</td>
					<td width="40%"></td>
				</tr>
			</table>
		<cfelse>
			<cfoutput>QTCAgreed.RecordCount is #QTCAgreed.RecordCount#. UserName is #QTCAgreed.UserName#. Error in SecurityCheck.cfm</cfoutput>
			<cfabort>
		</cfif>
	<cfelse>
		<cflocation url="News.cfm?LeagueCode=#LeagueCode#&NB=0" ADDTOKEN="NO">
	</cfif>
<cfelseif form.StateVector IS "2">


	<cfif form.operation IS "Yes">
	<!--- user has just agreed to the Terms and Conditions so insert a record of this --->
		<cfquery name="InsertTCAgreed" datasource="zmast">
			INSERT INTO
				tcagreed
				(DATETIMESTAMP,
				LEAGUECODEPREFIX,
				USERNAME,
				PASSWD)
			VALUES
				(#form.DTStamp#,
				'#form.ThisLeagueCodePrefix#',
				'#form.Name#',
				'#form.Password#')
		</cfquery>
		<cflocation url="News.cfm?LeagueCode=#LeagueCode#&NB=0" ADDTOKEN="NO">

	<cfelse>
			<cfset ThisSecurityLevel = "White">
			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.PWD3 = form.ThisPWD3 >
				<cfset session.SecurityLevel = ThisSecurityLevel >
			</cflock>
		<cflocation url="News.cfm?LeagueCode=#LeagueCode#&NB=0" ADDTOKEN="NO">
	</cfif>
</cfif>
</form>
