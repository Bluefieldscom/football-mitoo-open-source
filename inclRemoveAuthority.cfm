<cfset request.SecurityLevel = "White">
<cflock scope="session" timeout="10" type="exclusive">
	<cfset session.SecurityLevel = request.SecurityLevel>
	<cflocation addtoken="no" url="InvalidOrUnauthorisedRequest.htm">
	<cfabort>
</cflock>
