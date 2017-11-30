//setHidden(true);

//var mapurl = "/"; //"/RDZ/";


/**
 * 플래시 열기
 */

function __openObject(s, id) {
	var el = document.getElementById(id);
	if (el != null) el.innerHTML = s;
	else document.write(s);
}


function __openFlash(pid, id, url, width, height) {
	var str = ''
			+ '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" id="'
			+ id
			+ '" width="'
			+ width
			+ '" height="'
			+ height
			+ '" align="middle">\n'
			+ '<param name="allowScriptAccess" value="always" />'
			+ '<param name="movie" value="'
			+ url
			+ '" />\n'
			+ '<param name="menu" value="false" />\n'
			+ '<param name="quality" value="best" />\n' 
			+ '<param name="wmode" value="transparent" />\n'
			+ '<param name="bgcolor" value="#ffffff" />\n'
			+ '<embed src="'
			+ url
			+ '" width="'
			+ width
			+ '" height="'
			+ height
			+ '" id="'
			+ id
			+ '" name="'
			+ id
			+ '" menu="false" quality="best" wmode="transparent" bgcolor="#ffffff" width="226" height="272" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />\n'
			+ '</object>\n';
	__openObject(str, pid);
}

/**
 *	 플래시 선택시 현황관리-지도이동가능 여부 체크
 */
function checkMap(selRegnCd, gPCode, pcode, gPerm) {
	
	if ("${userSession.user}" == null) {
		alert("로그인 후 이용가능합니다.");
		return;
	}
	if (gPerm.substr(0, 1) == "1") { //지자체
		if (gPCode != pcode) {
			alert("사용권한이 없는 지역입니다.");
			return;
		}
	} 
	if (gPerm.substr(0, 1) == "3") { //광역시도
		if (gPCode.substr(0, 2) != pcode.substr(0, 2)) {
			alert("사용권한이 없는 지역입니다.");
			return;
		}
	}
	
	gPCode = pcode;
	//goMap(selRegnCd, pcode);

	var sql = "sql=select * from tb_rdz_pcode where pcode = '"+pcode+"'";
	 
	postXmlRes("/map/query.do",sql,function(r) {   
		var xmlDoc = new k_XmlParser().init(r);
		var data = xmlDoc.gTag("data");
		var coordx = parseFloat(xmlDoc.gTag("COORDX", 0));
		var coordy = parseFloat(xmlDoc.gTag("COORDY", 0));
		var angle = parseFloat(xmlDoc.gTag("ANGLE", 0));
		gCordX = coordx; 
		gCordY = coordy; 
		gAngle = angle;   
		goMainPage(7);
		return true; 
	});
}

function checkPageMap(cordX, cordY, pcode) {
	
	if ("${userSession.user}" == null) {
		alert("로그인 후 이용가능합니다.");
		return;
	}

	gPCode = pcode;

	var sql = "sql=select * from tb_rdz_pcode where pcode = '"+pcode+"'";
	
	postXmlRes("/map/query.do",sql,function(r) {   
		var xmlDoc = new k_XmlParser().init(r);
		var data = xmlDoc.gTag("data");
		var angle = parseFloat(xmlDoc.gTag("ANGLE", 0));
	
		gCordX = cordX; 
		gCordY = cordY; 
		gAngle = angle; 
		goMainPage(7);
		return true; 
	});

}

function pageInGoMap(pagePnu, pageRegnCd){
	
	if ("${userSession.user}" == null) {
		alert("로그인 후 이용가능합니다.");
		return;
	}
	
	gPCode = pagePnu;
	goMainPage(5);

}

function pageInPkGoMap(pk1, pk2, tbName, pkName, seqName){
	
	if ("${userSession.user}" == null) {
		alert("로그인 후 이용가능합니다.");
		return;
	}
	
	pkValue1 = trim(pk1);
	pkValue2 = trim(pk2);
	pkTbName = tbName;
	pkFdName = pkName;
	seqFdName = seqName;
			
	goMainPage(3);
}

function pageInPkGoMap3(pk1, pk2, pk3, tbName, pkName, seqName, thName){
	
	if ("${userSession.user}" == null) {
		alert("로그인 후 이용가능합니다.");
		return;
	}
	
	pkValue1 = trim(pk1);
	pkValue2 = trim(pk2);
	pkValue3 = trim(pk3);
	pkTbName = tbName;
	pkFdName = pkName;
	seqFdName = seqName;
	thFdName = thName;
	
	goMainPage(4);
}

function ieExecWB(elem, intOLEcmd, intOLEparam )	{
	// 웹 브라우저 컨트롤 생성
	var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 	CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
	
	// 웹 페이지에 객체 삽입
	//document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
	elem.insertAdjacentHTML('beforeEnd', WebBrowser);
	
	// if intOLEparam이 정의되어 있지 않으면 디폴트 값 설정
	if ( ( ! intOLEparam ) || ( intOLEparam < -1 )  || (intOLEparam > 1 ) )
	        intOLEparam = 1;
	
	// ExexWB 메쏘드 실행
	WebBrowser1.ExecWB( intOLEcmd, intOLEparam );
	
	// 객체 해제
	WebBrowser1.outerHTML = "";
}

//페이지 이동
function goMainPage(n) {
	
	var gUserwidth = (screen.width - 10);
	var gUserheight = (screen.height - 90);
	
	if(n == 7){
		winObj = window.open('/map/goMap.do',"GB",'status=yes,width='+gUserwidth+',height='+gUserheight+',left=0,top=0');		
	}
	else if(n == 5){
		winObj = window.open('/map/pageInGoMap.do?pnu=' + gPCode,"GB",'status=yes,width='+gUserwidth+',height='+gUserheight+',left=0,top=0');
	}
	else if(n == 3){
		winObj = window.open('/map/pageInPkGoMap.do?pk1=' + pkValue1 + '&pk2=' + pkValue2 + '&tbName=' + pkTbName + '&pkFdName=' + pkFdName + '&seqFdName=' + seqFdName,"GB",'status=yes,width='+gUserwidth+',height='+gUserheight+',left=0,top=0');
	}
	else if(n == 4){
		winObj = window.open('/map/pageInPkGoMap3.do?pk1=' + pkValue1 + '&pk2=' + pkValue2 + '&pk3=' + pkValue3 + '&tbName=' + pkTbName + '&pkFdName=' + pkFdName + '&seqFdName=' + seqFdName + '&thFdName=' + thFdName,"GB",'status=yes,width='+gUserwidth+',height='+gUserheight+',left=0,top=0');
	}

}

