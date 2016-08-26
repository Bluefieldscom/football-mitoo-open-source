<!--- 
dsp_process.cfm
Purpose:		process point for import and null processing
Created by:		Terry Riley
On:				14 July 2004
Calls:			header
				footer
				queries/qry_import_process.cfm
				queries/qry_update_nulls_zmast.cfm
Links:			index.cfm
--->
<cfinclude template="queries/qry_import_process.cfm">

<cfinclude template="queries/update_nulls_zmast.cfm">

<cfinclude template="header.cfm">

<p><a href="index.cfm">Back to Main Page</a></p>

<p><strong><span class="textred">Transfer Complete!</span></strong>
<br /><br /><strong>ZMAST</strong> tables imported to MySQL and NULLs sorted
</p>


<cfinclude template="footer.cfm">