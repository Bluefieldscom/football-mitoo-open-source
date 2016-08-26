<!--- called by inclShowJABOnly.cfm 

<cfset SupprWarningList = '' >
<cfquery name="QSuppressedWarnings" datasource="#request.DSN#" >
	SELECT 
			Concat(LeagueCode, ' ', Reason, ' ', RegNo1, ' ', RegNo2) as SupprWarning	
	FROM 
			playerduplicatenowarnings
	ORDER BY
			LeagueCode, Reason
</cfquery>

<cfif QSuppressedWarnings.RecordCount GT 0>
	<cfset SupprWarningList = ValueList(QSuppressedWarnings.SupprWarning)>
</cfif>

--->
<cfquery name="QAnyROYWarnings" datasource="#request.DSN#" >
	SELECT 
			LeagueCode,
			Reason,
			RegNo1,
			RegNo2,
			Concat(LeagueCode,Reason,RegNo1,RegNo2)  	
	FROM 
			playerduplicatewarnings
	WHERE
			Concat(Upper(LeagueCode),Reason,RegNo1,RegNo2) NOT IN (SELECT Concat(Upper(LeagueCode),Reason,RegNo1,RegNo2) FROM playerduplicatenowarnings)
</cfquery>

<cfquery name="QWarnings" datasource="#request.DSN#" >
	SELECT 
		DISTINCT LeagueCode   
	FROM 
		playerduplicatenowarnings
	WHERE
		reason=1
	ORDER BY
		LeagueCode
</cfquery>
