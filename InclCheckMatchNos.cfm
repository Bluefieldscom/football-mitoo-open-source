<!--- included by InclInsrtConstit.cfm and InclUpdtConstit.cfm --->

<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<link href="fmstyle.css" rel="stylesheet" type="text/css">
<!--- Check to see if the same MatchNoID or Matchnumber is specified on the same line for This and Next  --->
<cfinclude template="queries/qry_QCheckConstitPair.cfm">
<cfif QCheckConstitPair.RecordCount GT 0>
	<cfoutput query="QCheckConstitPair">
		<span class="pix24boldred">ERROR: #TeamName# #OrdinalName#<BR>This Match and Next Match are both number #NextMatchString#<BR></span>
	</cfoutput>
	<span class="pix24boldred"><BR>Press the Back button on your browser.....</span>
	<CFABORT>
</cfif>

<!--- Check to see if there is more than one ThisMatchNoID per match  --->
<cfinclude template="queries/qry_QCheckPairThis.cfm">
<cfif QCheckPairThis.RecordCount GT 0>
	<cfloop query="QCheckPairThis">
		<cfoutput>
			<span class="pix24boldred">You have #cnt# teams playing in Match No. #ThisMatchString#, there should only be one.<BR></span>
		</cfoutput>
		<cfinclude template="queries/qry_QCheckPairThisDetail.cfm">
		<cfoutput query="QCheckPairThisDetail">
			<span class="pix18boldred">#TeamString# #OrdinalString#<BR></span>
		</cfoutput>
	</cfloop>
</cfif>

<!--- Check to see if there is more than a pair of NextMatchNoIDs per match i.e. more than 2 --->
<cfinclude template="queries/qry_QCheckPairNext.cfm">
<cfif QCheckPairNext.RecordCount GT 0>
	<cfloop query="QCheckPairNext">
		<cfoutput>
			<span class="pix24boldred">You have #cnt# teams with Next Match No. #NextMatchString#, there should be two.<BR></span>
		</cfoutput>
		<cfinclude template="queries/qry_QCheckPairNextDetail.cfm">
		<cfoutput query="QCheckPairNextDetail">
			<span class="pix18boldred">#TeamString# #OrdinalString#<BR></span>
		</cfoutput>
	</cfloop>
</cfif>

<cfif QCheckPairThis.RecordCount GT 0 OR QCheckPairNext.RecordCount GT 0>
	<span class="pix24boldred"><BR>Press the Back button on your browser.....</span>
	<CFABORT>
</cfif>


