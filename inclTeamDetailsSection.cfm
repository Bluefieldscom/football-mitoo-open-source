<!--- called by TeamDetailsUpdate.cfm --->
<cfset HideMsg = "hide from public">
<cfoutput>
<tr>
	<td  height="60" colspan="2" align="center">
		<table border="1" cellpadding="5" cellspacing="0">
			<tr>
				<cfif #TRIM(OrdinalName)# IS "">
					<td bgcolor="white"><span class="pix18boldnavy">#TeamName# <em>(First Team)</em> - Team Details</span></td>
				<cfelse>
					<td bgcolor="white"><span class="pix18boldnavy">#TeamName# #OrdinalName# - Team Details</span></td>
				</cfif>
			</tr>
		</table>
	</td>
</tr>
<cfif VenueAndPitchAvailable IS "Yes">
	<cfinclude template="queries/qry_GetVInfo.cfm">
	<cfinclude template="queries/qry_GetPitchNoInfo.cfm">
	<tr>
		<td colspan="2" align="center">
			<table border="0" cellpadding="5" cellspacing="0">
				<tr>
					<td bgcolor="lightgreen"><span class="pix10bold">Normal<br>Venue</span></td>
					<td align="center" bgcolor="lightgreen">
						<select name="VenueID" size="1" <cfif ListFind("Yellow",request.SecurityLevel)>disabled</cfif>  >
							<OPTION VALUE="#VenueID#" <cfif GetVInfo.VenueID IS 0>selected</cfif>></OPTION>
							<cfloop query="GetVInfo" >
								<OPTION VALUE="#VenueID#" <cfif GetVInfo.VenueID IS #QTeamDetails.VenueID#>selected</cfif>>#VenueDescription#</OPTION>
							</cfloop>
						</select>
					</td>
					<td bgcolor="lightgreen"><span class="pix10bold">Normal<br>Pitch</span></td>
						<td align="center" bgcolor="lightgreen">
							<select name="PitchNoID" size="1" <cfif ListFind("Yellow",request.SecurityLevel)>disabled</cfif> >
							<cfloop query="GetPitchNoInfo" >
								<OPTION VALUE="#ID#" <cfif GetPitchNoInfo.ID IS #QTeamDetails.PitchNoID#>selected</cfif>>#LongCol#</OPTION>
							</cfloop>
							</select>
						</td>
				</tr>
			</table>
		</td>
	</tr>
<cfelse>
<input type="hidden" name="VenueID" value="0">
<input type="hidden" name="PitchNoID" value="0">
</cfif>

<!---
<tr>
	<td align="center">
		<table>
			<tr>
				<td  align="right">
					<span class="pix10bold">URL of Team Website:</span><span class="pix10"><br>http://etc....</span> 
				</td>
				<td  align="left">
					<input type="Text" name="URLTeamWebsite" value="#URLTeamWebsite#" size="80">
				</td>
			</tr>
			<tr>
				<td  align="right">
					<span class="pix10bold">URL of Team Photo:</span><span class="pix10"><br>http://etc....</span> 
				</td>
				<td  align="left">
					<input type="Text" name="URLTeamPhoto" value="#URLTeamPhoto#" size="80">
				</td>
			</tr>

		</table>
	</td>
</tr>
--->
<tr>
	<td align="center">
		<table border="1" cellpadding="2" cellspacing="0">
		<tr>
			<td colspan="2" align="center"><span class="pix10bold">Home Colours</span></td>
			<td colspan="2" align="center"><span class="pix10bold">Away Colours</span></td>
		</tr>
			<tr>
				<td align="right">
					<span class="pix10bold">Shirt:</span><span class="pix10"><br>e.g. Red & White stripes</span>
				</td>
				<td align="left">
					<input type="Text" name="ShirtColour1" value="#ShirtColour1#" size="20">
				</td>
				<td align="right">
					<span class="pix10bold">Shirt:</span><span class="pix10"><br>
            e.g. White and blue hooped</span> </td>
				<td align="left">
					<input type="Text" name="ShirtColour2" value="#ShirtColour2#" size="20">
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="pix10bold">Shorts:</span>
				</td>
				<td align="left">
					<input type="Text" name="ShortsColour1" value="#ShortsColour1#" size="20">
				</td>
				<td  align="right">
					<span class="pix10bold">Shorts:</span>
				</td>
				<td  align="left">
					<input type="Text" name="ShortsColour2" value="#ShortsColour2#" size="20">
				</td>
			</tr>
			<tr>
				<td align="right">
					<span class="pix10bold">Socks:</span>
				</td>
				<td align="left">
					<input type="Text" name="SocksColour1" value="#SocksColour1#" size="20">
				</td>
				<td  align="right">
					<span class="pix10bold">Socks:</span>
				</td>
				<td  align="left">
					<input type="Text" name="SocksColour2" value="#SocksColour2#" size="20">
				</td>
			</tr>
		</table>
	</td>
