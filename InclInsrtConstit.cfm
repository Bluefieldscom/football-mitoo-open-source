<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- called twice (Add & Add Many) by Action.cfm --->
<cfinclude template="queries/qry_QCheckDuplicateC.cfm">
<!--- Check to see if this is already in the Constitution --->
<link href="fmstyle.css" rel="stylesheet" type="text/css">
<cfif QCheckDuplicateC.RecordCount IS NOT 0 >	
	<cfoutput query="QCheckDuplicateC">
	<span class="pix24boldred">#TeamName# #OrdinalName# is already in #DivisionName#<BR><BR></span>
	</cfoutput>
	<span class="pix24boldred">Press the Back button on your browser.....<BR><BR></span>
	<CFABORT>
</cfif>
<cfinclude template="queries/ins_Constitution.cfm">
<!--- Then check for duplicate Match Numbers........... --->
<cfinclude template="InclCheckMatchNos.cfm">	  
		  
		  
		  
		  
