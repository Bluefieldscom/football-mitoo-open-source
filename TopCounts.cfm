<cfif NOT ListFind("Silver,Skyblue",request.SecurityLevel) >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Table of Leading Page Request Counts</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<!-------------------------------------------------------------------------------------------------- 

<!--/* OpenX Javascript Tag v2.8.5 */-->
<!--/*
  * The backup image section of this tag has been generated for use on a
  * non-SSL page. If this tag is to be placed on an SSL page, change the
  *   'http://d1.openx.org/...'
  * to
  *   'https://d1.openx.org/...'
  *
  * This noscript section of this tag only shows image banners. There
  * is no width or height in these banners, so if you want these tags to
  * allocate space for the ad before it shows, you will need to add this
  * information to the <img> tag.
  *
  * If you do not want to deal with the intricities of the noscript
  * section, delete the tag (from <noscript>... to </noscript>). On
  * average, the noscript tag is called from less than 1% of internet
  * users.
  */-->
<script type='text/javascript'><!--//<![CDATA[
   var m3_u = (location.protocol=='https:'?'https://d1.openx.org/ajs.php':'http://d1.openx.org/ajs.php');
   var m3_r = Math.floor(Math.random()*99999999999);
   if (!document.MAX_used) document.MAX_used = ',';
   document.write ("<scr"+"ipt type='text/javascript' src='"+m3_u);
   document.write ("?zoneid=124442");
   document.write ('&amp;cb=' + m3_r);
   if (document.MAX_used != ',') document.write ("&amp;exclude=" + document.MAX_used);
   document.write (document.charset ? '&amp;charset='+document.charset : (document.characterSet ? '&amp;charset='+document.characterSet : ''));
   document.write ("&amp;loc=" + escape(window.location));
   if (document.referrer) document.write ("&amp;referer=" + escape(document.referrer));
   if (document.context) document.write ("&context=" + escape(document.context));
   if (document.mmm_fo) document.write ("&amp;mmm_fo=1");
   document.write ("'><\/scr"+"ipt>");
//]]>--></script><noscript><a href='http://d1.openx.org/ck.php?n=ac28a2cd&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://d1.openx.org/avw.php?zoneid=124442&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=ac28a2cd' border='0' alt='' /></a></noscript>
-------------------------------------------------------------------------------------------------->


<script type="text/javascript">var p="http",d="static";if(document.location.protocol=="https:"){p+="s";d="engine";}var z=document.createElement("script");z.type="text/javascript";z.async=true;z.src=p+"://"+d+".adzerk.net/ados.js";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(z,s);</script>
<script type="text/javascript">
var ados = ados || {};
ados.run = ados.run || [];
ados.run.push(function() {
/* load placement for account: Mitoo, site: football.mitoo, size: 234x60 - Half Banner, zone: 234x60 Zone1*/
ados_add_placement(4936, 21743, "azk54565", 12).setZone(17372);
/* load placement for account: Mitoo, site: football.mitoo, size: 234x60 - Half Banner, zone: 234x60 Zone2*/
ados_add_placement(4936, 21743, "azk55194", 12).setZone(17379);
ados_load();
});</script>


</head>

<body>
<cfif NOT StructKeyExists( url, "Year") >
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfif url.Year IS 2011 OR url.Year IS 2012 OR url.Year IS 2013 >
<cfelse>
	<cflocation url="InvalidOrUnauthorisedRequest.htm" addtoken="no">
	<cfabort>
</cfif>
<cfsilent>
<cfinclude template = "queries/qry_QTopCounts.cfm">
</cfsilent>

<cfoutput>
<span class="pix18bold">Top Fifty Page Request Counter Values (#url.Year#)<BR><BR></span>
<span class="pix13bold">as at #DateFormat(Now(), 'DD MMMM YYYY')# #TimeFormat(Now(), 'HH:MM')#hrs<BR><BR></span>
</cfoutput>
<table border="1" cellpadding="6" cellspacing="2">
<cfoutput query="QCounter" >	
	<tr>
		<td align="right"><span class="pix13bold">#NumberFormat(CounterValue, '999,999,999')#</span></td>
		<td><span class="pix13bold">#NameSort#</span></td>
		<td><span class="pix10">#QCounter.SeasonName# since #DateFormat(CounterStartDateTime, 'DD MMMM YYYY')# #TimeFormat(CounterStartDateTime, 'HH:MM')#hrs</span></td>
	</tr>
</cfoutput>		
</table>


