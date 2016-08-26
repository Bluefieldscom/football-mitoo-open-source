<!--- called by Toolbar1.cfm --->
<cfoutput>
<CFIF FindNoCase("Calendar=Y", ThisURL) GT 0 >
	<CFSET ThisURL = Replace(ThisURL, "Calendar=Y", "Calendar=N")>
<CFELSEIF FindNoCase("Calendar=N", ThisURL) GT 0 >
<CFELSE>
	<CFSET ThisURL = "#ThisURL#&amp;Calendar=N" >
</CFIF>
<a href="#ThisURL#" onmouseover="this.T_BORDERWIDTH=1;this.T_STATIC=true;this.T_DELAY=200;this.T_SHADOWCOLOR='##6A7289';this.T_FONTFACE='#Font_Face#';this.T_BGCOLOR='yellow';this.T_FONTSIZE='14px';this.T_PADDING=5;this.T_WIDTH=300;return escape('click to hide the calendar')"><span class="pix10">hide</span></a>
</cfoutput>