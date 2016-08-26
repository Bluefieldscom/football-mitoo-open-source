<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<!-- LEAVE THIS STYLESHEET BELOW - it is needed when generating HTM files for each County -->
<LINK REL="stylesheet" type="text/css" href="fmstyle.css">
<title>List of Leagues</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<!-----------------------------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------------------->

	<!--- SMS TEXT SERVICE stylesheet --->
	<link rel="stylesheet" href="SMS/styles/nyroModal.css" type="text/css" media="screen" />

</head>
<body style="margin-top:50px">

<div id="note"><img src="http://new.mitoo.co/assets/identity/old/bf-logo-d842163279fa4d2d6bbcdb711dfb85fb.png" class="circle thumb-pic" style="float:left">
<div class="notification-content">
  <strong>We are delighted to announce that Bluefields &amp; Mitoo are now one.</strong>
  <a target="_blank" href="http://more.mitoo.co/news/bluefields-mitoo/">Read more about the exciting news...</a>
</div>

</div>

<cfif StructKeyExists(url, "Year1")>
	<cfset Year1 = url.Year1 >
<cfelse>
	<cfset Year1 = '2013'> <!-- default, change this after the start of the season -->
</cfif>
<cfinclude template="queries/qry_QListOfLeagues.cfm">
<cfset NumberOfLeagues = QListOfLeagues.RecordCount>
<table border="0" cellspacing="2" cellpadding="2" align="CENTER" valign="MIDDLE">
	<cfoutput>
		<tr>
			<td colspan="8" align="CENTER">
			<a href="fmMap.cfm" ADDTOKEN="NO"><img src="mitoo_logo1.png" alt="fmlogo" border="0"></a></td>
		</tr>
	</cfoutput>
	<cfset DefaultLeagueCodeList=ValueList(QListOfLeagues.DefaultLeagueCode)>
	<cfset LeagueNameList=ValueList(QListOfLeagues.LeagueName)>
	<cfset SeasonNameList=ValueList(QListOfLeagues.SeasonName)>
	<cfset NameSortList=ValueList(QListOfLeagues.NameSort)>
	<cfset LeagueBrandList=ValueList(QListOfLeagues.LeagueBrand)>
	<cfset DefaultYouthLeagueList=ValueList(QListOfLeagues.DefaultYouthLeague)>
	<cfset CountiesListList=ValueList(QListOfLeagues.CountiesList,"~")>
	<cfset MitooDotComIDList=ValueList(QListOfLeagues.MitooDotComID)>
	<cfset DefaultDIDList=ValueList(QListOfLeagues.DefaultDID)>
	<cfloop index="I" from="1" to="#NumberOfLeagues#" step="1">
		<tr class="bg_highlight0" onmouseover="this.className='bg_highlight2';" onmouseout="this.className='bg_highlight0';" >		
			<cfoutput>
			<cfset DefaultLeagueCode = ListGetAt(DefaultLeagueCodeList, I)>
			<cfset request.filter = Left(DefaultLeagueCode, (Len(TRIM(DefaultLeagueCode))-4))>
			<cfif ListFind("Silver",request.SecurityLevel) >
				<cfinclude template="queries/qry_QClubCount.cfm">
			</cfif>
			<cfset LeagueName =	ListGetAt(LeagueNameList, I)>
			<cfset SeasonName =	ListGetAt(SeasonNameList, I)>
			<cfset NameSort = ListGetAt(NameSortList, I)>
			<cfset LeagueBrand = ListGetAt(LeagueBrandList, I)>
			<cfset DefaultYouthLeague = ListGetAt(DefaultYouthLeagueList, I)>
			<cfset CountiesList = ListGetAt(CountiesListList, I, "~")>
			<cfset MitooDotComID = ListGetAt(MitooDotComIDList, I)>
			<cfset DefaultDID = ListGetAt(DefaultDIDList, I)>
				<!-- LeagueBrand: 0=Normal,1=NationalLeagueSystem,2=WomensFootballPyramid,4=FootballAssociation,5=RefereesAssociation,6=Girls -->
				
				<CFSWITCH expression="#LeagueBrand#">
					<CFCASE VALUE="0">
						<cfset ThisClass = "white"> <!-- Normal -->
						<td  width="10%" ></td>
					</CFCASE>
					<CFCASE VALUE="1">
						<cfset ThisClass = "bg_yellow"> <!-- National League System -->
						<td  width="10%" align="CENTER" class="#ThisClass#"><span class="pix9">National League System</span></td>
					</CFCASE>
					<CFCASE VALUE="2">
						<cfset ThisClass = "bg_lightgreen"> <!-- Womens Football Pyramid -->
						<td  width="10%" align="CENTER" class="#ThisClass#"><span class="pix9">Womens Football Pyramid</span></td>
					</CFCASE>
					<CFCASE VALUE="3">
						<cfset ThisClass = "white"> <!-- Normal -->
						<td width="10%"></td>
					</CFCASE>
					<CFCASE VALUE="4">
						<cfset ThisClass = "bg_highlight"> <!-- Football Association -->
						<td  width="10%"align="CENTER" class="#ThisClass#"><span class="pix9">County F.A.</span></td>
					</CFCASE>
					<CFCASE VALUE="5">
						<cfset ThisClass = "bg_highlight2"> <!-- Referees Association -->
						<td width="10%" align="center" class="#ThisClass#"><span class="pix9">County R.A.</span></td>
					</CFCASE>
					<CFCASE VALUE="6">
						<cfset ThisClass = "bg_plum"> <!-- Girls -->
						<td width="10%" align="center" class="#ThisClass#"><span class="pix9">Girls</span></td>
					</CFCASE>
					
				</CFSWITCH>
				<cfif MitooDotComID IS NOT 0>
					<td width="40%" ><a href="http://mitoo.co/beta?league&amp;lid=#MitooDotComID#&amp;did=#DefaultDID#"><span class="pix13">#NameSort#</span></a></td>
				<cfelse>
					<td width="40%" ><a href="News.cfm?LeagueCode=#DefaultLeagueCode#"><span class="pix13">#NameSort#</span></a></td>
				</cfif>

				<td width="10%"><a href="News.cfm?LeagueCode=#DefaultLeagueCode#"><span class="pix13">View on FM</span></a></td>

				<cfif MitooDotComID IS NOT 0>
					<td width="5%"><a href="http://mitoo.co/beta?league&amp;lid=#MitooDotComID#&amp;did=#DefaultDID#"><span class="pix13">Follow</span></a></td>
					<td width="10%"><a href="http://mitoo.co/download-app" target="_blank"><span class="pix13">Download App</span></a></td>
				<cfelse>
					<td></td>
					<td></td>
				</cfif>
			<!--
			<td>
				<a href="ShowContacts.cfm?LeagueCode=#DefaultLeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="#DefaultLeagueCode#Contacts"><span class="pix10bold">Contacts</span></a>				
			</td>
			-->
			<cfif DefaultYouthLeague>
				<td><span class="pix13boldred">#DefaultLeagueCode#</span></td>
			<cfelse>
				<td><span class="pix13">#DefaultLeagueCode#</span></td>
			</cfif>
			<cfif ListFind("Silver",request.SecurityLevel) >
				<td><span class="pix10">#QClubCount1.ActiveClubs#</span><br></td>
				<td><cfif QClubCount2.RedundantClubs GT 0><span class="pix10">#QClubCount2.RedundantClubs#</span><cfelse>&nbsp;</cfif></td>
				<!--
				<td>
				<cfif MitooDotComID IS NOT 0>
					<span class="pix10"> #MitooDotComID#</span>
