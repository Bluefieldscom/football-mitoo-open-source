<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- Trick I'm using to suppress any headings --->
<cfset BatchInput = "No">
<cfinclude template="InclBegin.cfm">

<cfinclude template="queries/qry_QLogInHistory.cfm">
<table border="1" cellspacing="1" cellpadding="1">
	<tr>

	<cfoutput query="QLogInHistory" group="YearNo">
		<cfoutput group="MonthNo">
		<td align="center" valign="top" ><span class="pix13bold">#YearNo#<BR>#MonthAsString(MonthNo)#</span>
			<table  border="0" cellspacing="1" cellpadding="1">
			<cfoutput group="DayNo">
			<tr>
				<td>
				<span class="pix10boldnavy">#DayOfWeekAsString(DayOfWeek(DateTimeStamp))# #DayNo#</span>
					<table  border="0" cellspacing="1" cellpadding="1">
						<cfoutput>
							<tr>
								<td>
									<span class="pix10">#TimeFormat(DateTimeStamp , "HH:mm")#</span>
								</td>
								<td>
									<span class="pix10">#UserName#</span>
								</td>
							</tr>
						</cfoutput>
					</table>
				</td>
			</tr>
			</cfoutput>
			</table>
		</td>
		</cfoutput>
	</cfoutput>
	</tr>
</table>
