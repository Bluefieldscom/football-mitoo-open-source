<!--- 
index.cfm
Purpose:		Main entry (and action link) page
Created by:		Terry Riley
On:				14 July 2004
Calls:			header
				footer
				dsp_process.cfm
				dsp_process2.cfm
--->
<cfinclude template="header.cfm">

<p>
This sequence will import data from the original ZMAST Acess database into MySQL.
<br /><br />The original ZMAST database should be re-registered as ZMAST9.
<br /><br />The ZMAST MySQL database should be registered in place of the original.
</p>
<p>
This should take about 30 seconds to a minute &nbsp;&nbsp;&nbsp;&nbsp;<a href="dsp_process.cfm">Continue</a>
</p>


<p>
<span class="textred"><strong>Process to convert 2-digit suffixes to 4-digit</strong></span>
<br /><br />
This sequence will convert all suffixes from 2-digit to 4-digit, including the addition of '2000' to those from that year. It should <span class="textred">ONLY</span> be used <span class="textred">AFTER</span> all data has been imported to MySQL, and we are satisfied that the ZMAST tables themselves will run with the old classifications.
</p>
<p>
Takes about 20 seconds&nbsp;&nbsp;&nbsp;&nbsp;<a href="dsp_process2.cfm">Continue</a>
</p>


<cfinclude template="footer.cfm">