<<<<<<< .mine
						<a href="http://www.mitoo.co/beta?league&amp;lid=#MitooDotComID#&amp;did=#DefaultDID#" target="_blank"><img src="gif/mitoo_league_off.gif" border="0" onMouseOver="this.src='gif/mitoo_league_on.gif'" onMouseOut="this.src='gif/mitoo_league_off.gif'" ></a>
=======
						<a href="http://mitoo.co/beta?league&amp;lid=#MitooDotComID#&amp;did=#DefaultDID#" target="_blank"><img src="gif/mitoo_league_off.gif" border="0" onMouseOver="this.src='gif/mitoo_league_on.gif'" onMouseOut="this.src='gif/mitoo_league_off.gif'" ></a>
>>>>>>> .r18691
				<cfelse>
				</cfif>
				</td>
				-->
				<td width="30%">
				<span class="pix10">#LEFT(CountiesList,50)#</span>
				</td>
			<cfelse>
				<!--
				<td colspan="2">
					<cfif MitooDotComID IS NOT 0>
<<<<<<< .mine
						<a href="http://www.mitoo.co/beta?league&amp;lid=#MitooDotComID#&amp;did=#DefaultDID#" target="_blank"><img src="gif/mitoo_league_off.gif" border="0" onMouseOver="this.src='gif/mitoo_league_on.gif'" onMouseOut="this.src='gif/mitoo_league_off.gif'" ></a>
=======
						<a href="http://mitoo.co/beta?league&amp;lid=#MitooDotComID#&amp;did=#DefaultDID#" target="_blank"><img src="gif/mitoo_league_off.gif" border="0" onMouseOver="this.src='gif/mitoo_league_on.gif'" onMouseOut="this.src='gif/mitoo_league_off.gif'" ></a>
>>>>>>> .r18691
					<cfelse>
					</cfif>
				</td>
				-->
				<td width="40%">
				<span class="pix10">#LEFT(CountiesList,50)#</span>
				</td>
			</cfif>
			</cfoutput>
		</tr>
	</cfloop>
	<tr>
		<td colspan="6"><span class="pix10">Total = <cfoutput>#NumberOfLeagues#</cfoutput></span></td>
	</tr>
</table>