//init top
function initTop(pid,n,grade) {	
	var bgMenu = new k_BYEOK().init(pid,0,0,1000,85,"","background=#ffffff");
	var menu = new Array();
	var home = new k_IMG("home","./images/main/top_logo.gif").init(bgMenu.getId(),0,0,206,65,"","cursor=pointer");

	if(n==0) {
		var menu00 = new kIMGBTN("menu00",function() { goMainPage(0); },"./images/main/menu_01_over.gif","","").init(bgMenu.getId(),206,0,102,65,"","cursor=pointer");
		var menu01 = new kIMGBTN("menu01",function() { goMainPage(1); },"./images/main/menu_02.gif","","./images/main/menu_02_over.gif").init(bgMenu.getId(),308,0,100,65,"","cursor=pointer");
		var menu02 = new kIMGBTN("menu02",function() { goMainPage(2); },"./images/main/menu_03.gif","","./images/main/menu_03_over.gif").init(bgMenu.getId(),408,0,124,65,"","cursor=pointer");
		var menu03 = new kIMGBTN("menu03",function() { goMainPage(3); },"./images/main/menu_04.gif","","./images/main/menu_04_over.gif").init(bgMenu.getId(),532,0,123,65,"","cursor=pointer");
		var menu04 = new kIMGBTN("menu04",function() { goMainPage(4); },"./images/main/menu_052.gif","","./images/main/menu_052_over.gif").init(bgMenu.getId(),655,0,113,65,"","cursor=pointer");
		var menu05 = new kIMGBTN("menu05",function() { goMainPage(5); },"./images/main/menu_06.gif","","./images/main/menu_06_over.gif").init(bgMenu.getId(),768,0,99,65,"","cursor=pointer");
		if(grade=='admin'){		
			var menu08 = new kIMGBTN("menu08",function() { goMainPage(8); },"./images/main/menu_08.gif","","./images/main/menu_08_over.gif").init(bgMenu.getId(),867,0,102,65,"","cursor=pointer");
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),968,0,133,65,"","cursor=pointer");		
		}else{
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),867,0,133,65,"","cursor=pointer");
		}
		
	} else if(n==1) {
		var menu00 = new kIMGBTN("menu00",function() { goMainPage(0); },"./images/main/menu_01.gif","","./images/main/menu_01_over.gif").init(bgMenu.getId(),206,0,102,65,"","cursor=pointer");
		var menu01 = new kIMGBTN("menu01",function() { goMainPage(1); },"./images/main/menu_02_over.gif","","").init(bgMenu.getId(),308,0,100,65,"","cursor=pointer");
		var menu02 = new kIMGBTN("menu02",function() { goMainPage(2); },"./images/main/menu_03.gif","","./images/main/menu_03_over.gif").init(bgMenu.getId(),408,0,124,65,"","cursor=pointer");
		var menu03 = new kIMGBTN("menu03",function() { goMainPage(3); },"./images/main/menu_04.gif","","./images/main/menu_04_over.gif").init(bgMenu.getId(),532,0,123,65,"","cursor=pointer");
		var menu04 = new kIMGBTN("menu04",function() { goMainPage(4); },"./images/main/menu_052.gif","","./images/main/menu_052_over.gif").init(bgMenu.getId(),655,0,113,65,"","cursor=pointer");
		var menu05 = new kIMGBTN("menu05",function() { goMainPage(5); },"./images/main/menu_06.gif","","./images/main/menu_06_over.gif").init(bgMenu.getId(),768,0,99,65,"","cursor=pointer");
		if(grade=='admin'){		
			var menu08 = new kIMGBTN("menu08",function() { goMainPage(8); },"./images/main/menu_08.gif","","./images/main/menu_08_over.gif").init(bgMenu.getId(),867,0,102,65,"","cursor=pointer");
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),968,0,133,65,"","cursor=pointer");		
		}else{
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),867,0,133,65,"","cursor=pointer");
		}
		
	} else if(n==2) {
		var menu00 = new kIMGBTN("menu00",function() { goMainPage(0); },"./images/main/menu_01.gif","","./images/main/menu_01_over.gif").init(bgMenu.getId(),206,0,102,65,"","cursor=pointer");
		var menu01 = new kIMGBTN("menu01",function() { goMainPage(1); },"./images/main/menu_02.gif","","./images/main/menu_02_over.gif").init(bgMenu.getId(),308,0,100,65,"","cursor=pointer");
		var menu02 = new kIMGBTN("menu02",function() { goMainPage(2); },"./images/main/menu_03_over.gif","","").init(bgMenu.getId(),408,0,124,65,"","cursor=pointer");
		var menu03 = new kIMGBTN("menu03",function() { goMainPage(3); },"./images/main/menu_04.gif","","./images/main/menu_04_over.gif").init(bgMenu.getId(),532,0,123,65,"","cursor=pointer");
		var menu04 = new kIMGBTN("menu04",function() { goMainPage(4); },"./images/main/menu_052.gif","","./images/main/menu_052_over.gif").init(bgMenu.getId(),655,0,113,65,"","cursor=pointer");
		var menu05 = new kIMGBTN("menu05",function() { goMainPage(5); },"./images/main/menu_06.gif","","./images/main/menu_06_over.gif").init(bgMenu.getId(),768,0,99,65,"","cursor=pointer");
		if(grade=='admin'){		
			var menu08 = new kIMGBTN("menu08",function() { goMainPage(8); },"./images/main/menu_08.gif","","./images/main/menu_08_over.gif").init(bgMenu.getId(),867,0,102,65,"","cursor=pointer");
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),968,0,133,65,"","cursor=pointer");		
		}else{
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),867,0,133,65,"","cursor=pointer");
		}
		
	} else if(n==3) {
		var menu00 = new kIMGBTN("menu00",function() { goMainPage(0); },"./images/main/menu_01.gif","","./images/main/menu_01_over.gif").init(bgMenu.getId(),206,0,102,65,"","cursor=pointer");
		var menu01 = new kIMGBTN("menu01",function() { goMainPage(1); },"./images/main/menu_02.gif","","./images/main/menu_02_over.gif").init(bgMenu.getId(),308,0,100,65,"","cursor=pointer");
		var menu02 = new kIMGBTN("menu02",function() { goMainPage(2); },"./images/main/menu_03.gif","","./images/main/menu_03_over.gif").init(bgMenu.getId(),408,0,124,65,"","cursor=pointer");
		var menu03 = new kIMGBTN("menu03",function() { goMainPage(3); },"./images/main/menu_04_over.gif","","").init(bgMenu.getId(),532,0,123,65,"","cursor=pointer");
		var menu04 = new kIMGBTN("menu04",function() { goMainPage(4); },"./images/main/menu_052.gif","","./images/main/menu_052_over.gif").init(bgMenu.getId(),655,0,113,65,"","cursor=pointer");
		var menu05 = new kIMGBTN("menu05",function() { goMainPage(5); },"./images/main/menu_06.gif","","./images/main/menu_06_over.gif").init(bgMenu.getId(),768,0,99,65,"","cursor=pointer");
		if(grade=='admin'){		
			var menu08 = new kIMGBTN("menu08",function() { goMainPage(8); },"./images/main/menu_08.gif","","./images/main/menu_08_over.gif").init(bgMenu.getId(),867,0,102,65,"","cursor=pointer");
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),968,0,133,65,"","cursor=pointer");		
		}else{
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),867,0,133,65,"","cursor=pointer");
		}
		
	} else if(n==4) {
		var menu00 = new kIMGBTN("menu00",function() { goMainPage(0); },"./images/main/menu_01.gif","","./images/main/menu_01_over.gif").init(bgMenu.getId(),206,0,102,65,"","cursor=pointer");
		var menu01 = new kIMGBTN("menu01",function() { goMainPage(1); },"./images/main/menu_02.gif","","./images/main/menu_02_over.gif").init(bgMenu.getId(),308,0,100,65,"","cursor=pointer");
		var menu02 = new kIMGBTN("menu02",function() { goMainPage(2); },"./images/main/menu_03.gif","","./images/main/menu_03_over.gif").init(bgMenu.getId(),408,0,124,65,"","cursor=pointer");
		var menu03 = new kIMGBTN("menu03",function() { goMainPage(3); },"./images/main/menu_04.gif","","./images/main/menu_04_over.gif").init(bgMenu.getId(),532,0,123,65,"","cursor=pointer");
		var menu04 = new kIMGBTN("menu04",function() { goMainPage(4); },"./images/main/menu_052_over.gif","","").init(bgMenu.getId(),655,0,113,65,"","cursor=pointer");
		var menu05 = new kIMGBTN("menu05",function() { goMainPage(5); },"./images/main/menu_06.gif","","./images/main/menu_06_over.gif").init(bgMenu.getId(),768,0,99,65,"","cursor=pointer");		
		if(grade=='admin'){		
			var menu08 = new kIMGBTN("menu08",function() { goMainPage(8); },"./images/main/menu_08.gif","","./images/main/menu_08_over.gif").init(bgMenu.getId(),867,0,102,65,"","cursor=pointer");
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),968,0,133,65,"","cursor=pointer");		
		}else{
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),867,0,133,65,"","cursor=pointer");
		}
		
	} else if(n==5) {
		var menu00 = new kIMGBTN("menu00",function() { goMainPage(0); },"./images/main/menu_01.gif","","./images/main/menu_01_over.gif").init(bgMenu.getId(),206,0,102,65,"","cursor=pointer");
		var menu01 = new kIMGBTN("menu01",function() { goMainPage(1); },"./images/main/menu_02.gif","","./images/main/menu_02_over.gif").init(bgMenu.getId(),308,0,100,65,"","cursor=pointer");
		var menu02 = new kIMGBTN("menu02",function() { goMainPage(2); },"./images/main/menu_03.gif","","./images/main/menu_03_over.gif").init(bgMenu.getId(),408,0,124,65,"","cursor=pointer");
		var menu03 = new kIMGBTN("menu03",function() { goMainPage(3); },"./images/main/menu_04.gif","","./images/main/menu_04_over.gif").init(bgMenu.getId(),532,0,123,65,"","cursor=pointer");
		var menu04 = new kIMGBTN("menu04",function() { goMainPage(4); },"./images/main/menu_052.gif","","./images/main/menu_052_over.gif").init(bgMenu.getId(),655,0,113,65,"","cursor=pointer");
		var menu05 = new kIMGBTN("menu05",function() { goMainPage(5); },"./images/main/menu_06_over.gif","","").init(bgMenu.getId(),768,0,99,65,"","cursor=pointer");
		
		if(grade=='admin'){		
			var menu08 = new kIMGBTN("menu08",function() { goMainPage(8); },"./images/main/menu_08.gif","","./images/main/menu_08_over.gif").init(bgMenu.getId(),867,0,102,65,"","cursor=pointer");
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),968,0,133,65,"","cursor=pointer");		
		}else{
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),867,0,133,65,"","cursor=pointer");
		}
		
	} else if(n==6) {	
		var menu00 = new kIMGBTN("menu00",function() { goMainPage(0); },"./images/main/menu_01.gif","","./images/main/menu_01_over.gif").init(bgMenu.getId(),206,0,102,65,"","cursor=pointer");
		var menu01 = new kIMGBTN("menu01",function() { goMainPage(1); },"./images/main/menu_02.gif","","./images/main/menu_02_over.gif").init(bgMenu.getId(),308,0,100,65,"","cursor=pointer");
		var menu02 = new kIMGBTN("menu02",function() { goMainPage(2); },"./images/main/menu_03.gif","","./images/main/menu_03_over.gif").init(bgMenu.getId(),408,0,124,65,"","cursor=pointer");
		var menu03 = new kIMGBTN("menu03",function() { goMainPage(3); },"./images/main/menu_04.gif","","./images/main/menu_04_over.gif").init(bgMenu.getId(),532,0,123,65,"","cursor=pointer");
		var menu04 = new kIMGBTN("menu04",function() { goMainPage(4); },"./images/main/menu_052.gif","","./images/main/menu_052_over.gif").init(bgMenu.getId(),655,0,113,65,"","cursor=pointer");
		var menu05 = new kIMGBTN("menu05",function() { goMainPage(5); },"./images/main/menu_06.gif","","./images/main/menu_06_over.gif").init(bgMenu.getId(),768,0,99,65,"","cursor=pointer");			
		if(grade=='admin'){		
			var menu08 = new kIMGBTN("menu08",function() { goMainPage(8); },"./images/main/menu_08.gif","","./images/main/menu_08_over.gif").init(bgMenu.getId(),867,0,102,65,"","cursor=pointer");
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07_over.gif","","").init(bgMenu.getId(),968,0,133,65,"","cursor=pointer");		
		}else{
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07_over.gif","","").init(bgMenu.getId(),867,0,133,65,"","cursor=pointer");
		}
		
	} else if(n==8){ 
		var menu00 = new kIMGBTN("menu00",function() { goMainPage(0); },"./images/main/menu_01.gif","","./images/main/menu_01_over.gif").init(bgMenu.getId(),206,0,102,65,"","cursor=pointer");
		var menu01 = new kIMGBTN("menu01",function() { goMainPage(1); },"./images/main/menu_02.gif","","./images/main/menu_02_over.gif").init(bgMenu.getId(),308,0,100,65,"","cursor=pointer");
		var menu02 = new kIMGBTN("menu02",function() { goMainPage(2); },"./images/main/menu_03.gif","","./images/main/menu_03_over.gif").init(bgMenu.getId(),408,0,124,65,"","cursor=pointer");
		var menu03 = new kIMGBTN("menu03",function() { goMainPage(3); },"./images/main/menu_04.gif","","./images/main/menu_04_over.gif").init(bgMenu.getId(),532,0,123,65,"","cursor=pointer");
		var menu04 = new kIMGBTN("menu04",function() { goMainPage(4); },"./images/main/menu_052.gif","","./images/main/menu_052_over.gif").init(bgMenu.getId(),655,0,113,65,"","cursor=pointer");
		var menu05 = new kIMGBTN("menu05",function() { goMainPage(5); },"./images/main/menu_06.gif","","./images/main/menu_06_over.gif").init(bgMenu.getId(),768,0,99,65,"","cursor=pointer");
		if(grade=='admin'){		
			var menu08 = new kIMGBTN("menu08",function() { goMainPage(8); },"./images/main/menu_08_over.gif","","").init(bgMenu.getId(),867,0,102,65,"","cursor=pointer");
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),968,0,133,65,"","cursor=pointer");		
		}else{
			var menu06 = new kIMGBTN("menu06",function() { goMainPage(6); },"./images/main/menu_07.gif","","./images/main/menu_07_over.gif").init(bgMenu.getId(),867,0,133,65,"","cursor=pointer");
		}		
	}
	
	home.eventListener("click",function() { goMainPage('home'); });	
}

