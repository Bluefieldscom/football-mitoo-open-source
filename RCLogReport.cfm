<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) AND NOT DateDiff('h', Now(),'2012-08-01') GT 0 >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<!--- applies to season 2012 onwards only --->
<cfif NOT RIGHT(request.dsn,4) GE 2012>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfinclude template="InclBegin.cfm">
<!---
						**************************************************************************************************************
						* Show the league administrator all changes made by administrators (B), referees or clubs (L), or Julian (V) *
						************ skyBlue ****** yelLow ***** silVer **************************************************************
QUpdateHistory
	SELECT 
		SortOrder, 
		TableName, 
		ID1, 
		ID2, 
		Date1, 
		FieldName, 
		BeforeValue, 
		AfterValue, 
		LeagueCode, 
		SecurityLevel, 
		TStamp,
		Date(TStamp) as TheDate, 
		Time(TStamp) as TheTime
	FROM 
		updatelog 
	WHERE
		LeagueCode = <cfqueryparam value = '#request.filter#' cfsqltype="CF_SQL_VARCHAR" maxlength="5">
		AND TStamp BETWEEN DATE_SUB(NOW(), INTERVAL #TheInterval#) AND NOW()
	ORDER BY
		SecurityLevel, SortOrder, TStamp, ID1, ID2 

--->
<cfinclude template="queries/qry_QUpdateHistory.cfm">
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="0">
	<cfoutput query="QUpdateHistory" group="SecurityLevel" >
		<tr>
			<td align="center">
				<cfswitch expression="#SecurityLevel#">
					<cfcase value="B">
						<span class="mainHeading"><strong>Done by Administrator</strong></span>
					</cfcase>
					<cfcase value="L">
						<span class="mainHeading"><strong>Done by Club or Referee</strong></span>
					</cfcase>
					<cfcase value="V">
						<span class="mainHeading"><strong>Done by Julian</strong></span>
					</cfcase>
				</cfswitch>
			</td>
		</tr>
		<cfoutput group="SortOrder" >
				<tr bgcolor="Ghostwhite">
					<td align="center">
						<cfswitch expression="#TableName#">
							<cfcase value="teamdetails">
								<span class="pix13boldrealblack">Changes to Team Details</span>
							</cfcase>
							<cfcase value="referee">
								<span class="pix13boldrealblack">Changes to Referee Details</span>
							</cfcase>
							<cfcase value="refavailable">
								<span class="pix13boldrealblack">Changes to Referee Availability</span>
							</cfcase>
						</cfswitch>
					</td>
				</tr>
				<cfoutput group="TheDate" >	
					<tr bgcolor="Ghostwhite">
						<td align="left">
							<span class="pix13bold">#DateFormat(TStamp, 'DDDD, DD MMMM YYYY')#</span>
						</td>
					</tr>
					<cfswitch expression="#TableName#">
<!---					
					****************
					* Team Details *
					****************
--->					
						<cfcase value="teamdetails">
							<cfoutput group="ID1" >
								<cfoutput group="ID2" >
									<cfinclude template = "queries/qry_QRCLogReportTeamName.cfm">
									<tr bgcolor="Ghostwhite">
										<td align="left">
											<span class="pix10bold">#QRCLogReportTeamName.OutputText#</span>
										</td>
									</tr>
									<cfoutput>
										<tr <cfif DateDiff("h",TStamp, Now()) LT 1 >bgcolor="Mistyrose"</cfif>>
											<td align="left">
												<span class="pix10">#FieldName# was changed <cfif Trim(BeforeValue) IS ""><cfelse> from <em>#BeforeValue#</em></cfif> to <cfif Trim(AfterValue) IS "">empty<cfelse><em>#AfterValue#</em></cfif> at #TimeFormat(TStamp, 'HH:MM')#</span>
											</td>
										</tr>
									</cfoutput>
								</cfoutput><!--- group="ID2" --->
							</cfoutput><!--- group="ID1" --->
						</cfcase>
<!---					
					****************
					* Referee      *
					****************
--->					
						<cfcase value="referee">
							<cfoutput group="ID1" >
								<cfoutput group="ID2" >
									<cfset RID = ID1 >
									<cfinclude template = "queries/qry_QRCLogReportRefsName.cfm">
									<tr bgcolor="Ghostwhite">
										<td align="left">
											<span class="pix10bold">#QRCLogReportRefsName.OutputText#</span>
										</td>
									</tr>
									<cfoutput>
										<tr <cfif DateDiff("h",TStamp, Now()) LT 1 >bgcolor="Mistyrose"</cfif>>
											<td align="left">
												<span class="pix10">#FieldName# was changed <cfif Trim(BeforeValue) IS ""><cfelse> from <em>#BeforeValue#</em></cfif> to <cfif Trim(AfterValue) IS "">empty<cfelse><em>#AfterValue#</em></cfif> at #TimeFormat(TStamp, 'HH:MM')#</span>
											</td>
										</tr>
									</cfoutput>
								</cfoutput><!--- group="ID2" --->
							</cfoutput><!--- group="ID1" --->
						</cfcase>
<!---					
					************************
					* Referee Availability *
					************************
--->	
						<cfcase value="refavailable">
							<cfoutput group="ID1" >
								<cfoutput group="ID2" >
									<cfset RID = ID2 >
									<cfinclude template = "queries/qry_QRCLogReportRefsName.cfm">
									<tr bgcolor="Ghostwhite">
										<td align="left">
											<span class="pix10bold">#QRCLogReportRefsName.OutputText#</span>
										</td>
									</tr>
									<cfoutput>
										<tr <cfif DateDiff("h",TStamp, Now()) LT 1 >bgcolor="Mistyrose"</cfif>>
											<td align="left">
												<span class="pix10">#DateFormat(Date1,'DDDD, DD MMM YYYY')# <cfif FieldName IS 'Available'>Availability<cfelse>#FieldName#</cfif> was changed <cfif Trim(BeforeValue) IS ""><cfelse> from <em>#BeforeValue#</em></cfif> to <cfif Trim(AfterValue) IS "">Deleted<cfelse><em>#AfterValue#</em></cfif> at #TimeFormat(TStamp, 'HH:MM')#</span>
											</td>
										</tr>
									</cfoutput>
								</cfoutput><!--- group="ID2" --->
							</cfoutput><!--- group="ID1" --->
						</cfcase>
					</cfswitch>
				</cfoutput>
			</cfoutput>
	</cfoutput>
</table>