</tr>

	<td align="center">
		<table border="1" cellpadding="2" cellspacing="0">
			<tr>
				<td colspan="4" align="center">
					<span class="pix10bold">Contact 1</span> 
				</td>
				<td colspan="4" align="center">
					<span class="pix10bold">Contact 2</span> 
				</td>
				<td colspan="4" align="center">
					<span class="pix10bold">Contact 3</span> 
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<span class="pix10">Name:</span>
				</td>
				<td colspan="2" align="left">
					<input type="Text" name="Contact1Name" value="#Contact1Name#" size="20">
				</td>
				<td colspan="2" align="right">
					<span class="pix10">Name:</span>
				</td>
				<td colspan="2" align="left">
					<input type="Text" name="Contact2Name" value="#Contact2Name#" size="20">
				</td>
				<td colspan="2" align="right">
					<span class="pix10">Name:</span>
				</td>
				<td colspan="2" align="left">
					<input type="Text" name="Contact3Name" value="#Contact3Name#" size="20">
				</td>
			</tr>



			<tr>
				<td colspan="2" align="right">
					<span class="pix10">e.g. Manager<br></span><span class="pix10bold">Job Description:</span>
				</td>
				<td colspan="2" align="left">
					<input type="Text" name="Contact1JobDescr" value="#Contact1JobDescr#" size="20">
				</td>
				<td colspan="2" align="right">
					<span class="pix10">e.g. Secretary<br></span><span class="pix10bold">Job Description:</span>
				</td>
				<td colspan="2" align="left">
					<input type="Text" name="Contact2JobDescr" value="#Contact2JobDescr#" size="20">
				</td>
				<td colspan="2" align="right">
					<span class="pix10">e.g. Emergency contact<br></span><span class="pix10bold">Job Description:</span>
				</td>
				<td colspan="2" align="left">
					<input type="Text" name="Contact3JobDescr" value="#Contact3JobDescr#" size="20">
				</td>
				
			</tr>


			<tr>
				<td <cfif ShowHideContact1Address IS 1>bgcolor="silver"</cfif> colspan="2" align="right">
					<span class="pix10bold">Address:</span>
				</td>
				<td <cfif ShowHideContact1Address IS 1>bgcolor="silver"</cfif> colspan="2" align="left">
					<input type="Text" name="Contact1Address" value="#Contact1Address#" size="35"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact1Address" type="checkbox" <cfif ShowHideContact1Address IS 1>checked</cfif> >
				</td>
				<td <cfif ShowHideContact2Address IS 1>bgcolor="silver"</cfif> colspan="2" align="right">
					<span class="pix10bold">Address:</span>
				</td>
				<td <cfif ShowHideContact2Address IS 1>bgcolor="silver"</cfif> colspan="2" align="left">
					<input type="Text" name="Contact2Address" value="#Contact2Address#" size="35"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact2Address" type="checkbox" <cfif ShowHideContact2Address IS 1>checked</cfif> >
				</td>
				<td <cfif ShowHideContact3Address IS 1>bgcolor="silver"</cfif> colspan="2" align="right">
					<span class="pix10bold">Address:</span>
				</td>
				<td <cfif ShowHideContact3Address IS 1>bgcolor="silver"</cfif> colspan="2" align="left">
					<input type="Text" name="Contact3Address" value="#Contact3Address#" size="35"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact3Address" type="checkbox" <cfif ShowHideContact3Address IS 1>checked</cfif> >
				</td>
			</tr>

			<tr>
				<td colspan="4" align="center">
					<span class="pix10bold">Telephone</span> 
				</td>
				<td colspan="4" align="center">
					<span class="pix10bold">Telephone</span> 
				</td>
				<td colspan="4" align="center">
					<span class="pix10bold">Telephone</span> 
				</td>
			</tr>
			<tr>
				<td align="right" <cfif ShowHideContact1TelNo1 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10">e.g. Home<br></span><span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact1TelNo1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact1TelNo1Descr" value="#Contact1TelNo1Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact1TelNo1 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact1TelNo1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact1TelNo1" value="#Contact1TelNo1#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact1TelNo1" type="checkbox" <cfif ShowHideContact1TelNo1 IS 1>checked</cfif> >
				</td>
				<td align="right" <cfif ShowHideContact2TelNo1 IS 1>bgcolor="silver"</cfif> >
					</span><span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact2TelNo1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact2TelNo1Descr" value="#Contact2TelNo1Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact2TelNo1 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact2TelNo1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact2TelNo1" value="#Contact2TelNo1#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact2TelNo1" type="checkbox" <cfif ShowHideContact2TelNo1 IS 1>checked</cfif> >
				</td>
				<td align="right" <cfif ShowHideContact3TelNo1 IS 1>bgcolor="silver"</cfif> >
					</span><span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact3TelNo1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact3TelNo1Descr" value="#Contact3TelNo1Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact3TelNo1 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact3TelNo1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact3TelNo1" value="#Contact3TelNo1#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact3TelNo1" type="checkbox" <cfif ShowHideContact3TelNo1 IS 1>checked</cfif> >
				</td>
			</tr>
			<tr>
				<td align="right" <cfif ShowHideContact1TelNo2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10">e.g. Work<br><span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact1TelNo2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact1TelNo2Descr" value="#Contact1TelNo2Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact1TelNo2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact1TelNo2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact1TelNo2" value="#Contact1TelNo2#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact1TelNo2" type="checkbox" <cfif ShowHideContact1TelNo2 IS 1>checked</cfif> >
				</td>
				<td align="right" <cfif ShowHideContact2TelNo2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact2TelNo2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact2TelNo2Descr" value="#Contact2TelNo2Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact2TelNo2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact2TelNo2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact2TelNo2" value="#Contact2TelNo2#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact2TelNo2" type="checkbox" <cfif ShowHideContact2TelNo2 IS 1>checked</cfif> >
				</td>
				<td align="right" <cfif ShowHideContact3TelNo2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact3TelNo2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact3TelNo2Descr" value="#Contact3TelNo2Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact3TelNo2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact3TelNo2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact3TelNo2" value="#Contact3TelNo2#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact3TelNo2" type="checkbox" <cfif ShowHideContact3TelNo2 IS 1>checked</cfif> >
				</td>
			</tr>
			<tr>
				<td align="right" <cfif ShowHideContact1TelNo3 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10">e.g. Mobile<br><span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact1TelNo3 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact1TelNo3Descr" value="#Contact1TelNo3Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact1TelNo3 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact1TelNo3 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact1TelNo3" value="#Contact1TelNo3#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact1TelNo3" type="checkbox" <cfif ShowHideContact1TelNo3 IS 1>checked</cfif> >
				</td>
				<td align="right" <cfif ShowHideContact2TelNo3 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact2TelNo3 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact2TelNo3Descr" value="#Contact2TelNo3Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact2TelNo3 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact2TelNo3 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact2TelNo3" value="#Contact2TelNo3#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact2TelNo3" type="checkbox" <cfif ShowHideContact2TelNo3 IS 1>checked</cfif> >
				</td>
				<td align="right" <cfif ShowHideContact3TelNo3 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Descr:</span>
				</td>
				<td align="left" <cfif ShowHideContact3TelNo3 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact3TelNo3Descr" value="#Contact3TelNo3Descr#" size="10">
				</td>
				<td align="right" <cfif ShowHideContact3TelNo3 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">No:</span>
				</td>
				<td align="left" <cfif ShowHideContact3TelNo3 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact3TelNo3" value="#Contact3TelNo3#" size="20"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact3TelNo3" type="checkbox" <cfif ShowHideContact3TelNo3 IS 1>checked</cfif> >
				</td>
			</tr>

			<tr>
				<td colspan="2" align="right" <cfif ShowHideContact1Email1 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Home Email:</span>
				</td>
				<td colspan="2" align="left" <cfif ShowHideContact1Email1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact1Email1" value="#Contact1Email1#" size="40"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact1Email1" type="checkbox" <cfif ShowHideContact1Email1 IS 1>checked</cfif> >
				</td>
				<td colspan="2" align="right" <cfif ShowHideContact2Email1 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Home Email:</span>
				</td>
				<td colspan="2" align="left" <cfif ShowHideContact2Email1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact2Email1" value="#Contact2Email1#" size="40"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact2Email1" type="checkbox" <cfif ShowHideContact2Email1 IS 1>checked</cfif> >
				</td>
				<td colspan="2" align="right" <cfif ShowHideContact3Email1 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Home Email:</span>
				</td>
				<td colspan="2" align="left" <cfif ShowHideContact3Email1 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact3Email1" value="#Contact3Email1#" size="40"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact3Email1" type="checkbox" <cfif ShowHideContact3Email1 IS 1>checked</cfif> >
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right" <cfif ShowHideContact1Email2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Work Email:</span>
				</td>
				<td colspan="2" align="left" <cfif ShowHideContact1Email2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact1Email2" value="#Contact1Email2#" size="40"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact1Email2" type="checkbox" <cfif ShowHideContact1Email2 IS 1>checked</cfif> >
				</td>
				<td colspan="2" align="right" <cfif ShowHideContact2Email2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Work Email:</span>
				</td>
				<td colspan="2" align="left" <cfif ShowHideContact2Email2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact2Email2" value="#Contact2Email2#" size="40"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact2Email2" type="checkbox" <cfif ShowHideContact2Email2 IS 1>checked</cfif> >
				</td>
				<td colspan="2" align="right" <cfif ShowHideContact3Email2 IS 1>bgcolor="silver"</cfif> >
					<span class="pix10bold">Work Email:</span>
				</td>
				<td colspan="2" align="left" <cfif ShowHideContact3Email2 IS 1>bgcolor="silver"</cfif> >
					<input type="Text" name="Contact3Email2" value="#Contact3Email2#" size="40"><br><span class="pix9">#HideMsg#</span><input name="ShowHideContact3Email2" type="checkbox" <cfif ShowHideContact3Email2 IS 1>checked</cfif> >
				</td>
			</tr>

		</table>
	</td>
</cfoutput>
