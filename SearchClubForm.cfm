<cfset ListingClubs = "Yes">					<!--- Introduce paging April. 2001 --->
<cfinclude template="InclBegin.cfm">

<cfoutput>
	<FORM ACTION="SearchClubForm.cfm?LeagueCode=#LeagueCode#" METHOD="POST">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="CENTER">
			<tr align="CENTER">
				<td height="50" colspan="2">
					<span class="pix10">
					Enter a word, or part of a word, that appears in the club's name.<br />
					Please select another season if you wish to search there.
					</span>
				</td>
			</tr>
			<tr>
				<td align="CENTER" colspan="2">
					<input type="Text" name="srchstring"
					<cfif StructKeyExists(form, "srchstring") >value="#TRIM(srchstring)#"</cfif>
						size="20" maxlength="30">
					<input type="Submit" name="SubmitButton" value="Search all clubs in <cfoutput>#SeasonName#</cfoutput>" >
				</td>
			</tr>	  
		</table>
		<input type="Hidden" NAME="LeagueCode" VALUE="#LeagueCode#">
	</FORM>
</cfoutput>

<cfif StructKeyExists(form, "srchstring") or StructKeyExists(url, "srchstring") >

	<cfif LEN(TRIM(srchstring)) LE 3 >
		The search word is too short
		<cfabort>
	</cfif>
	<cfinclude template = "queries/qry_QClubSearchTeam.cfm">
	<cfoutput>
		<cfif QSearchTeam.RecordCount GT 200>
			<span class="pix13"><strong>#QSearchTeam.RecordCount# found. Please be more specific.</strong></span>
			<cfabort>
		<cfelseif QSearchTeam.RecordCount GT 0>
			<span class="pix13"><strong>#QSearchTeam.RecordCount# found</strong></span>
		<cfelse>
			<span class="pix13"><strong>#srchstring# not found</strong></span>
			<cfabort>
		</cfif>
	</cfoutput>
	<table width="100%" border="0" cellspacing="2" cellpadding="2" align="CENTER">
	<cfoutput query="QSearchTeam" group="ClubName" >
		<tr>
			<td width="30%"><span class="pix13">#ClubName#</span></td>
			<td width="70%"><span class="pix13"></span></td>
		</tr>
		<cfoutput group="shortcol" >
			<cfif shortcol IS 'Guest'>
				<tr>
					<td width="20%"><span class="pix13"></span></td>
					<td width="80%"><span class="pix10italic"><br>as Guest ... </span></td>
				</tr>
			</cfif>
		<cfoutput>
			<tr>
				<td width="10%" align="right"><span class="pix10"><a href="ClubList.cfm?fmTeamID=#fmTeamID#&LeagueCode=#ThisLeagueCode##right(request.DSN,4)#" target="_blank">look</a></span></td>
				<td  width="90%">
					<cfif shortcol IS 'Guest'>
						<span class="pix10italic">#LeagueName#</span>
					<cfelse>
						<span class="pix10">#LeagueName#</span>
					</cfif>
				</td>
			</tr>
		</cfoutput>
		</cfoutput>
		<tr>
			<td width="100%" colspan="2" bgcolor="white"></td>
		</tr>
	</cfoutput>
	</table>
</cfif>