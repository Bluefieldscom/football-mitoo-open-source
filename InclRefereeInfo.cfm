				<tr>
					<cfoutput query="GetRefereeInfo">
						<td align="center">
							<table border="0" cellpadding="2" cellspacing="0">
								<tr>
									<td colspan="2" align="center">
										<table border="1" cellpadding="5" cellspacing="0">
											<tr>
												<td bgcolor="white"><span class="pix13boldnavy">#RefsFullName#</span></td>
											</tr>
										</table>
									</td>
								</tr>
								
								<tr>
									<td>
										<table border="0" cellpadding="5" cellspacing="0" bgcolor="white">
										
											<tr><td colspan="2" align="center" bgcolor="silver"><span class="pix13boldnavy">To update these details and availability <a href="UpdateForm.cfm?TblName=Referee&ID=#RefereeID#&LeagueCode=#form.LeagueCode#">click here</a></span></td></tr>
										
											<tr>
		<!--- left hand column -------->										
												<td valign="top">
													<table border="0" cellpadding="2" cellspacing="0">
														<cfif Len(Trim(AddressLine1)) IS 0 AND Len(Trim(AddressLine2)) IS 0 AND Len(Trim(AddressLine3)) IS 0 AND Len(Trim(PostCode)) IS 0 >
															<tr>
																<td valign="top"><span class="pix10bold">Address missing</span></td>
															</tr>
														<cfelse>
															<tr>
																<td valign="top"><span class="pix10bold">#Trim(AddressLine1)#<br>#Trim(AddressLine2)#<br>#Trim(AddressLine3)#<br>#Trim(PostCode)#</span></td>
															</tr>
														</cfif>
														
														
														<cfif Len(Trim(HomeTel)) GT 0 >
															<tr>
																<td><span class="pix10navy">Home Tel</span><span class="pix10bold">&nbsp;#HomeTel#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Home Tel</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														<cfif Len(Trim(WorkTel)) GT 0 >
															<tr>
																<td><span class="pix10navy">Work Tel</span><span class="pix10bold">&nbsp;#WorkTel#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Work Tel</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														<cfif Len(Trim(MobileTel)) GT 0 >
															<tr>
																<td><span class="pix10navy">Mobile Tel</span><span class="pix10bold">&nbsp;#MobileTel#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Mobile Tel</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														<cfif Len(Trim(EmailAddress1)) GT 0 >
															<tr>
																<td><span class="pix10navy">Email 1</span><span class="pix10bold">&nbsp;#EmailAddress1#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Email 1</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														<cfif Len(Trim(EmailAddress2)) GT 0 >
															<tr>
																<td><span class="pix10navy">Email 2</span><span class="pix10bold">&nbsp;#EmailAddress2#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Email 2</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														
														
													</table>
												</td>
		<!--- right hand column -------->										
												<td valign="top">
													<table border="0" cellpadding="2" cellspacing="0">
														<cfif Len(Trim(FAN)) GT 0 >
															<tr>
																<td><span class="pix10navy">FAN</span><span class="pix10bold">&nbsp;#FAN#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">FAN</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														<cfif Len(Trim(ParentCounty)) GT 0 >
															<tr>
																<td><span class="pix10navy">Parent County</span><span class="pix10bold">&nbsp;#ParentCounty#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Parent County</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														
														<cfif Len(Trim(DateOfBirth)) GT 0 >
															<cfset RefsAge = DateDiff( "YYYY",  DateOfBirth, Now() ) >
															<tr>
																<td><span class="pix10navy">Date of Birth</span><span class="pix10bold">&nbsp;#DateFormat(DateOfBirth, 'DD/MM/YYYY')#</span><br><span class="pix10navy">Age</span><span class="pix10bold"> #RefsAge#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Date of Birth</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														<cfif Len(Trim(Level)) GT 0 >
															<tr>
																<td><span class="pix10navy">Level</span><span class="pix10bold">&nbsp;#Level#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Level</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														<cfif Len(Trim(PromotionCandidate)) GT 0 >
															<tr>
																<td><span class="pix10navy">Promotion Candidate</span><span class="pix10bold">&nbsp;#PromotionCandidate#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Promotion Candidate</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														
														<cfif Len(Trim(Notes)) GT 0 >
															<tr>
																<td><span class="pix10navy">Notes</span><span class="pix10bold">&nbsp;#Notes#</span></td>
															</tr>
														<cfelse>
															<tr>
																<td><span class="pix10navy">Notes</span><span class="pix10bold">&nbsp;?</span></td>
															</tr>
														</cfif>
														
													</table>
												</td>
											</tr>
											<tr><td colspan="2" align="center" bgcolor="silver"><span class="pix13boldnavy">To see your games and Match Cards <a href="RefsHistMatchCard.cfm?LeagueCode=#form.LeagueCode#&RI=#RefereeID#">click here</a></span></td></tr>
											
										</table>
									</td>	
								</tr>	
							</table>		
						</td>
					</cfoutput>
				</tr>

