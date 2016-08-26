<!--- 
called from  InclUpdtFixture.cfm (single fixture result) AND InclBatchUpdate2.cfm 
to alert that cached results data should be discarded and new data collected from FM
--->

<cfif ListFind("Silver,Skyblue",request.SecurityLevel)   >
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!--- example test values: <cfset request.dsn = "fm2009"><cfset id = 2><cfset request.filter = "CSSL"> --->
<cfinclude template="queries\qry_QPushResult.cfm">

<!--- send division_id to GR push.php template, which in turn sends SMS to related users --->
<cfif QPushResult.Recordcount IS 1>
	<cfhttp 
       	 	url="http://mdb.goalrun.com/push.php"
			method="Post" resolveurl="Yes">
       	<cfhttpparam name="id" type="URL" value=#QPushResult.division_id#>
   	</cfhttp>
</cfif>
	