//init bottom
function initBottom(pid) {
	//바닥
	new k_BYEOK("main_bottom").init(pid,0,961,100,60);
	var sps = 20; var bj = 50;
	new kIMGBTN("copyright_logo",function f00(){window.open("http://www.mltm.go.kr/");},"./images/main/footer_logo.png","","./images/main/footer_logo.png").init("main_bottom",sps,10,129,46);
	new kIMGBTN("bot_menu_01",null,"./images/main/bottom_01.gif","","./images/main/bottom_01.gif").init("main_bottom",sps+bj+169,15,50,20);
	new kIMGBTN("bot_menu_02",null,"./images/main/bottom_02.gif","","./images/main/bottom_02.gif").init("main_bottom",sps+bj+219,15,91,20);
	new kIMGBTN("bot_menu_03",null,"./images/main/bottom_03.gif","","./images/main/bottom_03.gif").init("main_bottom",sps+bj+310,15,64,20);
	new kIMGBTN("bot_menu_04",null,"./images/main/bottom_04.gif","","./images/main/bottom_04.gif").init("main_bottom",sps+bj+374,15,90,20);
	new kIMGBTN("bot_menu_05",function f05(){window.open("http://www.mltm.go.kr/Intro/Guide/map.jsp");},"./images/main/bottom_05.gif","","./images/main/bottom_05.gif").init("main_bottom",sps+bj+464,15,64,20);
	new kIMGBTN("bot_menu_06",function f06(){window.open("http://www.mltm.go.kr/Intro/Guide/tel.jsp");},"./images/main/bottom_06.gif","","./images/main/bottom_06.gif").init("main_bottom",sps+bj+528,15,72,20);
	new kIMGBTN("bot_menu_07",function f06(){window.open("http://www.mltm.go.kr/Intro/Job/list.jsp");},"./images/main/bottom_07.gif","","./images/main/bottom_07.gif").init("main_bottom",sps+bj+600,15,54,20);

	new k_IMG("copyright","./images/main/copyright.gif").init("main_bottom",169,36,629,23);
	new k_IMG("webmaster","./images/main/mail_icon.gif").init("main_bottom",798,36,68,23);
}


/*
 * 천단위마다 콤마(,) 찍기
 */
function comma(str,zari) {
	if(isNaN(str)) return str;
	
	var nStr;
	var len = 0;
	if(zari == null) zari = 0;
	
	var dott = str.indexOf(".");
	if(dott == -1) {
		nStr = str;
		len = nStr.length;
	} else {
		nStr = str.substring(0, zari+dott+1);
		len = nStr.length - zari-1;
	}
	
	var str1 = "";
	for(var i=1; i<=len; i++) {
	 str1 = str.charAt(len-i)+str1;
	 if((i%3 == 0)&&(len-i != 0)) str1 = ","+str1;
	}
	if(dott != -1) {
		if(zari != 0) str1 = str1 + nStr.substring(dott,dott+zari+1);
	}
	return str1;
}

/*
 * 콤마(,) 지우기
 */
function remove_comma(sOrg) {
	if(sOrg == null) return;
	var nm;
    sOrg = sOrg.replace(/,/g,""); 
    nm = parseFloat(sOrg).toString();
    return (isNaN(nm)?0:nm);
}	
/*
 * 테이블에 마우스 오버시 해당 줄 색 변하기
 */
function fnSelectRow(event) {
	if(__cb.browserType == "ie") {
	if(!event) event = window.event; //IE
		event.target = event.srcElement;
	} 
	
	var eve = event.target;	
	if (eve.nodeName == "TD"){
		if(eve.parentNode.parentNode.rows.length != 1) {
			eve.parentNode.style.backgroundColor="#F1EBCF";
		}
	}
}
/*
 * 테이블에 마우스 오버시 해당 줄 색 원위치
 */
function fnDeselectRow(event) {
	if(__cb.browserType == "ie") {
	if(!event) event = window.event; //IE
		event.target = event.srcElement;
	} 
	
	var eve = event.target;	
	if (eve.nodeName == "TD"){
		if(eve.parentNode.parentNode.rows.length != 1) {
			eve.parentNode.style.backgroundColor="#ffffff";
		}
	}
}

