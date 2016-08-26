<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- this is in Administration Reports --->

<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<!--- ========================================================================================== --->
<cfif NOT StructKeyExists(form, "StateVector") >
<!---
																					*****************
																					* First time in *
																					*****************
--->
	
	<CFFORM NAME="AppsQuery" ACTION="AppearancesQuery.cfm" >
		<cfoutput>
			<input type="Hidden" name="StateVector" value="1">
			<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
			<input type="Hidden" name="ID" value="#QLeagueCode.ID#">
			<cflock scope="session" timeout="10" type="exclusive">			
				<cfset Session.StageInConversation ="First time in">
				<cfset Session.TIDSelected1 = "">
				<cfset Session.TIDSelected2 = "">
				<cfset Session.OIDSelected1 = "">
				<cfset Session.OIDSelected2 = "">
				<cfset Session.DIDSelected1 = "">
				<cfset Session.DIDSelected2 = "">
				<cfset Session.NoOfAppearancesSelected1 = "">
				<cfset Session.NoOfAppearancesSelected2 = "">
			</cflock>			
		</cfoutput>
		<table width="100%" border="0" cellspacing="2" cellpadding="2" align="CENTER" bgcolor="Aqua">
			<tr>
				<td>
					<span class="pix13">List everyone who has played</span>
				</td>
				<td>
					<cfset NoOfAppearancesSelected = Session.NoOfAppearancesSelected1>								
					<cfinclude template="InclTblChooseNoOfAppearances.cfm">					
				</td>
				<td>
					<span class="pix13">or more games for</span>
				</td>
				<td>
					<cfset TIDSelected = Session.TIDSelected1>				
					<cfinclude template="InclTblChooseTeam.cfm">					
				</td>
				<td>
					<cfset OIDSelected = Session.OIDSelected1>				
					<cfinclude template="InclTblChooseOrdinal.cfm">					
				</td>
				<td>
					<span class="pix13">in</span>
				</td>
				<td>
					<cfset DIDSelected = Session.DIDSelected1>																
					<cfinclude template="InclTblChooseDivision.cfm">					
				</td>
			</tr>
			<tr>
				<td>
					<span class="pix13">and has also played</span>
				</td>
				<td>
					<cfset NoOfAppearancesSelected = Session.NoOfAppearancesSelected2>												
					<cfinclude template="InclTblChooseNoOfAppearances.cfm">					
				</td>
				<td>
					<span class="pix13">or more games for</span>
				</td>
				<td>
					<cfset TIDSelected = Session.TIDSelected2>								
					<cfinclude template="InclTblChooseTeam.cfm">					
				</td>
				<td>
					<cfset OIDSelected = Session.OIDSelected2>								
					<cfinclude template="InclTblChooseOrdinal.cfm">					
				</td>
				<td>
					<span class="pix13">in</span>
				</td>
				<td>
					<cfset DIDSelected = Session.DIDSelected2>												
					<cfinclude template="InclTblChooseDivision.cfm">					
				</td>
			</tr>


		</table>
	<!---
								*************
								* OK Button *
								*************
	--->
		<table width="100%" border="0" cellspacing="2" cellpadding="2" align="CENTER" bgcolor="Aqua">
				<tr>
					<td height="40" align="CENTER">
						<input type="Submit" value="OK">
					</td>
				</tr>
		</table>
	</cfform>
	
<cfelseif StructKeyExists(form, "StateVector") >
<!---
																					***************
																					* 2nd time in *
																					***************
