<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cfif>


<cfset variables.robotindex="no">
<cfset finishPage = 1>
<cfif StructKeyExists(url, "fmTeamID")>
		<cfset request.fmTeamID = url.fmTeamID>
</cfif>
<cfset ThisColSpan = 8 >
<cfinclude template="InclBegin.cfm">
	<cfset ThisDate = DateFormat(MDate, 'YYYY-MM-DD')>
	<!--- check for double headers, create a list of fixture ids that are double headers --->
	<cfinclude template="queries/qry_DoubleHeader.cfm">
	<cfset DHList = ValueList(QDoubleHeader.ID)>
	
	<cfif StructKeyExists(form, "Operation")>
		<cfif form.Operation IS "Update Appointments">
			<cfloop index="i" from="1" to="#form.RCount#">
				<cfset ThisFixtureID = "form.fid#i#">
				<cfset ThisFixtureID = Evaluate(ThisFixtureID)>

				<cfset ThisKOTime = "form.KOTime#i#">
				<cfset ThisKOTime = Evaluate(ThisKOTime)>
				<cfif Find('.',ThisKOTime)>
					<cfoutput>
					<span class="pix18red">
					In line #i# you entered <b>#ThisKOTime#</b> for the KO time but this is not in the correct format.<br>It should be like <b>10:30</b> or <b>15:00</b> or <b>7:30 PM</b> or <b>11AM</b>
					</span>
					<br><br><br>
					<span class="pix18">
					Please click on the "Back" button of your browser to correct this ....
					</span>
					</cfoutput> 
					<cfabort>
				</cfif>
				
				<cfif len(trim(ThisKOTime)) GT 0 AND NOT isValid("time", ThisKOTime)>
					<cfoutput>
					<span class="pix18red">
					In line #i# you entered <b>#ThisKOTime#</b> for the KO time but this is not in the correct format.<br>It should be like <b>10:30</b> or <b>15:00</b> or <b>7:30 PM</b> or <b>11AM</b>
					</span>
					<br><br><br>
					<span class="pix18">
					Please click on the "Back" button of your browser to correct this ....
					</span>
					</cfoutput> 
					<cfabort>
				</cfif>
				
				<cfset ThisKOTime = TimeFormat(ThisKOTime, 'HH:mm:ss')>
				<cfif NOT StructKeyExists( form, "RefID#i#")>
					<cfset ThisRefereeID = ListGetAt(form.RefsIDList,i) >
					<cfinclude template="queries/qry_RefsName.cfm">
					<cfoutput query="RefInfo"><span class="pix24boldred">#RefsName# is unavailable ... Please click on the Back button of your browser</span></cfoutput> 
					<cfabort>
				</cfif>
				<cfset ThisRefereeID = "form.RefID#i#">
				<cfset ThisRefereeID = Evaluate(ThisRefereeID) >
				
				<cfif NOT StructKeyExists( form, "AR1ID#i#")>
					<cfset ThisRefereeID = ListGetAt(form.AR1IDList,i) >
					<cfinclude template="queries/qry_RefsName.cfm">
					<cfoutput query="RefInfo"><span class="pix24boldred">#RefsName# is unavailable ... Please click on the Back button of your browser</span></cfoutput> 
					<cfabort>
				</cfif>
				<cfset ThisAsstRef1ID = "form.AR1ID#i#">
				<cfset ThisAsstRef1ID = Evaluate(ThisAsstRef1ID) >
				
				<cfif NOT StructKeyExists( form, "AR2ID#i#")>
					<cfset ThisRefereeID = ListGetAt(form.AR2IDList,i) >
					<cfinclude template="queries/qry_RefsName.cfm">
					<cfoutput query="RefInfo"><span class="pix24boldred">#RefsName# is unavailable ... Please click on the Back button of your browser</span></cfoutput> 
					<cfabort>
				</cfif>
				
				<cfset ThisAsstRef2ID = "form.AR2ID#i#">
				<cfset ThisAsstRef2ID = Evaluate(ThisAsstRef2ID) >
				<cfif Replace(ListGetAt(form.KOTimeList,i), "'", "", "ALL") IS ThisKOTime
				AND ListGetAt(form.RefsIDList,i) IS ThisRefereeID 
				AND ListGetAt(form.AR1IDList,i) IS ThisAsstRef1ID 
				AND ListGetAt(form.AR2IDList,i) IS ThisAsstRef2ID >
				 <cfelse>
					<!--- only update where there has been a change --->
					<cfinclude template="queries/upd_MtchDayOfficials.cfm"> 
					<!--- <cfoutput><span class="pix13boldred">LINE #i# UPDATED</span><br></cfoutput>--->
				</cfif>
				<!---
				<cfoutput><span class="pix13">#i#. #Evaluate(ThisKOTime)# #Evaluate(ThisRefereeID)# #Evaluate(ThisAsstRef1ID)# #Evaluate(ThisAsstRef2ID)# </span><br></cfoutput>    
				--->
			</cfloop>
 			
		</cfif>
	</cfif>
	<cfinclude template="queries/qry_QFixtures_v12.cfm">
	<!--- remember the original values so we only update where necessary --->
	<cfset KOTimeList = QuotedValueList(QFixtures.KOTime)>
	<cfset RefsIDList = ValueList(QFixtures.RefsID)>
	<cfset AR1IDList = ValueList(QFixtures.AR1ID)>	
	<cfset AR2IDList = ValueList(QFixtures.AR2ID)>	
	<cfinclude template="queries/qry_GetReferee1.cfm">