//<!-- 셀렉트 박스주소  셋팅
function chkRi(sggId,emdId,riId,s) {	
	var sgg = document.getElementById(sggId);
	var emd = document.getElementById(emdId);
	var ri = document.getElementById(riId);
	var params = "code=riCode&sgg=" + sgg.value + "&emd=" + emd.value;
	var rr = __b.postXmlRes("/map/AddrCode.do",params);
	var xmlDoc = new k_XmlParser().init(rr);
	var data = xmlDoc.gTag("data");
	var regnName = xmlDoc.gTag("regnName");
	var regnCode = xmlDoc.gTag("regnCode");
	ri.disabled = false;
	ri.options.length=0;
	ri.options[0] = new Option(i);
	ri.options[0].text = "선택하세요";
    ri.options[0].value = "0";
    ri.options[0].selected = true;
	for ( var i=0; i<data.length; i++){     
		newItem = new Option(i);
		ri.options[i+1] = newItem;
		ri.options[i+1].text = xmlDoc.gTData(regnName,i);
    	ri.options[i+1].value = xmlDoc.gTData(regnCode,i);
		//if(ri.options[i+1].value.substr(8,2)=="00") ri.disabled = true;
    }
    if(s != null) {
		for ( var i=0; i<data.length; i++){
			if(ri.options[i+1].value == s) {
				ri.options[i+1].selected = true;
				//if(ri.options[i+1].value.substr(8,2)=="00") ri.disabled = true;
				break;
			}
		}     
    }
}
function chkEmd(sggId,emdId,riId,s,gRegn) {	
	
	var sgg = document.getElementById(sggId);
	var emd = document.getElementById(emdId);
	var ri = document.getElementById(riId);
	var params = "code=emdCode&sgg="+sgg.value+"&gRegn="+gRegn;	
	var rr = __b.postXmlRes("/map/AddrCode.do",params);
	var xmlDoc = new k_XmlParser().init(rr);
	var data = xmlDoc.gTag("data");
	var regnName = xmlDoc.gTag("regnName");
	var regnCode = xmlDoc.gTag("regnCode");
	
	emd.options.length=0;
	emd.options[0] = new Option(i);
	emd.options[0].text = "선택하세요";
    emd.options[0].value = "0";
    emd.options[0].selected = true;
	for ( var i=0; i<data.length; i++){     
		newItem = new Option(i);
		emd.options[i+1] = newItem;
		emd.options[i+1].text = xmlDoc.gTData(regnName,i);
    	emd.options[i+1].value = xmlDoc.gTData(regnCode,i);
    }
    if(s != null) {
		for ( var i=0; i<data.length; i++){
			if(emd.options[i+1].value == s) {
				emd.options[i+1].selected = true;
				break;
			}
		}     
    }
}
function setAddr(a,b,c) {
	if(typeof(a) == "string") {
		// ID값으로 넘어오는 인자는 이곳에서 처리
		var sgg = document.getElementById(a);
		var emd = document.getElementById(b);
		var ri = document.getElementById(c);
		
		var rr = postXmlRes("/map/AddrCode.do","code=regnCode&gRegn="+gRegn);
		var xmlDoc = new k_XmlParser().init(rr);
		var data = xmlDoc.gTag("data");
		var regnName = xmlDoc.gTag("regnName");
		var regnCode = xmlDoc.gTag("regnCode");
		
		sgg.options.length=0;
		sgg.options[0] = new Option(i);
		sgg.options[0].text = "선택하세요";
	    sgg.options[0].value = "0";
	    sgg.options[0].selected = true;
		for ( var i=0; i<data.length; i++){     
			newItem = new Option(i);
			sgg.options[i+1] = newItem;
			sgg.options[i+1].text = xmlDoc.gTData(regnName,i);
	    	sgg.options[i+1].value = xmlDoc.gTData(regnCode,i);
	    	
	    }
	    ri.options.length=0;
		ri.options[0] = new Option(i);
		ri.options[0].text = "선택하세요";
	    ri.options[0].value = "0";
	    ri.options[0].selected = true;

		emd.options.length=0;
		emd.options[0] = new Option(i);
		emd.options[0].text = "선택하세요";
	    emd.options[0].value = "0";
	    emd.options[0].selected = true;
				
		sgg.onchange = function chckEmd() { chkEmd(a,b,c); };
		emd.onchange = function chckRi() { chkRi(a,b,c); };
	} else {
		if(a.getElem().options.length <= 0) {
			var rr = postXmlRes("/map/AddrCode.do","code=regnCode");
			var xmlDoc = new k_XmlParser().init(rr);
			var data = xmlDoc.gTag("data");
			var regnName = xmlDoc.gTag("regnName");
			var regnCode = xmlDoc.gTag("regnCode");
			a.clear();
			a.add("선택하세요",0,true);
			for(var i=0; i<data.length; i++) {
				a.add(xmlDoc.gTData(regnName,i),xmlDoc.gTData(regnCode,i));
			}
			b.add("선택하세요",0,true);
			c.add("선택하세요",0,true);
			//chkEmd(a.getId(),b.getId(),c.getId());
			a.eventListener("change",function d() { chkEmd(a.getId(),b.getId(),c.getId()); });
			b.eventListener("change",function e() { chkRi(a.getId(),b.getId(),c.getId()); });
		}
	}
}
//--> 

//<!-- 행정구역 셋팅 : 권역/시도/시군구/읍면동/리
function checkRi(regionId,sidoId,sggId,emdId,riId,s,gRegn) {
	var region = document.getElementById(regionId);
	var sido = document.getElementById(sidoId);
	var sgg = document.getElementById(sggId);
	var emd = document.getElementById(emdId);
	var ri = document.getElementById(riId);

	var params = "code=ri&region="+region.value+"&sido="+sido.value+"&sgg="+sgg.value+"&emd="+emd.value+"&gRegn="+gRegn;
	var rr = __b.postXmlRes("/map/AddressCode.do",params);
	var xmlDoc = new k_XmlParser().init(rr);
	var data = xmlDoc.gTag("data");
	var regnName = xmlDoc.gTag("regnName");
	var regnCode = xmlDoc.gTag("regnCode");
	
	ri.options.length=0;
	ri.options[0] = new Option(i);
	ri.options[0].text = "::리";
	ri.options[0].value = "0";
	ri.options[0].selected = true;
	for ( var i=0; i<data.length; i++){     
		newItem = new Option(i);
		ri.options[i+1] = newItem;
		ri.options[i+1].text = xmlDoc.gTData(regnName,i);
		ri.options[i+1].value = xmlDoc.gTData(regnCode,i);
    }
    if(s != null) {
		for ( var i=0; i<data.length; i++){
			if(ri.options[i+1].value == s) {
				ri.options[i+1].selected = true;
				break;
			}
		}     
    }
}
function checkEmd(regionId,sidoId,sggId,emdId,riId,s,gRegn) {
	var region = document.getElementById(regionId);
	var sido = document.getElementById(sidoId);
	var sgg = document.getElementById(sggId);
	var emd = document.getElementById(emdId);
	var ri = document.getElementById(riId);
	
	var params = "code=emd&region="+region.value+"&sido="+sido.value+"&sgg="+sgg.value+"&gRegn="+gRegn;
	var rr = __b.postXmlRes("/map/AddressCode.do",params);
	var xmlDoc = new k_XmlParser().init(rr);
	var data = xmlDoc.gTag("data");
	var regnName = xmlDoc.gTag("regnName");
	var regnCode = xmlDoc.gTag("regnCode");
	
	emd.options.length=0;
	emd.options[0] = new Option(i);
	emd.options[0].text = "::읍면동";
	emd.options[0].value = "0";
	emd.options[0].selected = true;
	for ( var i=0; i<data.length; i++){     
		newItem = new Option(i);
		emd.options[i+1] = newItem;
		emd.options[i+1].text = xmlDoc.gTData(regnName,i);
		emd.options[i+1].value = xmlDoc.gTData(regnCode,i);
    }
    if(s != null) {
		for ( var i=0; i<data.length; i++){
			if(emd.options[i+1].value == s) {
				emd.options[i+1].selected = true;
				break;
			}
		}     
    }
    if(ri != null) {
	    ri.options.length=0;
		ri.options[0] = new Option(i);
		ri.options[0].text = "::리";
		ri.options[0].value = "0";
		ri.options[0].selected = true;
    }
}
function checkSgg(regionId,sidoId,sggId,emdId,riId,s,gRegn) {
	var region = document.getElementById(regionId);
	var sido = document.getElementById(sidoId);
	var sgg = document.getElementById(sggId);
	var emd = document.getElementById(emdId);
	var ri = document.getElementById(riId);
	

	var params = "code=sgg&region="+region.value+"&sido="+sido.value+"&gRegn="+gRegn;
	var rr = __b.postXmlRes("/map/AddressCode.do",params);
	var xmlDoc = new k_XmlParser().init(rr);
	var data = xmlDoc.gTag("data");
	var regnName = xmlDoc.gTag("regnName");
	var regnCode = xmlDoc.gTag("regnCode");
	
	sgg.options.length=0;
	sgg.options[0] = new Option(i);
	sgg.options[0].text = "::시군구";
	sgg.options[0].value = "0";
	sgg.options[0].selected = true;
	for ( var i=0; i<data.length; i++){     
		newItem = new Option(i);
		sgg.options[i+1] = newItem;
		sgg.options[i+1].text = xmlDoc.gTData(regnName,i);
		sgg.options[i+1].value = xmlDoc.gTData(regnCode,i);
    }
    if(s != null) {
		for ( var i=0; i<data.length; i++){
			if(sgg.options[i+1].value == s) {
				sgg.options[i+1].selected = true;
				break;
			}
		}     
    }
    if(emd != null) {
	    emd.options.length=0;
		emd.options[0] = new Option(i);
		emd.options[0].text = "::읍면동";
		emd.options[0].value = "0";
		emd.options[0].selected = true;
    }
    if(ri != null) {
		ri.options.length=0;
		ri.options[0] = new Option(i);
		ri.options[0].text = "::리";
		ri.options[0].value = "0";
		ri.options[0].selected = true;
    }
}
function checkSido(regionId,sidoId,sggId,emdId,riId,s,gRegn) {
	var region = document.getElementById(regionId);
	var sido = document.getElementById(sidoId);
	var sgg = document.getElementById(sggId);
	var emd = document.getElementById(emdId);
	var ri = document.getElementById(riId);
	var params = "code=sido&region="+region.value+"&gRegn="+gRegn;
	var rr = __b.postXmlRes("/map/AddressCode.do",params); 
	var xmlDoc = new k_XmlParser().init(rr);
	var data = xmlDoc.gTag("data");
	var regnName = xmlDoc.gTag("regnName");
	var regnCode = xmlDoc.gTag("regnCode");
	
	sido.options.length=0;
	sido.options[0] = new Option(i);
	sido.options[0].text = "::시도";
	sido.options[0].value = "0";
	sido.options[0].selected = true;
	for ( var i=0; i<data.length; i++){     
		newItem = new Option(i);
		sido.options[i+1] = newItem;
		sido.options[i+1].text = xmlDoc.gTData(regnName,i);
		sido.options[i+1].value = xmlDoc.gTData(regnCode,i);
    }
    if(s != null) {
		for ( var i=0; i<data.length; i++){
			if(sido.options[i+1].value == s) {
				sido.options[i+1].selected = true;
				break;
			}
		}     
    }
    
    if(sgg != null) {
	    sgg.options.length=0;
		sgg.options[0] = new Option(i);
		sgg.options[0].text = "::시군구";
		sgg.options[0].value = "0";
		sgg.options[0].selected = true;
    }
    if(emd != null) {
		emd.options.length=0;
		emd.options[0] = new Option(i);
		emd.options[0].text = "::읍면동";
		emd.options[0].value = "0";
		emd.options[0].selected = true;
    }
    if(ri != null) {
		ri.options.length=0;
		ri.options[0] = new Option(i);
		ri.options[0].text = "::리";
		ri.options[0].value = "0";
		ri.options[0].selected = true;
    }
}
function setAddress(a,b,c,d,e,type) {
	if(typeof(a) == "string") {
		// ID값으로 넘어오는 인자는 이곳에서 처리
		var region = document.getElementById(a);
		var sido = document.getElementById(b);
		var sgg = document.getElementById(c);
		var emd = document.getElementById(d);
		var ri = document.getElementById(e);
		
		var rr = __b.postXmlRes("/map/AddressCode.do","code=region&gRegn="+gRegn+"&type="+type);
		var xmlDoc = new k_XmlParser().init(rr);
		var data = xmlDoc.gTag("data");
		var regnName = xmlDoc.gTag("regnName");
		var regnCode = xmlDoc.gTag("regnCode");
		
		//권역
		region.options.length=0;
		region.options[0] = new Option(i);
		region.options[0].text = "::권역";
		region.options[0].value = "0";
		region.options[0].selected = true;
		for ( var i=0; i<data.length; i++){     
			newItem = new Option(i);
			region.options[i+1] = newItem;
			region.options[i+1].text = xmlDoc.gTData(regnName,i);
			region.options[i+1].value = xmlDoc.gTData(regnCode,i);
	    }
		
		if(sido != null) region.onchange = function chckRegion() { checkSido(a,b,c,d,e); };
		if(sgg != null) sido.onchange = function chckSgg() { checkSgg(a,b,c,d,e); };
		if(emd != null) sgg.onchange = function chckEmd() { checkEmd(a,b,c,d,e); };
		if(ri != null) emd.onchange = function chckRi() { checkRi(a,b,c,d,e); };

		if(sido != null) {
			sido.options.length=0;
			sido.options[0] = new Option(i);
			sido.options[0].text = "::시도";
			sido.options[0].value = "0";
			sido.options[0].selected = true;
		}
		
		if(sgg != null) {
			sgg.options.length=0;
			sgg.options[0] = new Option(i);
			sgg.options[0].text = "::시군구";
			sgg.options[0].value = "0";
			sgg.options[0].selected = true;
		}
		
		if(emd != null) {
			emd.options.length=0;
			emd.options[0] = new Option(i);
			emd.options[0].text = "::읍면동";
			emd.options[0].value = "0";
			emd.options[0].selected = true;
		}
		
		if(ri != null) {
			ri.options.length=0;
			ri.options[0] = new Option(i);
			ri.options[0].text = "::리";
			ri.options[0].value = "0";
			ri.options[0].selected = true;
		}
	} else {
		if(a.getElem().options.length <= 0) {

			var rr = __b.postXmlRes("/map/AddressCode.do","code=region&gRegn="+gRegn+"&type="+type);
			var xmlDoc = new k_XmlParser().init(rr);
			var data = xmlDoc.gTag("data");
			var regnName = xmlDoc.gTag("regnName");
			var regnCode = xmlDoc.gTag("regnCode");
			
			a.clear();
			a.add("::권역",0,true);
			for(var i=0; i<data.length; i++) {
				a.add(xmlDoc.gTData(regnName,i),xmlDoc.gTData(regnCode,i));
			}
			
			if(b != null) b.add("::시도",0,true);
			if(c != null) c.add("::시군구",0,true);
			if(d != null) d.add("::읍면동",0,true);
			if(e != null) e.add("::리",0,true);
			
			a.eventListener("change",function() { checkSido(a.getId(),b.getId(),c.getId(),d.getId(),e.getId()); });
			if(b != null) b.eventListener("change",function() { checkSgg(a.getId(),b.getId(),c.getId(),d.getId(),e.getId()); });
			if(c != null) c.eventListener("change",function() { checkEmd(a.getId(),b.getId(),c.getId(),d.getId(),e.getId()); });
			if(d != null) d.eventListener("change",function() { checkRi(a.getId(),b.getId(),c.getId(),d.getId(),e.getId()); });
		}
	}
}
//--> 

