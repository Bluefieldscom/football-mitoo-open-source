<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<cfsetting requestTimeOut = "60">
	
	
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">
<cfinclude template="queries/qry_QRegistrationNumber.cfm">
<cfset n = 1>
<cfset RegistrationNumberList = ValueList(QRegistrationNumber.RegistrationNumber)>
<cfset z = ListLen(RegistrationNumberList) >
<cfset UnusedList = "">
<cfloop index="i" from="1" to="#z#"  step="1">
	<cfif ListGetAt(RegistrationNumberList, i) IS i >
	<cfelse>
		<cfset n = i - 1>
		<cfbreak>
	</cfif>
</cfloop>
<cfif n IS 0 >
	<cfset FromNo = 1 >
	<cfset ToNo = ListGetAt(RegistrationNumberList, 1) - 1 >
	<cfif FromNo IS ToNo>
		<cfset UnusedList = ListAppend(UnusedList,"#FromNo#")>
	<cfelse>
		<cfset UnusedList = ListAppend(UnusedList,"#FromNo# to #ToNo#")>
	</cfif>
</cfif>
<cfset n = MAX(n,1)>
<cfloop index="j" from="#n#" to="#z-1#"  step="1">
	<cfset FromNo = ListGetAt(RegistrationNumberList, j) + 1 >
	<cfset ToNo = ListGetAt(RegistrationNumberList, j+1) - 1 >
	<cfif FromNo GT ToNo>
	<cfelseif FromNo IS ToNo>
		<cfset UnusedList = ListAppend(UnusedList,"#FromNo#")>
	<cfelse>
		<cfset UnusedList = ListAppend(UnusedList,"#FromNo# to #ToNo#")>
	</cfif>
</cfloop>
<cfset NoOfCols = 8>
<cfset qqq = ListLen(UnusedList)>
<cfif qqq Mod NoOfCols IS 0 >
	<cfset NoOfBoxesPerCol = qqq / NoOfCols>
<cfelse>
	<cfset NoOfBoxesPerCol = Round((qqq / NoOfCols)+ 0.5) >
</cfif>
<cfoutput>
<table width="100%" border="1" cellspacing="0" cellpadding="10" align="CENTER" >
	<tr valign="TOP">
		<cfloop index="ColN" from="1" to="#NoOfCols#" step="1" >
			<cfset xxx=((#ColN#-1) * #NoOfBoxesPerCol#)+1>
			<cfset yyy=MIN((#ColN# * #NoOfBoxesPerCol#),#qqq#)>
			<td align="center">
				<cfloop index="RowN" from="#xxx#" to="#yyy#" step="1">
					<table border="0" cellspacing="2" cellpadding="0" >
						<tr>
							<td align="center"><span class="pix13realblack">#ListGetAt(UnusedList, RowN)#</span></td>
						</tr>
					</table>
				</cfloop>
			</td>
		</cfloop>
	</tr>
</table>
</cfoutput>