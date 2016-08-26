<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cflock scope="session" timeout="10" type="readonly">
	<cfset request.LeagueType = session.LeagueType >
	<cfset request.RefMarksOutOfHundred = session.RefMarksOutOfHundred>
</cflock> 


<cfinclude template="queries/qry_QCheckReferee.cfm">
<cfinclude template="queries/qry_QCheckAsstRef1.cfm">
<cfinclude template="queries/qry_QCheckAsstRef2.cfm">
<cfif request.LeagueType IS "Contributory">
	<cfinclude template="queries/qry_QCheckAssessor.cfm">
</cfif>


<!--- get the ID of the "blank" referee i.e. No Referee --->
<cfinclude template="queries/qry_QCheckRef.cfm">

<cfset ListOfRefereeIDs = "">
<cfif Form.RefereeID IS NOT QCheckRef.ID>
	<cfset ListOfRefereeIDs = ListAppend(ListOfRefereeIDs,#Form.RefereeID#)>
</cfif>
<cfif Form.AsstRef1ID IS NOT QCheckRef.ID>
	<cfset ListOfRefereeIDs = ListAppend(ListOfRefereeIDs,#Form.AsstRef1ID#)>
</cfif>
<cfif Form.AsstRef2ID IS NOT QCheckRef.ID>
	<cfset ListOfRefereeIDs = ListAppend(ListOfRefereeIDs,#Form.AsstRef2ID#)>
</cfif>
<cfif Form.FourthOfficialID IS NOT QCheckRef.ID>
	<cfset ListOfRefereeIDs = ListAppend(ListOfRefereeIDs,#Form.FourthOfficialID#)>
</cfif>
<cfif Form.AssessorID IS NOT QCheckRef.ID>
	<cfset ListOfRefereeIDs = ListAppend(ListOfRefereeIDs,#Form.AssessorID#)>
</cfif>
<!---
Check to see if the same person is appointed to more than one role.
Only bother to do the check if more than one person has been appointed.
--->
<cfset FoundError = "No">
<cfset InListCount = ListLen(ListOfRefereeIDs) >
<cfif InListCount IS 2 >
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,2)>
		<cfset FoundError = "Yes">
	</cfif>
<cfelseif InListCount IS 3 >
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,2)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,3)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,2) IS ListGetAt(ListOfRefereeIDs,3)>
		<cfset FoundError = "Yes">
	</cfif>
<cfelseif InListCount IS 4 >
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,2)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,3)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,4)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,2) IS ListGetAt(ListOfRefereeIDs,3)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,2) IS ListGetAt(ListOfRefereeIDs,4)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,3) IS ListGetAt(ListOfRefereeIDs,4)>
		<cfset FoundError = "Yes">
	</cfif>
<cfelseif InListCount IS 5 >
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,2)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,3)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,4)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,1) IS ListGetAt(ListOfRefereeIDs,5)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,2) IS ListGetAt(ListOfRefereeIDs,3)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,2) IS ListGetAt(ListOfRefereeIDs,4)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,2) IS ListGetAt(ListOfRefereeIDs,5)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,3) IS ListGetAt(ListOfRefereeIDs,4)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,3) IS ListGetAt(ListOfRefereeIDs,5)>
		<cfset FoundError = "Yes">
	</cfif>
	<cfif ListGetAt(ListOfRefereeIDs,4) IS ListGetAt(ListOfRefereeIDs,5)>
		<cfset FoundError = "Yes">
	</cfif>
</cfif>
<cfif FoundError IS "Yes">
	<cfoutput>
		<span class="pix24boldred">
			The same person is appointed to more than one role.<br />
			Look at Referee, Assistant Referee 1 and 2, Fourth Official, Assessor.<BR><BR>
			Press the Back button on your browser.....
		</span>
		<CFABORT>
	</cfoutput>
</cfif>

