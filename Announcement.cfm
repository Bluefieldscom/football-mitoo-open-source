<cfinclude template="queries/qry_Announcement.cfm">
<table width="100%" class="mainMenu">
	<cfif QAnnouncement.RecordCount GT 1 >
		<tr>
			<td bgcolor="white">
				<span class="pix24boldred">ERROR: You have more than one Newsitem with a title of "NOTICE" .<br>
				Only one is allowed. Please change the title of one of them.</span>
			</td>
		</tr>
	<cfelse>
		<cfoutput query="QAnnouncement">
			<!--- <cfset spanset = " ,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,.,:,;,-,*,chr(44),?,&"> --->
			<cfset NoticeString = REReplace(Notes, "<[^>]*>", "", "All") > <!--- this is supposed to strip out 99% of all HTML as shown in " Regular expressions in CFML"  in CF manual --->
			<cfset NoticeString = Trim(Left(NoticeString,90)) >
			<!--- <cfset NoticeString = Spanincluding(NoticeString, spanset) > 
			<cfif Len(NoticeString) IS 0>
				<cfset NoticeString = " There is a NOTICE for you to read " >
			</cfif> --->
			<tr>
				<td bgcolor="##333333">
					<span class="pix13boldwhite">#NoticeString# ... </span>
					<a href="ShowNews.cfm?LeagueCode=#LeagueCode#&SeasonName=#SeasonName#&LeagueName=#URLEncodedFormat(LeagueName)#" target="_blank">continue</a>
				</td>
			</tr>
			<cfif ListFind("Silver,Skyblue",request.SecurityLevel)>
				<tr><td><a href="UpdateForm.cfm?TblName=NewsItem&ID=#NID#&LeagueCode=#LeagueCode#">upd/del NOTICE</a></td></tr>
			</cfif>
		</cfoutput>
	</cfif>	
</table>