function selectAddress(a,b,c,d,e,f,g,h,pnu){
	var sidoCd = "";
	var sggCd = "";
	var emdCd = "";
	var riCd = "";
	var regnCd = ""; 
	var regnCd2 = "";
	var inBobn = "";
	var inBubn = "";
	var inSan = "";
	
	var regnNum = 0;
	var sidoNum = 0;
	var sggNum = 0;
	var emdNum = 0;
	var riNum = 0;
	
	if(pnu.length == 10){
		if(pnu.substring(8, pnu.length) == "00"){
			pnu = pnu.substring(0, 8);
		}
	}else if(pnu.length == 11){
		if((pnu.substring(8, pnu.length) == "001") || (pnu.substring(8, pnu.length) == "002")){
			pnu = pnu.substring(0, 8);
		}
	}else if(pnu.length == 19){
		inSan = pnu.substring(10, 11);
		inBobn = pnu.substring(11, 15);
		inBubn = pnu.substring(15, 19);

		if(pnu.substring(8, 10) == "00"){
			pnu = pnu.substring(0, 8);
		}else{
			pnu = pnu.substring(0, 10);
		}
	}
	
	// pnu를 통한 위치값 설정
	if(pnu != null || pnu != ""){
		var rr = __b.postXmlRes("/map/selectRegnCode.do","pnu="+pnu+"&type=pnu");
		var xmlDoc = new k_XmlParser().init(rr);
		var data = xmlDoc.gTag("data");
		var sido_cd = xmlDoc.gTag("sido_cd");
		var sgg_cd = xmlDoc.gTag("sgg_cd");
		var emd_cd = xmlDoc.gTag("emd_cd");
		var ri_cd = xmlDoc.gTag("ri_cd");
		var regn_cd = xmlDoc.gTag("regn_cd");
		var regn_cd_2 = xmlDoc.gTag("regn_cd_2");
		
		for(var i=0; i<data.length; i++) {
			sidoCd = xmlDoc.gTData(sido_cd,i);
			sggCd = xmlDoc.gTData(sgg_cd,i);
			emdCd = xmlDoc.gTData(emd_cd,i);
			riCd = xmlDoc.gTData(ri_cd,i);
			regnCd = xmlDoc.gTData(regn_cd,i);
			regnCd2 = xmlDoc.gTData(regn_cd_2,i);
		}
		
		if(regnCd != regnCd2){
			regnCd = regnCd2;
		}
		
		// 권역 설정
		rr = __b.postXmlRes("/map/selectRegnCode.do","pnu="+pnu+"&type=regn");
		xmlDoc = new k_XmlParser().init(rr);
		data = xmlDoc.gTag("data");
		var num = xmlDoc.gTag("num");
		var pcode = xmlDoc.gTag("pcode");
		
		for(var i=0; i<data.length; i++) {
			if(regnCd == xmlDoc.gTData(pcode,i)) regnNum = xmlDoc.gTData(num,i); 
		}
		
		a.getElem().options[regnNum].selected = true;
		checkSido(a.getId(),b.getId(),c.getId(),d.getId(),e.getId());
		
		// 시도 설정
		if(sidoCd != null){
			rr = __b.postXmlRes("/map/selectRegnCode.do","pnu="+pnu+"&regn="+regnCd+"&type=sido");
			xmlDoc = new k_XmlParser().init(rr);
			data = xmlDoc.gTag("data");
			var num = xmlDoc.gTag("num");
			var pcode = xmlDoc.gTag("pcode");
			
			for(var i=0; i<data.length; i++) {
				if(sidoCd == xmlDoc.gTData(pcode,i)) sidoNum = xmlDoc.gTData(num,i); 
			}
			
			b.getElem().options[sidoNum].selected = true;
			checkSgg(a.getId(),b.getId(),c.getId(),d.getId(),e.getId());
			
			// 시군구 설정
			if(sggCd != null){
				rr = __b.postXmlRes("/map/selectRegnCode.do","pnu="+pnu+"&regn="+regnCd+"&sido="+sidoCd+"&type=sgg");
				xmlDoc = new k_XmlParser().init(rr);
				data = xmlDoc.gTag("data");
				var num = xmlDoc.gTag("num");
				var pcode = xmlDoc.gTag("pcode");
				
				for(var i=0; i<data.length; i++) {
					if(sggCd == xmlDoc.gTData(pcode,i)) sggNum = xmlDoc.gTData(num,i); 
				}
				
				c.getElem().options[sggNum].selected = true;
				checkEmd(a.getId(),b.getId(),c.getId(),d.getId(),e.getId());
				
				// 읍면동 설정
				if(emdCd != null){
					rr = __b.postXmlRes("/map/selectRegnCode.do","pnu="+pnu+"&regn="+regnCd+"&sido="+sidoCd+"&sgg="+sggCd+"&type=emd");
					xmlDoc = new k_XmlParser().init(rr);
					data = xmlDoc.gTag("data");
					var num = xmlDoc.gTag("num");
					var pcode = xmlDoc.gTag("pcode");
					
					for(var i=0; i<data.length; i++) {
						if(emdCd == xmlDoc.gTData(pcode,i)) emdNum = xmlDoc.gTData(num,i); 
					}
					
					d.getElem().options[emdNum].selected = true;
					checkRi(a.getId(),b.getId(),c.getId(),d.getId(),e.getId());
					
					// 리 설정
					if(riCd != null){
						rr = __b.postXmlRes("/map/selectRegnCode.do","pnu="+pnu+"&regn="+regnCd+"&sido="+sidoCd+"&sgg="+sggCd+"&emd="+emdCd+"&type=ri");
						xmlDoc = new k_XmlParser().init(rr);
						data = xmlDoc.gTag("data");
						var num = xmlDoc.gTag("num");
						var pcode = xmlDoc.gTag("pcode");
						
						for(var i=0; i<data.length; i++) {
							if(riCd == xmlDoc.gTData(pcode,i)) riNum = xmlDoc.gTData(num,i); 
						}
					
						e.getElem().options[riNum].selected = true;
					}
				}
			}
		}
	}
	
	
	if(inBobn != ""){
		// 본번
		var bobn = document.getElementById(f.getId());
		bobn.value = inBobn;
		// 부번
		var bubn = document.getElementById(g.getId());
		bubn.value = inBubn;
		// 산 체크
		var san = document.getElementById(h.getId());
		if(inSan == 2){
			san.checked = true; 
		}else{
			san.checked = false;	
		}
	}
	
}