<cfif QFixtures.RecordCount IS 0 >
	<cfoutput><span class="pix13bold">No matches</span></cfoutput> 
<cfelse>
	<table width="25%" border="0" cellspacing="0" cellpadding="0" >
		<tr>
			<cfinclude template="InclMtchDayView.cfm">
		</tr>
	</table>
	<cfoutput>
	<form action="MtchDayOfficials.cfm?MDate=#DateFormat(ThisDate, 'YYYY-MM-DD')#&LeagueCode=#LeagueCode#" method="post" >
		<input type="Hidden" name="RCount" value="#QFixtures.RecordCount#">
		<input type="Hidden" name="KOTimeList" value="#KOTimeList#">
		<input type="Hidden" name="RefsIDList" value="#RefsIDList#">
		<input type="Hidden" name="AR1IDList" value="#AR1IDList#">
		<input type="Hidden" name="AR2IDList" value="#AR2IDList#">
		<table width="100%" border="0" cellspacing="2" cellpadding="0" bgcolor="white" >
			<tr> 
				<td align="left" colspan="#ThisColSpan-3#"> 
					<cfif QFixtures.RecordCount IS 1>
						<span class="pix13bold">There is only one match</span>
					<cfelse>
						<span class="pix13bold">There are #QFixtures.RecordCount# matches</span>
					</cfif>
					<!--- Postponed Matches - link to delete them --->
				</td>
			</tr>
	</cfoutput>


	<cfif finishPage>
		<cfinclude template="queries/qry_QRefCount.cfm"> 
      <tr> 
        <td height="30" colspan="4" align="left">
			<cfif QRefCount1.RecordCount GT 0 >
				<span class="pix24boldred">WARNING:<br><cfoutput query="QRefCount1"></span><span class="pix13bold">#RefsName#</span><span class="pix13boldred"> has #refcount# appointments<br></cfoutput></span><span class="pix10"><br>Put <b>NoDuplicateWarning</b> in Referee Restrictions to suppress these warnings about more than one appointment on the day.</span>
			</cfif>
		</td>
        <td height="30" colspan="3" align="center" class="bg_contrast"><input type="Submit" name="Operation" value="Update Appointments"></td>
      </tr>
		<cfoutput query="QFixtures" group="DivName1"> 
			<tr>
				<td height="10">&nbsp;</td>	
			</tr>
			<cfset SponsorTokenStart = FindNoCase( "Sponsor[", QFixtures.DivNotes)>
			<cfset SquareBracketEnd = FindNoCase( "]", QFixtures.DivNotes)>
			<cfif SponsorTokenStart GT 0 AND SquareBracketEnd GT SponsorTokenStart >
				<cfset SponsorTokenEnd = Find( "]", QFixtures.DivNotes, SponsorTokenStart )>
				<cfset SponsorTokenLength = SponsorTokenEnd - SponsorTokenStart - 8>
				<cfset SponsoredByText = " sponsored by #Trim(MID(QFixtures.DivNotes, SponsorTokenStart+8, SponsorTokenLength))#" >
			<cfelse>
				<cfset SponsoredByText = "">
			</cfif>
			<cfset ThisDivName = "#DivName1##SponsoredByText#">
			<tr> 
				<cfif ExternalComp IS 'Yes'>
					<td height="30" colspan="#ThisColSpan#" align="left" valign="middle" class="mainMenu"><span class="pix16boldwhite">#ThisDivName#</span></td>
				<cfelse>
					<td height="30" colspan="#ThisColSpan#" align="left" valign="middle" class="mainHeading"><span class="pix16brand">#ThisDivName#</span></td>
				</cfif>
			</tr>
			
		  <cfoutput> 
			<input type="Hidden" name="fid#currentrow#" value="#QFixtures.FID#">
			<cfset Highlight = "No">
			<cfif request.fmTeamID IS HomeTeamID>
			  <cfset Highlight = "Yes">
			</cfif>
			<cfif request.fmTeamID IS AwayTeamID>
			  <cfset Highlight = "Yes">
			</cfif>
        <tr align="left" class="bg_contrast">
			<!--- merge cells if Postponed or Abandoned or HideDivision --->
			<cfif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (HomeGoals IS "" AND AwayGoals IS "" AND Result IS "") >
						<td width="70" colspan="2" align="center" ><span class="pix10grey">&nbsp;</span></td>
			<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "H" OR (HomeGoals GT AwayGoals)) >
						<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
			<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "A" OR (HomeGoals LT AwayGoals)) >
						<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
			<cfelseif HideScore IS "Yes" AND NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND (Result IS "D" OR (HomeGoals IS AwayGoals AND IsNumeric(HomeGoals) AND IsNumeric(AwayGoals) )) >
						<td width="70" colspan="2" align="center"><span class="pix10grey">Played</span></td>
			<cfelseif Result IS "P" >
				<td width="70" colspan="2" align="center"><span class="pix18boldgray">P</span></td>
			<cfelseif Result IS "Q" >
				<td width="70" colspan="2" align="center"><span class="pix18boldgray">A</span></td>
			<cfelseif Result IS "W" >
				<td width="70" colspan="2" align="center"><span class="pix18boldgray">V</span></td>
			<cfelseif Result IS "T" >
				<td width="70" colspan="2" align="center" bgcolor="aqua"><span class="pix18boldgray">TEMP</span></td>
			<cfelse>
				<td width="35" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif>> 
				<span class="pix13bold"> 
				<cfif Result IS "H" >
				  H 
				  <cfelseif Result IS "A" >
				  - 
				  <cfelseif Result IS "D" >
				  D 
				  <cfelse>
				  #HomeGoals# 
				</cfif>
				</span> </td>
				<td width="35" align="CENTER" <cfif Highlight>class="bg_highlight"</cfif>> 
				<span class="pix13bold"> 
				<cfif Result IS "H" >
				  - 
				  <cfelseif Result IS "A" >
				  A 
				  <cfelseif Result IS "D" >
				  D 
				  <cfelse>
				  #AwayGoals# 
				</cfif>
				</span> </td>
			</cfif>
          <td <cfif Highlight>class="bg_highlight"</cfif>> 
		   <cfinclude template="InclEmailHomeTeamIcon.cfm">
			<!--- Match Number --->
			<cfif MatchNumber IS NOT "" AND MatchNumber IS NOT 0><span class="pix10italic">#NumberFormat(MatchNumber, "000")#</span></cfif> 
			<!--- Home Team v Away Team --->
		  	<cfset HTeamName = Trim("#HomeTeam# #HomeOrdinal#")>
		  	<cfset ATeamName = Trim("#AwayTeam# #AwayOrdinal#")>
              <cfif UCase(HomeGuest) IS "GUEST">
                <a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#FHomeID#&AwayID=#FAwayID#&LeagueCode=#LeagueCode#&Whence=MD"> 
                <span class="pix13bolditalic"><u>#HTeamName#</u></span></a> 
                <cfelse>
                <a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#FHomeID#&AwayID=#FAwayID#&LeagueCode=#LeagueCode#&Whence=MD"> 
                <span class="pix13bold"><u>#HTeamName#</u></span></a> 
              </cfif>
              <span class="pix13bold">v</span> 
              <cfif UCase(AwayGuest) IS "GUEST">
                <a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#FHomeID#&AwayID=#FAwayID#&LeagueCode=#LeagueCode#&Whence=MD"> 
                <span class="pix13bolditalic"><u>#ATeamName#</u></span></a> 
                <cfelse>
                <a href="UpdateForm.cfm?TblName=Matches&id=#FID#&DivisionID=#DID#&HomeID=#FHomeID#&AwayID=#FAwayID#&LeagueCode=#LeagueCode#&Whence=MD"> 
                <span class="pix13bold"><u>#ATeamName#</u></span></a> 
              </cfif>
			<cfif TRIM(#RoundName#)IS NOT "" >
              <span class="pix13boldnavy">[ #RoundName# ]</span> </cfif> 
			  <cfif Result IS "H" AND HideScore IS "No" >
              <span class="pix13boldnavy">[ Home Win was awarded ]</span> 
              <cfelseif Result IS "A" AND HideScore IS "No" >
              <span class="pix13boldnavy">[ Away Win was awarded ]</span> 
              <cfelseif Result IS "U" AND HideScore IS "No" >
              <span class="pix13boldnavy">[ Home Win on penalties ]</span> 
              <cfelseif Result IS "V" AND HideScore IS "No" >
              <span class="pix13boldnavy">[ Away Win on penalties ]</span> 
              <cfelseif Result IS "D" AND HideScore IS "No" >
              <span class="pix13boldnavy">[ Draw was awarded ]</span> 
              <cfelseif Result IS "P" >
              <span class="pix13boldnavy">[ Postponed ]</span> 
              <cfelseif Result IS "Q" >
              <span class="pix13boldnavy">[ Abandoned ]</span> 
              <cfelseif Result IS "W" >
              <span class="pix13boldnavy">[ Void ]</span> 
			  <cfelseif Result IS "T" >
			  <span class="pix10italic"> fixture hidden from the public </span> 
              <cfelse>
            </cfif>
			  

			<cfif VenueAndPitchAvailable IS "Yes" <!--- AND UCase(HomeGuest) IS NOT "GUEST" ---> >
				<cfinclude template="InclFixturePitchAvailability.cfm">
			</cfif>
			<!--- Kick Off Time --->
			<cfif KOTime IS "" ><cfelse><span class="pix10brand"><br><strong>#TimeFormat(KOTime, 'h:mm TT')#</strong></span></cfif> 
			
			<cfif ListFind(DHList,FID) AND HideDoubleHdrMsg IS 0 >
				<span class="pix10boldnavy"><br>Double Header</span>
			</cfif>
			<cfif #FixtureNotes# IS "" >
			<cfelse>
				<span class="pix10"><br>#FixtureNotes#</span>
			</cfif>
			</td>
			<cfif Len(Trim(RefsFullName)) GT 0>
		  		<cfset TooltipText = "Click to see when #RefsFullName# refereed games involving #HomeTeam# #HomeOrdinal# and #AwayTeam# #AwayOrdinal#">
		  		<cfset TooltipText = "Click to see when #RefsFullName# refereed games involving #HomeTeam# #HomeOrdinal# and #AwayTeam# #AwayOrdinal#">
				<cfset TooltipText = Replace(ToolTipText, "'", "\'", "ALL")>
				<cfset TooltipText = Replace(ToolTipText, CHR(34), "\'", "ALL")>
				<cfset TooltipText = Replace(TooltipText, "&", "& amp", "ALL")>
				<cfset TooltipText = Replace(TooltipText, CHR(13), " ", "ALL")>
				<cfset TooltipText = Replace(TooltipText, CHR(10), " ", "ALL")>
			<cfelse>
				<cfset TooltipText = "no referee">
		  	</cfif>
            <td valign="middle"><a href="javascript:void window.open('ThisRefsHistory.cfm?HID=#FHomeID#&AID=#FAwayID#&MD=#ThisDate#&RID=#RefsID#&LeagueCode=#LeagueCode#','ThisRefsHistory','height=900,width=600,left=10,top=10,resizable=yes,scrollbars=yes').focus()" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=400;return escape('#TooltipText#')"><IMG src="gif/RefsHistory.gif" alt="Referee History" width="42" height="14"  border="1" align="absmiddle"></a></td>


					<!---
					KO Time
					--->
					<td align="center"><span class="pix10bold">KO </span><input name="KOTime#currentrow#" type="text" class="pix9" value="#TimeFormat(KOTime, 'h:mm TT')#" size="8"></td>



					<!---
					Referee
					--->
					<td align="CENTER">
						<img src="images/icon_referee.png" border="0" align="absmiddle"> <select name="RefID#currentrow#" size="1"><cfloop query="GetReferee1"><option value="#RID#" <cfif GetReferee1.RID IS QFixtures.RefsID>selected</cfif> <cfif GetReferee1.Available IS "No">Disabled</cfif>  <cfif GetReferee1.Available IS "Yes">class="bg_reallightgreen"<cfelseif GetReferee1.Available IS "No">class="bg_pink"</cfif> >#GetReferee1.RefsFullName#</option></cfloop> </select>
					</td>
					<!---
					Asst. Referee 1
					--->
					<td  align="CENTER">
						<img src="images/icon_line1.png" border="0" align="absmiddle">   <select name="AR1ID#currentrow#" size="1"><cfloop query="GetReferee1"><option value="#RID#" <cfif GetReferee1.RID IS QFixtures.AR1ID>selected</cfif> <cfif GetReferee1.Available IS "No">Disabled</cfif>   <cfif GetReferee1.Available IS "Yes">class="bg_reallightgreen"<cfelseif GetReferee1.Available IS "No">class="bg_pink"</cfif> >#GetReferee1.RefsFullName#</option></cfloop> </select>
					</td>
					<!---
					Asst. Referee 2
					--->
					<td align="CENTER">
						<img src="images/icon_line2.png" border="0" align="absmiddle">   <select name="AR2ID#currentrow#" size="1"><cfloop query="GetReferee1"><option value="#RID#" <cfif GetReferee1.RID IS QFixtures.AR2ID>selected</cfif> <cfif GetReferee1.Available IS "No">Disabled</cfif>   <cfif GetReferee1.Available IS "Yes">class="bg_reallightgreen"<cfelseif GetReferee1.Available IS "No">class="bg_pink"</cfif> >#GetReferee1.RefsFullName#</option></cfloop> </select>
					</td>
		  
        </tr>
      </cfoutput> 
      <tr> 
        <td height="4" colspan="4" bgcolor="white"></td>
      </tr>
	  
	  
              <!------- <cfinclude template="InclMatchReportIcon.cfm"> ------>
    </cfoutput> 
      <tr> 
        <td height="30" colspan="4" align="center"></td>
        <td height="30" colspan="3" align="center" class="bg_contrast"><input type="Submit" name="Operation" value="Update Appointments"></td>
      </tr>
	</table>

</form>	
</cfif>

</cfif> <!--- finishPage --->
<script language="JavaScript" type="text/javascript" src="wz_tooltip.js"></script>

