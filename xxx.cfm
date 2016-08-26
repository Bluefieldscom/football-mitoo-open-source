<h3>GetTempDirectory Example</h3>

<p>The temporary directory for this ColdFusion server is
    <cfoutput>#GetTempDirectory()#</cfoutput>.</p>
<p>We have created a temporary file called:
<cfoutput>#GetTempFile(GetTempDirectory(),"testFile")#</cfoutput></p>