<!--- If marks are on the form it must be an Update form and not an Add form --->
<cfif StructKeyExists(form, "RefereeMarksH") OR StructKeyExists(form, "RefereeMarksA") >
	<!--- Check that marks have not been given to a "Blank" referee --->
	<cfif Form.RefereeMarksH IS NOT "" AND QCheckReferee.RName IS "">
		<cfoutput>
		<span class="pix24boldred">
		Who has been given #form.RefereeMarksH# marks by the home team?<BR><BR>
		Press the Back button on your browser.....
		</span>
		<CFABORT>
		</cfoutput>
	</cfif>
	<cfif Form.RefereeMarksA IS NOT "" AND QCheckReferee.RName IS "">
		<cfoutput>
		<span class="pix24boldred">
		Who has been given #form.RefereeMarksA# marks by the away team?<BR><BR>
		Press the Back button on your browser.....
		</span>
		<CFABORT>
		</cfoutput>
	</cfif>

			<cfswitch expression="#request.LeagueType#">
				<cfcase value="Normal">
						<cfif Form.AsstRef1Marks IS NOT "" AND QCheckAsstRef1.RName IS "" >
							<cfoutput>
							<span class="pix24boldred">
							Unspecified Assistant Referee 1 has been given #form.AsstRef1Marks# marks!<BR><BR>
							Press the Back button on your browser.....
							</span>
							<CFABORT>
							</cfoutput>
						</cfif>
						
						<cfif Form.AsstRef2Marks IS NOT "" AND QCheckAsstRef2.RName IS "" >
							<cfoutput>
							<span class="pix24boldred">
							Unspecified Assistant Referee 2 has been given #form.AsstRef2Marks# marks!<BR><BR>
							Press the Back button on your browser.....
							</span>
							<CFABORT>
							</cfoutput>
						</cfif>
						<!--- Check maximum 10 Assistant Referee1 marks --->
						<cfif Form.AsstRef1Marks IS NOT "">
							<cfif request.RefMarksOutOfHundred IS "Yes">	
								<cfif Form.AsstRef1Marks GT 100 >
									<cfoutput>
									<span class="pix24boldred">
									Assistant Referee 1 "#QCheckAsstRef1.RName#" has been given #form.AsstRef1Marks# marks! Maximum is 100<BR><BR>
									Press the Back button on your browser.....
									</span>
									<CFABORT>
									</cfoutput>
								</cfif>
							<cfelse>
								<cfif Form.AsstRef1Marks GT 10 >
									<cfoutput>
									<span class="pix24boldred">
									Assistant Referee 1 "#QCheckAsstRef1.RName#" has been given #form.AsstRef1Marks# marks! Maximum is 10<BR><BR>
									Press the Back button on your browser.....
									</span>
									<CFABORT>
									</cfoutput>
								</cfif>
							</cfif>
						</cfif>		
						
						<!--- Check maximum 10 Assistant Referee2 marks --->
						<cfif Form.AsstRef2Marks IS NOT "">
							<cfif request.RefMarksOutOfHundred IS "Yes">		
								<cfif Form.AsstRef2Marks GT 100 >
									<cfoutput>
									<span class="pix24boldred">
									Assistant Referee 2 "#QCheckAsstRef2.RName#" has been given #form.AsstRef2Marks# marks! Maximum is 100<BR><BR>
									Press the Back button on your browser.....
									</span>
									<CFABORT>
									</cfoutput>
								</cfif>
							<cfelse>
								<cfif Form.AsstRef2Marks GT 10 >
									<cfoutput>
									<span class="pix24boldred">
									Assistant Referee 2 "#QCheckAsstRef2.RName#" has been given #form.AsstRef2Marks# marks! Maximum is 10<BR><BR>
									Press the Back button on your browser.....
									</span>
									<CFABORT>
									</cfoutput>
								</cfif>
							</cfif>
						</cfif>
						
				</cfcase>
				<cfcase value="Contributory">
						<!--- assessor checks --->
						<cfif Form.AssessmentMarks IS NOT "" AND QCheckAssessor.RName IS "" >
							<cfoutput>
							<span class="pix24boldred">
							Unspecified Assessor has been given #form.AssessmentMarks# marks!<BR><BR>
							Press the Back button on your browser.....
							</span>
							<CFABORT>
							</cfoutput>
						</cfif>
						<cfif Form.AssessmentMarks GT 100 >
							<cfoutput>
							<span class="pix24boldred">
							Assessor "#QCheckAssessor.RName#" has been given #form.AssessmentMarks# marks! Maximum is 100<BR><BR>
							Press the Back button on your browser.....
							</span>
							<CFABORT>
							</cfoutput>
						</cfif>



						<cfif Form.AsstRef1MarksH IS NOT "" AND QCheckAsstRef1.RName IS "" >
							<cfoutput>
							<span class="pix24boldred">
							Unspecified Assistant Referee 1 has been given #form.AsstRef1MarksH# marks by the Home team!<BR><BR>
							Press the Back button on your browser.....
							</span>
							<CFABORT>
							</cfoutput>
						</cfif>
						<cfif Form.AsstRef1MarksA IS NOT "" AND QCheckAsstRef1.RName IS "" >
							<cfoutput>
							<span class="pix24boldred">
							Unspecified Assistant Referee 1 has been given #form.AsstRef1MarksA# marks by the Away team!<BR><BR>
							Press the Back button on your browser.....
							</span>
							<CFABORT>
							</cfoutput>
						</cfif>
						<cfif Form.AsstRef2MarksH IS NOT "" AND QCheckAsstRef2.RName IS "" >
							<cfoutput>
							<span class="pix24boldred">
							Unspecified Assistant Referee 2 has been given #form.AsstRef2MarksH# marks by the Home team!<BR><BR>
							Press the Back button on your browser.....
							</span>
							<CFABORT>
							</cfoutput>
						</cfif>
						<cfif Form.AsstRef2MarksA IS NOT "" AND QCheckAsstRef2.RName IS "" >
							<cfoutput>
							<span class="pix24boldred">
							Unspecified Assistant Referee 2 has been given #form.AsstRef2MarksA# marks by the Away team!<BR><BR>
							Press the Back button on your browser.....
							</span>
							<CFABORT>
							</cfoutput>
						</cfif>
						<!--- Check Assistant Referee 1 and Assistant Referee 2   Home & Away marks --->
						<cfif request.RefMarksOutOfHundred IS "Yes">	
							<cfif Form.AsstRef1MarksH GT 100 >
								<cfoutput>
								<span class="pix24boldred">
								Assistant Referee 1 "#QCheckAsstRef1.RName#" has been given #form.AsstRef1MarksH# marks from Home team! Maximum is 100<BR><BR>
								Press the Back button on your browser.....
								</span>
								<CFABORT>
								</cfoutput>
							</cfif>
							<cfif Form.AsstRef1MarksA GT 100 >
								<cfoutput>
								<span class="pix24boldred">
								Assistant Referee 1 "#QCheckAsstRef1.RName#" has been given #form.AsstRef1MarksA# marks from Away team! Maximum is 100<BR><BR>
								Press the Back button on your browser.....
								</span>
								<CFABORT>
								</cfoutput>
							</cfif>
							<cfif Form.AsstRef2MarksH GT 100 >
								<cfoutput>
								<span class="pix24boldred">
								Assistant Referee 2 "#QCheckAsstRef2.RName#" has been given #form.AsstRef2MarksH# marks from Home team! Maximum is 100<BR><BR>
								Press the Back button on your browser.....
								</span>
								<CFABORT>
								</cfoutput>
							</cfif>
							<cfif Form.AsstRef2MarksA GT 100 >
								<cfoutput>
								<span class="pix24boldred">
								Assistant Referee 2 "#QCheckAsstRef2.RName#" has been given #form.AsstRef2MarksA# marks from Away team! Maximum is 100<BR><BR>
								Press the Back button on your browser.....
								</span>
								<CFABORT>
								</cfoutput>
							</cfif>
						<cfelse>
							<cfif Form.AsstRef1MarksH GT 10 >
								<cfoutput>
								<span class="pix24boldred">
								Assistant Referee 1 "#QCheckAsstRef1.RName#" has been given #form.AsstRef1MarksH# marks from Home team! Maximum is 10<BR><BR>
								Press the Back button on your browser.....
								</span>
								<CFABORT>
								</cfoutput>
							</cfif>
							<cfif Form.AsstRef1MarksA GT 10 >
								<cfoutput>
								<span class="pix24boldred">
								Assistant Referee 1 "#QCheckAsstRef1.RName#" has been given #form.AsstRef1MarksA# marks from Away team! Maximum is 10<BR><BR>
								Press the Back button on your browser.....
								</span>
								<CFABORT>
								</cfoutput>
							</cfif>
							<cfif Form.AsstRef2MarksH GT 10 >
								<cfoutput>
								<span class="pix24boldred">
								Assistant Referee 2 "#QCheckAsstRef1.RName#" has been given #form.AsstRef2MarksH# marks from Home team! Maximum is 10<BR><BR>
								Press the Back button on your browser.....
								</span>
								<CFABORT>
								</cfoutput>
							</cfif>
							<cfif Form.AsstRef2MarksA GT 10 >
								<cfoutput>
								<span class="pix24boldred">
								Assistant Referee 2 "#QCheckAsstRef2.RName#" has been given #form.AsstRef2MarksA# marks from Away team! Maximum is 10<BR><BR>
								Press the Back button on your browser.....
								</span>
								<CFABORT>
								</cfoutput>
							</cfif>
						</cfif>

				</cfcase>
				<cfdefaultcase>
					Reached defaultcase in InclCheckOfficials - Aborting
					<CFABORT>	
				</cfdefaultcase>
			</cfswitch>
	
	
	
	
	<!--- Check maximum 10 referee marks from the home club --->
	<cfif Form.RefereeMarksH IS NOT "">
		<cfif request.RefMarksOutOfHundred IS "Yes">
			<cfif Form.RefereeMarksH GT 100 >
				<cfoutput>
				<span class="pix24boldred">
				Referee "#QCheckReferee.RName#" has been given #form.RefereeMarksH# marks! Maximum is 100 from the Home team<BR><BR>
				Press the Back button on your browser.....
				</span>
				<CFABORT>
				</cfoutput>
			</cfif>
		<cfelse>
			<cfif Form.RefereeMarksH GT 10 >
				<cfoutput>
				<span class="pix24boldred">
				Referee "#QCheckReferee.RName#" has been given #form.RefereeMarksH# marks! Maximum is 10 from the Home team<BR><BR>
				Press the Back button on your browser.....
				</span>
				<CFABORT>
				</cfoutput>
			</cfif>
		</cfif>
	</cfif>
	
	<!--- Check maximum 10 referee marks from the away club --->
	<cfif Form.RefereeMarksA IS NOT "">
		<cfif request.RefMarksOutOfHundred IS "Yes">
			<cfif Form.RefereeMarksA GT 100 >
				<cfoutput>
				<span class="pix24boldred">
				Referee "#QCheckReferee.RName#" has been given #form.RefereeMarksA# marks! Maximum is 100 from the Away team<BR><BR>
				Press the Back button on your browser.....
				</span>
				<CFABORT>
				</cfoutput>
			</cfif>
		<cfelse>
			<cfif Form.RefereeMarksA GT 10 >
				<cfoutput>
				<span class="pix24boldred">
				Referee "#QCheckReferee.RName#" has been given #form.RefereeMarksA# marks! Maximum is 10 from the Away team<BR><BR>
				Press the Back button on your browser.....
				</span>
				<CFABORT>
				</cfoutput>
			</cfif>
		</cfif>
	</cfif>
	
	

</cfif>
