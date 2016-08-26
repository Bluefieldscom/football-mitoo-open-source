<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif StructKeyExists(url, "RegType")>
	<cfif url.RegType IS "F">
		<cfset RegTypeString = "Temporary">
	<cfelseif url.RegType IS "G">
		<cfset RegTypeString = "Lapsed">
	<cfelseif url.RegType IS "E">
		<cfset RegTypeString = "Work Experience">
	<cfelseif url.RegType IS "D">
		<cfset RegTypeString = "Long Loan">
	<cfelseif url.RegType IS "C">
		<cfset RegTypeString = "Short Loan">
	<cfelseif url.RegType IS "B">
		<cfset RegTypeString = "Contract">
	<cfelseif url.RegType IS "U">
		<cfset RegTypeString = "Under 18s">
	<cfelse>
		Invalid RegType Parameter - Aborting
		<cfabort>
	</cfif>
<cfelse>
	Missing RegType Parameter - Aborting
	<cfabort>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><cfoutput>#RegTypeString# Registrations</cfoutput></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<link href="fmstyle.css" rel="stylesheet" type="text/css">

<cfoutput>
<span class="pix18"><strong><cfoutput>#url.LeagueName#</cfoutput></strong><br /><br /></span>

<span class="pix18bold"><cfoutput>#RegTypeString# Registrations</cfoutput><br /></span>
</cfoutput>
<cfif RegTypeString IS "Under 18s">
	<cfinclude template="InclLeagueInfo.cfm">

	<cfset Year18 = LeagueCodeYear - 18 >
	<cfoutput>
	<cfset CutOffDate = "#Year18#-08-31">
	</cfoutput>
	<cfinclude template="queries/qry_QUnder18s.cfm">
	<cfif QUnder18s.RecordCount GT 0 >
		<table border="0" cellpadding="0" cellspacing="0">
		
			<tr>
				<td colspan="6"><span class="pix13bold">Players born on or after 1st September <cfoutput>#Year18#</cfoutput></span></td>
			</tr>
			<tr>
				<td  width="150" height="40" valign="bottom"><span class="pix13bold">Reg No</span></td>
				<td  width="200" height="40" valign="bottom"><span class="pix13bold">Surname</span></td>
				<td  width="200" height="40" valign="bottom"><span class="pix13bold">Forenames</span></td>
				<td  width="200" height="40" valign="bottom"><span class="pix13bold">DoB</span></td>
				<td  width="150" height="40" valign="bottom"><span class="pix13bold">First Day</span></td>
				<td height="40" valign="bottom"><span class="pix13bold">Last Day</span></td>
			</tr>
			<cfoutput query="QUnder18s" group="clubname">
				<tr>
					<td height="30" valign="bottom"><span class="pix13bold">#clubname#</span></td>
				</tr>
				<cfoutput>
					<tr>
						<td><span class="pix13">#NumberFormat(regno, '99999999')#</span></td>
						<td><span class="pix13">#surname#</span></td>
						<td><span class="pix13">#forename#</span></td>
						<td><span class="pix13">#DateFormat(DOB,'DD MMM YYYY')#</span></td>
						<td><span class="pix13">#DateFormat(FirstDay, 'dd mmmm yyyy')#</span></td>
						<td><span class="pix13">#DateFormat(LastDay, 'dd mmmm yyyy')#</span></td>
					</tr>
				</cfoutput>
			</cfoutput>
		</table>
	<cfelse>
		<span class="pix13bold">None Found</span>
	</cfif>
	
	
	<br><hr><br>
	
	<cfoutput>
	<span class="pix18"><strong><cfoutput>#url.LeagueName#</cfoutput></strong><br /><br /></span>
	
	<span class="pix18bold"><cfoutput>#RegTypeString# Registrations</cfoutput><br /></span>
	</cfoutput>
	<cfoutput>
	<cfset CutOffDate = "#Year18#-#Month(Now())#-#Day(Now())#">
	</cfoutput>
	<cfinclude template="queries/qry_QUnder18Today.cfm">
	<cfif QUnder18s.RecordCount GT 0 >
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="6"><span class="pix13bold">Players born after <cfoutput>#DateFormat(CutOffDate, "DD MMMM YYYY")#</cfoutput></span></td>
			</tr>
			<tr>
				<td  width="150" height="40" valign="bottom"><span class="pix13bold">Reg No</span></td>
				<td  width="200" height="40" valign="bottom"><span class="pix13bold">Surname</span></td>
				<td  width="200" height="40" valign="bottom"><span class="pix13bold">Forenames</span></td>
				<td  width="200" height="40" valign="bottom"><span class="pix13bold">DoB</span></td>
				<td  width="150" height="40" valign="bottom"><span class="pix13bold">First Day</span></td>
				<td height="40" valign="bottom"><span class="pix13bold">Last Day</span></td>
			</tr>
			<cfoutput query="QUnder18Today" group="clubname">
				<tr>
					<td height="30" valign="bottom"><span class="pix13bold">#clubname#</span></td>
				</tr>
				<cfoutput>
					<tr>
						<td><span class="pix13">#NumberFormat(regno, '99999999')#</span></td>
						<td><span class="pix13">#surname#</span></td>
						<td><span class="pix13">#forename#</span></td>
						<td><span class="pix13">#DateFormat(DOB,'DD MMM YYYY')#</span></td>
						<td><span class="pix13">#DateFormat(FirstDay, 'dd mmmm yyyy')#</span></td>
						<td><span class="pix13">#DateFormat(LastDay, 'dd mmmm yyyy')#</span></td>
					</tr>
				</cfoutput>
			</cfoutput>
		</table>
	<cfelse>
		<span class="pix13bold">None Found</span>
	</cfif>
	
<cfelse>
	<cfinclude template="queries/qry_QRegTypeInfo.cfm">
	<cfif QRegTypeInfo.RecordCount GT 0 >
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td  width="150" height="40" valign="bottom"><span class="pix13bold">Reg No</span></td>
				<td  width="200" height="40" valign="bottom"><span class="pix13bold">Surname</span></td>
				<td  width="200" height="40" valign="bottom"><span class="pix13bold">Forenames</span></td>
				<td  width="150" height="40" valign="bottom"><span class="pix13bold">First Day</span></td>
				<td height="40" valign="bottom"><span class="pix13bold">Last Day</span></td>
			</tr>
			<cfoutput query="QRegTypeInfo" group="clubname">
				<tr>
					<td height="30" valign="bottom"><span class="pix13bold">#clubname#</span></td>
				</tr>
				<cfoutput>
					<tr>
						<td><span class="pix13">#NumberFormat(regno, '99999999')#</span></td>
						<td><span class="pix13">#surname#</span></td>
						<td><span class="pix13">#forename#</span></td>
						<td><span class="pix13">#DateFormat(FirstDay, 'dd mmmm yyyy')#</span></td>
						<td><span class="pix13">#DateFormat(LastDay, 'dd mmmm yyyy')#</span></td>
					</tr>
				</cfoutput>
			</cfoutput>
		</table>
	<cfelse>
		<span class="pix13bold">None Found</span>
	</cfif>
</cfif>
</body>
</html>