//<!-- 고시기관 셋팅
function checkInst2(inst1Id,inst2Id, s) {
	var inst1 = document.getElementById(inst1Id);
	var inst2 = document.getElementById(inst2Id);

	var sql = "sql=SELECT DISTINCT SGG_NM, SGG_CD FROM TB_RDZ_PCODE WHERE SGG_NM IS NOT NULL ";
	if(inst1.value != "" && inst1.value != "0") sql += " and sido_cd = '" + inst1.value + "'";
	sql += " order by SGG_NM ";
	
	postXmlRes("/map/query.do",sql,function(r) {
		var xmlDoc = new k_XmlParser().init(r);
		var data = xmlDoc.gTag("data");
		var regnName = xmlDoc.gTag("SGG_NM");
		var regnCode = xmlDoc.gTag("SGG_CD");

		inst2.options.length=0;
		inst2.options[0] = new Option(i);
		inst2.options[0].text = "::기관2";
		inst2.options[0].value = "0";
		inst2.options[0].selected = true;
		for ( var i=0; i<data.length; i++){     
			newItem = new Option(i);
			inst2.options[i+1] = newItem;
			inst2.options[i+1].text = xmlDoc.gTData(regnName,i);
			inst2.options[i+1].value = xmlDoc.gTData(regnCode,i);
	    }
	    if(s != null) {
			for ( var i=0; i<inst2.options.length; i++){
				if(inst2.options[i].value == s) {
					inst2.options[i].selected = true;
					break;
				}
			}     
	    }
	});
}
function setKikwan(a,b,all,service) {
	if(typeof(a) == "string") {
		// ID값으로 넘어오는 인자는 이곳에서 처리
		var inst1 = document.getElementById(a);
		var inst2 = document.getElementById(b);
		
		var sql = "sql=select distinct substr(pcode,0,2) SIDO_CD, SIDO_NM, a.REGN_CD from tb_rdz_pcode a, tb_rdz_regncd b ";
		sql += " where a.regn_cd = b.regn_cd and substr(pcode,0,2) <> '00' and b.service_yn = 'Y'";
		if(!service) {
			sql += " or b.service_yn = 'A'";
		}
		if(!all) {
			if(gRegn != "RDZ00") sql += " and a.REGN_CD = '" + gRegn + "'";
		}
		sql += " order by SIDO_NM ";
		
		postXmlRes("/map/query.do",sql,function(r) {
			var xmlDoc = new k_XmlParser().init(r);
			var data = xmlDoc.gTag("data");
			var regnName = xmlDoc.gTag("SIDO_NM");
			var regnCode = xmlDoc.gTag("SIDO_CD");
			
			inst1.options.length=0;
			inst1.options[0] = new Option(i);
			inst1.options[0].text = "::기관1";
			inst1.options[0].value = "0";
			inst1.options[0].selected = true;
			inst1.options[1] = new Option(i);
			inst1.options[1].text = "국토해양부";
			inst1.options[1].value = "00";
			
			for ( var i=0; i<data.length; i++){     
				newItem = new Option(i);
				inst1.options[i+2] = newItem;
				inst1.options[i+2].text = xmlDoc.gTData(regnName,i);
				inst1.options[i+2].value = xmlDoc.gTData(regnCode,i);
		    }
		    
			inst1.onchange = function chckRegion() { checkInst2(a,b); };
			
			inst2.options.length=0;
			inst2.options[0] = new Option(i);
			inst2.options[0].text = "::기관2";
			inst2.options[0].value = "0";
			inst2.options[0].selected = true;
		});
				
	} else {
		if(a.getElem().options.length <= 0) {
			var sql = "sql=select distinct substr(pcode,0,2) sido_cd, sido_nm, regn_cd from tb_rdz_pcode";
			if(gRegn != "RDZ00") sql += " and a.REGN_CD = '" + gRegn + "'";
			sql += " order by sido_nm ";
			
			postXmlRes("/map/query.do",sql,function(r) {
				var xmlDoc = new k_XmlParser().init(r);
				var data = xmlDoc.gTag("data");
				var regnName = xmlDoc.gTag("sido_nm");
				var regnCode = xmlDoc.gTag("sido_cd");
				a.clear();
				a.add("::기관1",0,true);
				for(var i=0; i<data.length; i++) {
					a.add(xmlDoc.gTData(regnName,i),xmlDoc.gTData(regnCode,i));
				}
				b.add("::기관2",0,true);
				
				a.eventListener("change",function() { checkInst2(a.getId(),b.getId()); });
			});
		}
	}
}

//-->

//<!-- 권역셋팅
function setRegnCd(regn,gRegn,gPerm,all){
	regn.clear();
	var sql = "sql=select * from tb_rdz_regncd where service_yn = 'Y'";
	if(!all) sql += " or service_yn = 'A'";
	if(gRegn != "RDZ00") sql += " and REGN_CD = '" + gRegn + "'";
	
	postXmlRes("/map/query.do",sql,function(r) {
		var xmlDoc = new k_XmlParser().init(r);
		var data = xmlDoc.gTag("data");
		if(gPerm.substr(0,1) != "1" && gPerm.substr(0,1) != "3") regn.add("선택하세요","");
		for(var i=0; i<data.length; i++) {
			regn.add(xmlDoc.gTag("NAME_KOR", i), xmlDoc.gTag("REGN_CD", i));
			if(xmlDoc.gTag("REGN_CD", i) == gRegn) {
				regn.getElem().selectedIndex = i;
			}
		}
	});
}
//-->


//<!--
//행정구역 지정
function setAddressLoading(a,b,c,d,e,gRegn,gPCode,emdCd,riCd) {
	var region = document.getElementById(a);
	var sido = document.getElementById(b);
	var sgg = document.getElementById(c);
	var emd = document.getElementById(d);
	var ri = document.getElementById(e);

	for(var i=0; i<region.options.length; i++) {
		if(region.options[i].value == gRegn) {
			region.selectedIndex = i;
			checkSido(a,b,c,d,e,gPCode.substr(0,2));
			checkSgg(a,b,c,d,e,gPCode.substr(2,5));
			if(gPerm.substr(0,1) == "3") { //광역시도
				region.disabled = true;
				//sido.disabled = true;
			}
			if(emd != null) {
				checkEmd(a,b,c,d,e,emdCd);
				if(gPerm.substr(0,1) == "1") { //지자체
					region.disabled = true;
					//sido.disabled = true;
					checkSggHasGu(sido.value+""+sgg.value, sgg);
				}
				checkRi(a,b,c,d,e,riCd);
			}
			break;
		}
	}
}
//-->

//<!-- 시에 구가 속해 있는지 검사
function checkSggHasGu(pcode,obj) {
	var params = "code=isGu&pcode="+pcode;
	var rr = __b.postXmlRes("/map/AddressCode.do",params);
	var xmlDoc = new k_XmlParser().init(rr);
	var data = xmlDoc.gTag("data");
	var isGu = xmlDoc.gTag("isGu");
	if(parseInt(xmlDoc.gTData(isGu,0)) == 1) {
		//obj.disabled = true;
	} else {
		obj.disabled = false;
	}
}

//-->

//그라데이션 속성 주기
function makeGradation(obj,bColor,sColor,eColor) {
	obj.hStyle().borderStyle = "solid";
	obj.hStyle().borderColor = bColor;
	obj.hStyle().borderWidth = "1px";
	obj.hStyle().filter = "progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr="+sColor+", EndColorStr="+eColor +")";
}

function fnZero(m) { 
    z='0000'; 
    //alert(z.substr(0,z.length-String(m).length)+m);
    return z.substr(0,z.length-String(m).length)+m; 
}
function fnZero2(m) { 
    z='00'; 
    return z.substr(0,z.length-String(m).length)+m; 
}
/**
 *	달력에서 시작날짜 선택 후 종료날짜 자동으로 채우기 (오늘날짜로)
 * Calendar.js
 */
