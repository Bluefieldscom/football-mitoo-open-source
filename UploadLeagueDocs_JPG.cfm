<cfif NOT ListFind("Silver",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfif NOT StructKeyExists(form, "StateVector")>
	<!--- First time in --->
	<CFFORM ACTION="UploadLeagueDocs_JPG.cfm?LeagueCode=#LeagueCode#"  METHOD="post" enctype="multipart/form-data" >
		<input type="Hidden" name="StateVector" value="1">
		<table width="100%">
			<tr>
				<td align="CENTER">
					<table border="0" cellspacing="0" cellpadding="2" bgcolor="Aqua">
						<tr>
							<td><span class="pix10bold">Choose the .jpg File</span></td>
						</tr>
						<tr>
							<td><input name="ChosenFile" type="file" size="60" /></td>
						</tr>
						<tr>
							<td><span class="pix10">Description </span><input name="Description" type="text" size="60" /></td>
						</tr>
						<tr align="CENTER">
							<cfoutput>
								<td colspan="1"><span class="pix13"><input type="Submit" name="Action" value="OK"></span></td>				
							</cfoutput>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</cfform>
<cfelse>
	<cfif SERVER_NAME contains '127.0.0.1' OR SERVER_NAME contains 'localhost'>
		<cfset DestinationJPGFolder = "C:\ColdFusion8\wwwroot\mitoo\fmstuff\jpg">
		<cfset DestinationLeagueFolder = "C:\ColdFusion8\wwwroot\mitoo\fmstuff\jpg\#LeagueCodePrefix#">
		<cfdirectory action="list" directory="#DestinationJPGFolder#" filter="#LeagueCodePrefix#" name="JPGSubdirList">
		<cfif JPGSubdirList.RecordCount IS 0>
			<!--- create a new subdirectory for this league if it does not already exist --->
			<cfdirectory action="create" directory="#DestinationLeagueFolder#">
		</cfif>
		<cffile action="upload"
			filefield="ChosenFile"
			destination="#DestinationLeagueFolder#"
			nameconflict="overwrite">
		<cfinclude template="queries/ins_LeagueDocs_JPG.cfm">
	<cfelse>
		<cfloop index="i" from="1" to="3" step="1" >
			<cfset DestinationJPGFolder = "C:\JRun4\servers\mitoo#i#\cfusion.ear\cfusion.war\fmstuff\jpg">
			<cfset DestinationLeagueFolder = "C:\JRun4\servers\mitoo#i#\cfusion.ear\cfusion.war\fmstuff\jpg\#LeagueCodePrefix#">
			<cfdirectory action="list" directory="#DestinationJPGFolder#" filter="#LeagueCodePrefix#" name="JPGSubdirList">
			<cfif JPGSubdirList.RecordCount IS 0>
				<!--- create a new subdirectory for this league if it does not already exist --->
				<cfdirectory action="create" directory="#DestinationLeagueFolder#">
			</cfif>
			<cffile action="upload"
				filefield="ChosenFile"
				destination="#DestinationLeagueFolder#"
				nameconflict="overwrite">
		</cfloop>
		<cfinclude template="queries/ins_LeagueDocs_JPG.cfm">
	</cfif>
</cfif>
