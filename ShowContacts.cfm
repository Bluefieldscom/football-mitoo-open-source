<cfparam name="LeagueName" default="">
<cfparam name="SeasonName" default=""> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><cfoutput>Contacts - #SeasonName# - #LeagueName#</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
	
</head>
<body>
<!---  
                                                               ****************
                                                               *  Committee   *
                                                               ****************
--->
<cfset ThisColSpan = 4>
	<cfinclude template="queries/qry_QCommittee.cfm">
			
			<table width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
				<cfoutput>
				<tr>
					<td colspan="#ThisColSpan#" align="center">
					<span class="pix10bold">#QCommittee.RecordCount# <cfif QCommittee.RecordCount IS "1">Contact<cfelse>Contacts</cfif></span>
					</td>
				</tr>
				<tr>
					<td colspan="#ThisColSpan#" align="center">
					<span class="pix18bold">#LeagueName#</span>
					</td>
				</tr>
				<tr>
					<td colspan="#ThisColSpan#" align="center">
					<span class="pix13bold">#SeasonName#</span>
					</td>
				</tr>
				</cfoutput>
				<cfoutput query="QCommittee">
					<cfif ShortCol IS 'HIDE'>
					<cfelse>
						<tr>
							<td width="30%" valign="top">
								<span class="pix13bolditalic">#LongCol#</span><br>
								<span class="pix13bold">#MemberName#</span><br>
								<cfif ListFind("Silver,Skyblue",request.SecurityLevel)><a href="UpdateForm.cfm?TblName=Committee&ID=#ID#&LeagueCode=#LeagueCode#"><span class="pix13">upd/del</span></a></cfif>
							</td>
							<cfif ShowHideAddress IS 0>
								<td width="25%" valign="top">
									<span class="pix13">#AddressLine1#<br>#AddressLine2#<br>#AddressLine3#<br>#PostCode#</span>
								</td>
							<cfelseif ListFind("Silver,Skyblue",request.SecurityLevel) AND ShowHideAddress IS 1 >
								<td width="25%" valign="top">
									<span class="pix13"><u><strong>hidden address</strong></u><br>#AddressLine1#<br>#AddressLine2#<br>#AddressLine3#<br>#PostCode#</span>
								</td>
							<cfelse>
								<td width="25%" valign="top">
									<span class="pix13"></span>
								</td>
							</cfif>
							
							<td width="25%" valign="top">
								<cfif ShowHideEmailAddress1 IS 0>
									<span class="pix10"><a href="mailto:#EmailAddress1#?subject=#replacelist(LeagueName,"&,<br>,<br />", "and, , ")#">#EmailAddress1#</a><br><br></span>
								<cfelseif ListFind("Silver,Skyblue",request.SecurityLevel)>
									<span class="pix10"><u><strong>hidden</strong></u> <a href="mailto:#EmailAddress1#?subject=#replacelist(LeagueName,"&,<br>,<br />", "and, , ")#">#EmailAddress1#</a><br><br></span>
								</cfif>
								<cfif ShowHideEmailAddress2 IS 0>
									<span class="pix10"><a href="mailto:#EmailAddress2#?subject=#replacelist(LeagueName,"&,<br>,<br />", "and, , ")#">#EmailAddress2#</a></span>
								<cfelseif ListFind("Silver,Skyblue",request.SecurityLevel)>
									<span class="pix10"><u><strong>hidden</strong></u> <a href="mailto:#EmailAddress2#?subject=#replacelist(LeagueName,"&,<br>,<br />", "and, , ")#">#EmailAddress2#</a></span>
								</cfif>
							</td>
							<td width="20%" valign="top">
								<cfif ShowHideHomeTel IS 0 AND Len(Trim(HomeTel)) GT 0 ><span class="pix13">Home: #HomeTel#</span><br></cfif>
								<cfif ListFind("Silver,Skyblue",request.SecurityLevel) AND ShowHideHomeTel IS 1 AND Len(Trim(HomeTel)) GT 0 ><span class="pix13"><u><strong>hidden</strong></u> Home: #HomeTel#</span><br></cfif>
								<cfif ShowHideWorkTel IS 0 AND Len(Trim(WorkTel)) GT 0 ><span class="pix13">Work: #WorkTel#</span><br></cfif>
								<cfif ListFind("Silver,Skyblue",request.SecurityLevel) AND ShowHideWorkTel IS 1 AND Len(Trim(WorkTel)) GT 0 ><span class="pix13"><u><strong>hidden</strong></u> Work: #WorkTel#</span><br></cfif>
								<cfif ShowHideMobileTel IS 0 AND Len(Trim(MobileTel)) GT 0 ><span class="pix13">Mobile: #MobileTel#</span><br></cfif>
								<cfif ListFind("Silver,Skyblue",request.SecurityLevel) AND ShowHideMobileTel IS 1 AND Len(Trim(MobileTel)) GT 0 ><span class="pix13"><u><strong>hidden</strong></u> Mobile: #MobileTel#</span><br></cfif>
							</td>

						</tr>
						<tr>
							<td colspan="#ThisColSpan#">
								<span class="pix13">#Notes#</span>
							</td>
						</tr>
						<tr>
							<td colspan="#ThisColSpan#"  class="bg_white" ></td>
						</tr>

					</cfif>
				</cfoutput>
			</table>
			