function cal_click(cal1, cal2) {
	Calendar_D(cal1);
	changeEvent = function() {
		if (cal1.value != "" && cal2.value == "") {
			var date = new Date();
			cal2.value = date.getFullYear() + "-" + fnZero2((date.getMonth() + 1)) + "-" + fnZero2(date.getDate());
		}
	};
}

function fnNumberEscZero(str) {
	var newStr = "";
	for(var i=0; i<str.length; i++) {
  		if(str.charAt(i) != "0") {
    		newStr = str.substr(i,str.length);
    		break;
  		}
	}
	return newStr;
}

function fnChkNull(str) {
	if(str == null || str == "null") {
		return "";
	} else {
		return str;
	}
}
//행 삭제
function fnDelRow(table,idx) {
	table.deleteRow(idx);
	var cnt = table.rows.length;
	for(var i=idx; i<cnt; i++) {
		if(i+1 > cnt) {
			table.rows[i] = table.rows[i+1];
		}
	}
}
//이미지(사진)보기 - 팝업창
function fnImageViewer(fileName,winTitle) {
	
	var imgwin = window.open("",'WIN','width=0,height=0,topmargin=0,leftmargin=0,location=0,menubar=0,status=0,scrollbars=no,resizable=yes,titlebar=0,toolbar=0'); 
	imgwin.document.close(); 
	imgwin.focus(); 
	imgwin.document.open(); 
	var html = "<html>"; 
	html += "<head>"; 
	html += "<title>"+winTitle+"</title>"; 
	html += "<script>"; 
	html += "function resizePop() {\n";
	html += "  document.getElementById('viewDiv').style.width = document.body.clientWidth;\n";
	html += "  document.getElementById('viewDiv').style.height = document.body.clientHeight-33;\n";
	html += "}\n";
	html += "function resize() {\n"; 
	html += "var MaxWidth = 700; var MaxHeight = 700; var sratio = 0; var swidth = MaxWidth; var sheight = MaxHeight; var nwidth = swidth; var nheight = sheight;\n";
	html += "pic = document.il;\n"; 
	html += "if (eval(pic).height) { \n"; 
	html += "  swidth = eval(pic).width; sheight = eval(pic).height;\n"; 
	html += "  if(swidth >= sheight) {\n "; 
	html += "    if(swidth > MaxWidth) { \n"; 
	html += "      sratio = Math.round((MaxWidth / swidth) * 100);\n";
	html += "      nwidth = Math.round(swidth * sratio / 100);\n";
	html += "      nheight = Math.round(sheight * sratio / 100);\n";
	html += "    } else { nwidth = swidth; nheight = sheight; }\n";
	html += "  } else if(swidth < sheight) {\n";
	html += "    if(sheight > MaxHeight) {\n";
	html += "      sratio = Math.round((MaxHeight / sheight) * 100);\n";
	html += "      nwidth = Math.round(swidth * sratio / 100);\n";
	html += "      nheight = Math.round(sheight * sratio / 100);\n";
	html += "    } else { nwidth = swidth; nheight = sheight; }\n";
	html += "  }\n";
	html += "  self.resizeTo(nwidth, nheight+60);\n";
	html += "  pic.width = nwidth;\n";
	html += "  pic.height = nheight;\n";
	html += "  clearTimeout();\n";
	html += "} else {setTimeOut(resize(), 100);}}\n\n";
	html += "function zoomIn() { \n";
	html += "  var image = document.getElementById('viewImg');\n";
	html += "  var currentWidth = image.width;\n";
	html += "  var currentHeight = image.height;\n";
	html += "  var width = parseInt(currentWidth * 1.1); \n";
	html += "  var height = parseInt(currentHeight * 1.1); \n";
	html += "  image.width = width;\n";
	html += "  image.height = height;\n";
	html += "  document.getElementById('viewDiv').style.width = document.body.clientWidth;\n";
	html += "  document.getElementById('viewDiv').style.height = document.body.clientHeight-33;\n";
	html += "}\n";
	html += "function zoomOut() { \n";
	html += "  var image = document.getElementById('viewImg');\n";
	html += "  var currentWidth = image.width;\n";
	html += "  var currentHeight = image.height;\n";
	html += "  var width = parseInt(currentWidth * 0.9); \n";
	html += "  var height = parseInt(currentHeight * 0.9); \n";
	html += "  image.width = width;\n";
	html += "  image.height = height;\n";
	html += "  document.getElementById('viewDiv').style.width = document.body.clientWidth;\n";
	html += "  document.getElementById('viewDiv').style.height = document.body.clientHeight-33;\n";
	html += "}";
	html += "var ndx=0;\n";
	html += "function imgChange(){\n";
	html += "  document.all.viewImg.src = '/map/ImageView.do?img='+encodeURI(document.getElementById('selImg').value);\n";
	html += "  ndx = document.getElementById('selImg').selectedIndex;\n";
	html += "  document.getElementById('td01').innerText = '';";
	html += "  document.getElementById('td01').innerText = ndx+1;";
	html += "}\n";
	html += "function prevImg(){\n";
	html += "  if(ndx == 0) document.getElementById('selImg').selectedIndex = document.getElementById('selImg').length - 1;\n";
	html += "  else document.getElementById('selImg').selectedIndex = document.getElementById('selImg').selectedIndex - 1;\n";
	html += "  imgChange();\n";
	html += "}\n";
	html += "function nextImg(){\n";
	html += "	 if(ndx == document.getElementById('selImg').length-1) document.getElementById('selImg').selectedIndex = 0;\n";
	html += "  else document.getElementById('selImg').selectedIndex = document.getElementById('selImg').selectedIndex + 1;\n";
	html += "  imgChange();\n";
	html += "}\n";
	html += "</sc"+"ript>"; 
	html += "</head>";
	html += "<body topmargin='0' leftmargin='0' bgcolor='#ffffff' onresize='resizePop();'>";
	html += "<div style='background-color:#ffffff;border-bottom-style:solid;border-bottom-width:2px;border-bottom-color:#808080';width:document.body.clientWidth;height:35px>";
	html += "<select id='selImg' name='selImg' onchange='imgChange();' style='display:none'>";
	if(typeof(fileName) == "string") {
		html += "<option value='"+fileName+"'>"+fileName+"</option>";
	} else {
		for(var i=0; i<fileName.length; i++) {			
			html += "<option value='"+fileName[i]+"'>"+(i+1)+"</option>";
		}
	}
	html += "</select>";
	html += "<center><table><tr>";
	html += "<td><input type='button' value='확대' onmouseup='zoomIn()'></td>";
	html += "<td><input type='button' value='축소' onmouseup='zoomOut()'></td>";
	html += "<td><input type='button' value='이전' onclick='prevImg();'></td>";
	if(typeof(fileName) == "string") {
		html += "<td id='td01'>1</td><td>/</td><td>1</td>";
	} else {
		html += "<td id='td01'>1</td><td>/</td><td>"+fileName.length+"</td>";
	}
	html += "<td><input type='button' value='다음' onclick='nextImg();'></td>";
	html += "</tr></table></center>";
	html += "</div>";
	html += "<div id='viewDiv' style='overflow:auto;background-color:#E0E0E0;width:document.body.width;height:document.body.height'>";
	if(typeof(fileName) == "string") {
		html += "<img id='viewImg' border=0 src=/map/ImageView.do?img="+encodeURI(fileName)+" name=il onload='resize();'>";
	} else {
		html += "<img id='viewImg' border=0 src=/map/ImageView.do?img="+encodeURI(fileName[0])+" name=il onload='resize();'>";
	}	
	html += "</div>";
	html += "</body></html>";
	imgwin.document.write(html);
	imgwin.document.close(); 
}

function imgChange(selectId,imgId,tdId){ 
	document.getElementById(imgId).src = "/map/ImageView.do?img="+encodeURI(document.getElementById(selectId).value); 
    var ndx = document.getElementById(selectId).selectedIndex; 
    document.getElementById(tdId).innerText = '';
    document.getElementById(tdId).innerText = ndx+1;
} 
function fnPrevImg(selectId,imgId,tdId){
	var ndx = document.getElementById(selectId).selectedIndex;
	if(ndx == 0) document.getElementById(selectId).selectedIndex = document.getElementById(selectId).length - 1; 
	else document.getElementById(selectId).selectedIndex = document.getElementById(selectId).selectedIndex - 1; 
	js.tdId; 
}
function fnNextImg(selectId,imgId,tdId){ 
	var ndx = document.getElementById(selectId).selectedIndex;
	if(ndx == document.getElementById(selectId).length-1) document.getElementById(selectId).selectedIndex = 0; 
	else document.getElementById(selectId).selectedIndex = document.getElementById(selectId).selectedIndex + 1; 
	js.tdId; 
}

function fnGetFileName(s) {
	var fname = s;
	var arr=("file:///"+fname.replace(/ /gi,"%20").replace(/\\/gi,"/")).split("/");
	fname = arr[arr.length-1];
	return fname;
}

function fnCheckFileFormat(filepath, fileFormats) {
    if (filepath == "") return;
    
    var ret = false;
    var pos = filepath.lastIndexOf(".");
    if (pos >= 0) {
        var fileExt = filepath.substr(pos + 1).toLowerCase();
        if (("|" + fileFormats.toLowerCase() + "|").indexOf("|" + fileExt + "|") < 0) {
            ret = false;
        } else {
        	ret = true;
        }
    }
    
    return ret;
}


