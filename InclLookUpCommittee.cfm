<cfif NewRecord IS "No">
	<cfinclude template="queries/qry_GetCommittee.cfm">
</cfif>
<table width="100%" border="0" cellpadding="5" cellspacing="5">
	<tr>
		<td valign="top">
			<table border="0" cellpadding="2" cellspacing="0">
				<cfif NewRecord IS "No">
					<tr>
						<td align="center" bgcolor="gray">
							<cfoutput><span class="pix13boldwhite">#QCommittee.MemberName#</span></cfoutput>
						</td>
					</tr>
				</cfif>
				<tr>
					<td align="left">
					<span class="pix10navy">Title<br><input type="Text" name="Title" size="3" maxlength="6" <cfif NewRecord IS "No">VALUE=<cfoutput>"#QCommittee.Title#"</cfoutput></cfif> ></span>
					</td>
				</tr>
				<tr>
					<td align="left">
					<span class="pix10navy">Surname<br><input type="Text" name="Surname" size="30" maxlength="50" <cfif NewRecord IS "No">VALUE=<cfoutput>"#QCommittee.Surname#"</cfoutput></cfif> ></span>
					</td>
				</tr>
				
				<tr>
					<td align="left" >
						<span class="pix10navy">Forenames<br>
						<input type="Text" name="Forename" size="30" maxlength="50"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#QCommittee.Forename#"</cfoutput></cfif> >
					</span></td>
				</tr>
				<tr>
					<td align="left">
						<span class="pix10navy">Position on Committee e.g. <strong>Registration Secretary</strong></span><br>
						<input type="Text" name="LongCol" size="50" maxlength="50"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#QCommittee.LongCol#"</cfoutput></cfif> >
					</td>
				</tr>
				
				<tr>
					<td align="left">
						<span class="pix10navy"><strong>HIDE</strong> or sort order e.g. <strong>0010</strong><br>
						<input type="Text" name="ShortCol" size="5" maxlength="5"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#QCommittee.ShortCol#"</cfoutput></cfif> >
					</span></td>
				</tr>

				<tr>
					<td align="left" <cfif NewRecord IS "No" AND QCommittee.ShowHideHomeTel IS 1>bgcolor="silver"</cfif>>
						<span class="pix10navy">Home Telephone<br></span>
						<input type="Text" name="HomeTel" size="40" maxlength="40"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#QCommittee.HomeTel#"</cfoutput></cfif> ><input name="ShowHideHomeTel" type="checkbox" <cfif NewRecord IS "No" AND QCommittee.ShowHideHomeTel IS 1>checked</cfif> ><span class="pix9"> Hide</span>
						</td>
				</tr>
				<tr>
					<td align="left" <cfif NewRecord IS "No" AND QCommittee.ShowHideWorkTel IS 1>bgcolor="silver"</cfif>>
						<span class="pix10navy">Work Telephone<br></span>
						<input type="Text" name="WorkTel" size="40" maxlength="40"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#QCommittee.WorkTel#"</cfoutput></cfif> ><input name="ShowHideWorkTel" type="checkbox" <cfif NewRecord IS "No" AND QCommittee.ShowHideWorkTel IS 1>checked</cfif> ><span class="pix9"> Hide</span>
					</td>
				</tr>
				<tr>
					<td align="left" <cfif NewRecord IS "No" AND QCommittee.ShowHideMobileTel IS 1>bgcolor="silver"</cfif>>
						<span class="pix10navy">Mobile Telephone<br></span>
						<input type="Text" name="MobileTel" size="40" maxlength="40"	<cfif NewRecord IS "No">VALUE=<cfoutput>"#QCommittee.MobileTel#"</cfoutput></cfif> ><input name="ShowHideMobileTel" type="checkbox" <cfif NewRecord IS "No" AND QCommittee.ShowHideMobileTel IS 1>checked</cfif> ><span class="pix9"> Hide</span>
					</td>
				</tr>

			</table>
		</td>
		<td valign="top">
			<table border="0" cellpadding="2" cellspacing="0">
				<tr>
					<cfoutput>
					<td align="left">
						<table>
							<tr>
								<td bgcolor="tan" align="center"><span class="pix9">CC</span><br><input name="CCEmailAddress1" type="checkbox" <cfif NewRecord IS "No" AND QCommittee.CCEmailAddress1 IS 1>checked</cfif> ></td>
								<td align="left" <cfif NewRecord IS "No" AND QCommittee.ShowHideEmailAddress1 IS 1>bgcolor="silver"</cfif>>
									<span class="pix10navy">Email Address 1</span><br>
									<input type="Text" name="EmailAddress1" size="50" maxlength="50"	<cfif NewRecord IS "No">VALUE="#QCommittee.EmailAddress1#"</cfif> ><input name="ShowHideEmailAddress1" type="checkbox" <cfif NewRecord IS "No" AND QCommittee.ShowHideEmailAddress1 IS 1>checked</cfif> ><span class="pix9">Hide</span>
								</td>
							</tr>
						</table>
					</td>
					</cfoutput>
				</tr>
				<tr>
					<cfoutput>
					<td align="left">
						<table>
							<tr>
								<td bgcolor="tan" align="center"><span class="pix9">CC</span><br><input name="CCEmailAddress2" type="checkbox" <cfif NewRecord IS "No" AND QCommittee.CCEmailAddress2 IS 1>checked</cfif> ></td>
								<td align="left" <cfif NewRecord IS "No" AND QCommittee.ShowHideEmailAddress2 IS 1>bgcolor="silver"</cfif>>
									<span class="pix10navy">Email Address 2</span><br>
									<input type="Text" name="EmailAddress2" size="50" maxlength="50"	<cfif NewRecord IS "No">VALUE="#QCommittee.EmailAddress2#"</cfif> ><input name="ShowHideEmailAddress2" type="checkbox" <cfif NewRecord IS "No" AND QCommittee.ShowHideEmailAddress2 IS 1>checked</cfif> ><span class="pix9">Hide</span>
								</td>
							</tr>
						</table>
					</td>
					</cfoutput>
				</tr>
				<tr><td bgcolor="tan" height="20" align="left"><span class="pix9">tick CC to copy match day emails</span></td></tr>
				<tr>
					<cfoutput>
					<td align="left" <cfif NewRecord IS "No" AND QCommittee.ShowHideAddress IS 1>bgcolor="silver"</cfif>>
						<span class="pix10navy">Postal Address</span><br>
						<input type="Text" name="AddressLine1" size="50" maxlength="50"	<cfif NewRecord IS "No">VALUE="#QCommittee.AddressLine1#"</cfif> ><input name="ShowHideAddress" type="checkbox" <cfif NewRecord IS "No" AND QCommittee.ShowHideAddress IS 1>checked</cfif> ><span class="pix9"> Hide</span><br>
						<input type="Text" name="AddressLine2" size="50" maxlength="50"	<cfif NewRecord IS "No">VALUE="#QCommittee.AddressLine2#"</cfif> ><br>
						<input type="Text" name="AddressLine3" size="50" maxlength="50"	<cfif NewRecord IS "No">VALUE="#QCommittee.AddressLine3#"</cfif> ><br>
						<input type="Text" name="PostCode" size="10" maxlength="10"	<cfif NewRecord IS "No">VALUE="#QCommittee.PostCode#"</cfif>  ><span class="pix10navy"> Postcode</span>
					</td>
					</cfoutput>
				</tr>
				<cfif ListFind("Silver",request.SecurityLevel) > <!--- Include in Mailout? JAB authorised only --->
					<tr>
						<cfoutput>
						<cfif NewRecord IS "Yes">
							<td align="left" bgcolor="lightgreen">
								<span class="pix10navy">Include in Mailout?</span>
								<input name="NoMailout" type="radio" value="0" checked ><span class="pix9">Yes</span>
								<input name="NoMailout" type="radio" value="1" ><span class="pix9">No</span>
							</td>
						<cfelse>
							<td align="left" <cfif QCommittee.NoMailout IS 1>bgcolor="pink"<cfelse>bgcolor="lightgreen"</cfif>>
								<span class="pix10navy">Include in Mailout?</span>
								<input name="NoMailout" type="radio" value="0" <cfif QCommittee.NoMailout IS 0>checked</cfif> ><span class="pix9">Yes</span>
								<input name="NoMailout" type="radio" value="1" <cfif QCommittee.NoMailout IS 1>checked</cfif> ><span class="pix9">No</span>
							</td>
						</cfif>
						</cfoutput>
					</tr>
				<cfelseif ListFind("Skyblue",request.SecurityLevel) >
					<cfoutput>
					<cfif NewRecord IS "Yes">
						<input type="hidden" name="NoMailout" value="0">
					<cfelse>
						<input type="hidden" name="NoMailout" value="#QCommittee.NoMailout#">
					</cfif>
					</cfoutput>
				</cfif>
				
			</table>
		</td>
		
		<td align="left" valign="top">
			<table border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td align="left">
						<span class="pix10navy">Notes</span><br>
						<cfoutput><TEXTAREA NAME="Notes" cols="40" WRAP="VIRTUAL" rows="10"><cfif NewRecord IS "No">#HTMLEditFormat(QCommittee.Notes)#</cfif></TEXTAREA></cfoutput>
						<cfif NewRecord IS "No"><span class="pix10red"><br>Please transfer any contact details to<br>the corresponding fields on the left</span></cfif>
					</td>	
				</tr>
			</table>
		</td>
	
	
	</tr>
</table>