--->
	<cfif Form.StateVector IS 1>

	<!--- repeat the form above the results of the query --->
		<CFFORM NAME="AppsQuery" ACTION="AppearancesQuery.cfm" >
			<cfoutput>
				<input type="Hidden" name="StateVector" value="1">
				<input type="Hidden" name="LeagueCode" value="#LeagueCode#">
				<input type="Hidden" name="ID" value="#QLeagueCode.ID#">
				<cflock scope="session" timeout="10" type="exclusive">				
						<cfset Session.StageInConversation ="2nd time in">
						<cfset Session.TIDSelected1 = "#ListGetAt(Form.TID, 1)#">
						<cfset Session.TIDSelected2 = "#ListGetAt(Form.TID, 2)#">
						<cfset Session.OIDSelected1 = "#ListGetAt(Form.OID, 1)#">
						<cfset Session.OIDSelected2 = "#ListGetAt(Form.OID, 2)#">
						<cfset Session.DIDSelected1 = "#ListGetAt(Form.DID, 1)#">
						<cfset Session.DIDSelected2 = "#ListGetAt(Form.DID, 2)#">
						<cfset Session.NoOfAppearancesSelected1 = "#ListGetAt(Form.NoOfAppearances, 1)#">
						<cfset Session.NoOfAppearancesSelected2 = "#ListGetAt(Form.NoOfAppearances, 2)#">
				</cflock>			
			</cfoutput>
			<table width="100%" border="0" cellspacing="2" cellpadding="2" align="CENTER" bgcolor="Aqua">
				<tr>
				
					<td>
						<span class="pix13">List everyone who has played</span>
					</td>
					<td>
						<cfset NoOfAppearancesSelected = Session.NoOfAppearancesSelected1>													
						<cfinclude template="InclTblChooseNoOfAppearances.cfm">					
					</td>
					<td>
						<span class="pix13">or more games for</span>
					</td>
					<td>
						<cfset TIDSelected = Session.TIDSelected1>
						<cfinclude template="InclTblChooseTeam.cfm">					
					</td>
					<td>
						<cfset OIDSelected = Session.OIDSelected1>
						<cfinclude template="InclTblChooseOrdinal.cfm">					
					</td>
					<td>
						<span class="pix13">in</span>
					</td>
					<td>
						<cfset DIDSelected = Session.DIDSelected1>																	
						<cfinclude template="InclTblChooseDivision.cfm">					
					</td>
				</tr>
				<tr>
					<td>
						<span class="pix13">and has also played</span>
					</td>
					<td>
						<cfset NoOfAppearancesSelected = Session.NoOfAppearancesSelected2>													
						<cfinclude template="InclTblChooseNoOfAppearances.cfm">					
					</td>
					<td>
						<span class="pix13">or more games for</span>
					</td>
					<td>
						<cfset TIDSelected = Session.TIDSelected2>
						<cfinclude template="InclTblChooseTeam.cfm">					
					</td>
					<td>
						<cfset OIDSelected = Session.OIDSelected2>
						<cfinclude template="InclTblChooseOrdinal.cfm">					
					</td>
					<td>
						<span class="pix13">in</span>
					</td>
					<td>
						<cfset DIDSelected = Session.DIDSelected2>																						
						<cfinclude template="InclTblChooseDivision.cfm">					
					</td>
				</tr>
	
	
			</table>
		<!---
									*************
									* OK Button *
									*************
		--->
			<table width="100%" border="0" cellspacing="2" cellpadding="2" align="CENTER" bgcolor="Aqua">
					<tr>
						<td height="40" align="CENTER">
							<input type="Submit" value="OK">
						</td>
					</tr>
			</table>
		</cfform>
		<!--- check for SQL combinations that are not allowed --->
		
		<cfif ListGetAt(Form.TID, 1) IS "ANY OTHER CLUB" AND ListGetAt(Form.TID, 2) IS "ANY CLUB">
			<span class="pix18boldred">ANY OTHER CLUB and ANY CLUB are not allowed together</span>
			<CFABORT>
		</cfif>
		<cfif ListGetAt(Form.TID, 2) IS "ANY OTHER CLUB" AND ListGetAt(Form.TID, 1) IS "ANY CLUB">
			<span class="pix18boldred">ANY CLUB and ANY OTHER CLUB are not allowed together</span>
			<CFABORT>
		</cfif>
		<cfif ListGetAt(Form.TID, 1) IS "ANY OTHER CLUB" AND ListGetAt(Form.TID, 2) IS "ANY OTHER CLUB" >
			<span class="pix18boldred">ANY OTHER CLUB and ANY OTHER CLUB are not allowed together</span>
			<CFABORT>
		</cfif>
		
		
		<!--- now show the results --->
		<cfinclude template="queries/qry_QTeam01.cfm">
		<cfset BadTIDList = ValueList(QTeam01.ID)>
		<cfset BadTIDCount = QTeam01.RecordCount>
		<cfif BadTIDCount IS 0>
			<cfset BadTIDList = ListAppend(BadTIDList, 0)>
		</cfif>

		<cfinclude template="queries/qry_QOrdinal01.cfm">
		<cfset BadOIDList = ValueList(QOrdinal01.ID)>
		<cfset BadOIDCount = QOrdinal01.RecordCount>
		<cfif BadOIDCount IS 0>
			<cfset BadOIDList = ListAppend(BadOIDList, 0)>
		</cfif>

		<cfinclude template="queries/qry_QAppearance.cfm">
		<cfif QAppearance.RecordCount IS 0>
			<span class="pix13bold">No players found</span>
		<cfelse>
			<table width="50%" border="1" cellspacing="1" cellpadding="5" align="CENTER">
				<cfoutput query="QAppearance">
					<tr>
						<td align="RIGHT"><a href="PlayersHist.cfm?PI=#PID#&LeagueCode=#LeagueCode#"><span class="pix10">see</span></a></td>			
						<td><span class="pix10"><strong>#PlayerSurname#</strong> #PlayerForename#</span></td> 
					</tr>
				</cfoutput>
			</table>
		</cfif>
	<cfelseif Form.StateVector IS 2>
		22222222222222222222
	</cfif>
</cfif>