//달력에서 '-'을 뺀 날짜를 가져옴
function fnGetCalendarDate(str) {
	var temp = "";
	var tempAry;
	
	if(str != "") {
		tempAry = str.split("-");
		for(var i=0; i<tempAry.length; i++){
			temp += str.split("-")[i];
		}
	} else {
		temp = str;
	}
	return temp;
}

//숫자체크
function fnCheckNum(obj) {
    var kc = event.keyCode;
    if((kc < 48 || kc > 57) && (kc < 96 || kc > 105) 
    		&& (kc != 8 && kc != 9 && kc != 13 && kc != 46 && kc != 190 && kc != 110 && kc != 37 && kc != 38 && kc != 39 && kc != 40)) {                  
    	alert("숫자만 입력할 수 있습니다.");             
        obj.focus();
        obj.value = "";
        window.event.returnValue = false;                
    }
}

//달력에서 숫자만 쓰도록 체크
function fnCheckDate(obj) {
    var kc = event.keyCode;
    if((kc < 48 || kc > 57) && (kc < 96 || kc > 105) 
    		&& (kc != 8 && kc != 9 && kc != 13 && kc != 46 && kc != 189 && kc != 109 && kc != 37 && kc != 38 && kc != 39 && kc != 40)) {                  
    	alert("숫자,(-)만 입력할 수 있습니다.");             
        obj.focus();
        obj.value = "";
        window.event.returnValue = false;                
    }
}

//트림
function trim(str){
   //정규 표현식을 사용하여 화이트스페이스를 빈문자로 전환
   str = str.replace(/^\s*/,"").replace(/\s*$/, ""); 
   return str; //변환한 스트링을 리턴.
} 

//값 비교 (최대값 리턴)
function fnGetMax(str1,str2) {
	var val1 = parseFloat(str1);
	var val2 = parseFloat(str2);
	var max = val2;
	if(val1 > val2) max = val1;
	else max = val2;
	return max;
}

function fnChkFloat(str) {
	var v = String(str);
	var r = v.split(".");
	if(r[1] == null) return eval(v);
	else return eval(v).toFixed(2);
}

function dist(m) {m.distance();}

function area(m) {m.area();} 



//방문자수 count
function count(oToday, oTotal) {
	var toDate = new Date();
	var year = toDate.getYear();
	var month = toDate.getMonth()+1;
	var day = toDate.getDate();
	var today = year+""+js.month+""+js.day;
	
	var sql = "sql=select ";
	sql += "(select count(*) from tb_rdz_work_his where work_gubn = 'L' and TO_CHAR(TO_DATE(SUBSTR(WORK_DATE,0,10)),'yyyymmdd') = '"+today+"') as today";
	sql += ",(select count(*) from tb_rdz_work_his where work_gubn = 'L') as total";
	sql += " from tb_rdz_work_his where rownum = 1";
	
	postXmlRes("/map/query.do", sql, function(r) {
		var xmlDoc = new k_XmlParser().init(r);
		var data = xmlDoc.gTag("data");
		oToday.setValue(comma(xmlDoc.gTag("TODAY", 0)));
		oTotal.setValue(comma(xmlDoc.gTag("TOTAL", 0)));
	});
}

function getPnuTableName(pnu) {
	var tb = "";
	if(pnu.substr(0,2)=="30" || pnu.substr(0,2)=="44" || pnu.substr(0,2)=="43") { 
		tb = "LP_PA_CBND_DJ";
	} else if(pnu.substr(0,2)=="41") {
		tb = "LP_PA_CBND_KY";
	} else if(pnu.substr(0,2)=="11" || pnu.substr(0,2)=="28") {
		tb = "LP_PA_CBND_SD_IN";
	} else if(pnu.substr(0,2)=="27" || pnu.substr(0,2)=="47") {
		tb = "LP_PA_CBND_DG";
	} else if(pnu.substr(0,2)=="29" || pnu.substr(0,2)=="46") {
		tb = "LP_PA_CBND_GJ";
	} else if(pnu.substr(0,2)=="26") {
		tb = "LP_PA_CBND_BS";
	} else if(pnu.substr(0,2)=="48") {
		tb = "LP_PA_CBND_MS";
	} else if(pnu.substr(0,2)=="31") {
		tb = "LP_PA_CBND_US";
	}
	return tb;
}

//프린트 출력 모듈 
function goPrint(){
	var windowLeft = (screen.width-640)/2;
	var windowTop = (screen.height-480)/2;
	var printURL = "/js/printPrc.html";
	window.open(printURL,"print",'width=800, height=600, menubar=no,scrollbars=yes,status=no,resizable=yes,top=' + windowTop + ',left=' + windowLeft + '');
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


//아작스 페이징  
var gfv_ajaxCallback = "";
  
function ComAjax(opt_formId){
    this.url = "";     
    this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
    this.param = "";
     
    if(this.formId == "commonForm"){
        var frm = $("#commonForm");
        if(frm.length > 0){
            frm.remove();
        }
        var str = "<form id='commonForm' name='commonForm'></form>";
        $('body').append(str);
    }
     
    this.setUrl = function setUrl(url){
        this.url = url;
    };
     
    this.setCallback = function setCallback(callBack){
        fv_ajaxCallback = callBack;
    };
 
    this.addParam = function addParam(key,value){
        this.param = this.param + "&" + key + "=" + value;
    };
     
    this.ajax = function ajax(){
        if(this.formId != "commonForm"){
            this.param += "&" + $("#" + this.formId).serialize();
        }
        
        
        $.ajax({
            url : this.url,   
            type : "POST",  
            data : this.param,
            dataType: "json",
            async : false,
            success : function(data, status) {
                if(typeof(fv_ajaxCallback) == "function"){
                    fv_ajaxCallback(data);
                }
                else {
                    eval(fv_ajaxCallback + "(data);");
                }
            }
        });
    };

};

var gfv_pageIndex = null;
var gfv_eventName = null;

function gfn_renderPaging(params){
    var divId = params.divId; //페이징이 그려질 div id
    gfv_pageIndex = params.pageIndex; //현재 위치가 저장될 input 태그
    var totalCount = params.totalCount; //전체 조회 건수
    var currentIndex = $("#"+params.pageIndex).val(); //현재 위치
    var checkNo = params.checkNo;

    if(checkNo == 100){
        currentIndex = 1;
    }else if($("#"+params.pageIndex).length == 0 || gfn_isNull(currentIndex) == true){
    	currentIndex = 1;
    }
     
    var recordCount = params.recordCount; //페이지당 레코드 수
    if(gfn_isNull(recordCount) == true){
        recordCount = 10;
    }
    
    var totalIndexCount = Math.ceil(totalCount / recordCount);
    // 전체 인덱스 수
    gfv_eventName = params.eventName;
       
    $("#"+divId).empty();
    
    var preStr = "";
    var postStr = "";
    var str = "";
     
    var first = (parseInt((currentIndex-1) / 10) * 10) + 1;
    var last = (parseInt(totalIndexCount/10) == parseInt(currentIndex/10)) ? totalIndexCount%10 : 10;
    var prev = (parseInt((currentIndex-1)/10)*10) - 9 > 0 ? (parseInt((currentIndex-1)/10)*10) - 9 : 1;
    var next = (parseInt((currentIndex-1)/10)+1) * 10 + 1 < totalIndexCount ? (parseInt((currentIndex-1)/10)+1) * 10 + 1 : totalIndexCount;
    if(totalIndexCount > 10){ //전체 인덱스가 10이 넘을 경우, 맨앞, 앞 태그 작성
        preStr += "<a href='#this' class='pad_5' onclick='_movePage(1)'>[<<]</a>" +
                "<a href='#this' class='pad_5' onclick='_movePage("+prev+")'>[<]</a>";
    }
    else if(totalIndexCount <=10 && totalIndexCount > 1){ //전체 인덱스가 10보다 작을경우, 맨앞 태그 작성
        preStr += "<a href='#this' class='pad_5' onclick='_movePage(1)'>[<<]</a>";
    }
     
    if(totalIndexCount > 10){ //전체 인덱스가 10이 넘을 경우, 맨뒤, 뒤 태그 작성
        postStr += "<a href='#this' class='pad_5' onclick='_movePage("+next+")'>[>]</a>" +
                    "<a href='#this' class='pad_5' onclick='_movePage("+totalIndexCount+")'>[>>]</a>";
    }
    else if(totalIndexCount <=10 && totalIndexCount > 1){ //전체 인덱스가 10보다 작을경우, 맨뒤 태그 작성
        postStr += "<a href='#this' class='pad_5' onclick='_movePage("+totalIndexCount+")'>[>>]</a>";
    }
    for(var i=first; i<(first+last); i++){
        if(i != currentIndex){
            str += "<a href='#this' class='pad_5' onclick='_movePage("+i+")'>"+i+"</a>";
        }
        else{
            str += "<b><a href='#this' class='pad_5' onclick='_movePage("+i+")'>"+i+"</a></b>";
        }
    }
    $("#"+divId).append(preStr + str + postStr);
}
 
function _movePage(value){
    $("#"+gfv_pageIndex).val(value);
    if(typeof(gfv_eventName) == "function"){
        gfv_eventName(value);
    }
    else {
    	
        eval(gfv_eventName + "(value);");
    }
}
