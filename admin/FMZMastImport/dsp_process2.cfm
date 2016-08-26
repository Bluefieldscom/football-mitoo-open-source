<!--- 
dsp_process2.cfm
Purpose:		process point for suffix updates
Created by:		Terry Riley
On:				14 July 2004
Calls:			header
				footer
				queries/qry_update2digit_to4digit.cfm
Links:			index.cfm
--->

<cfinclude template="queries/qry_update2digit_to4digit.cfm">

<cfinclude template="header.cfm">

<p><a href="index.cfm">Back to Main Page</a></p>

<p><strong><span class="textred">All suffixes upgraded to 4-digit!</span></strong>
</p>

<cfinclude template="footer.cfm">