<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.edatagrid.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/datagrid-detailview.js"></script>
<script type="text/javascript">
 var url;
 function searchTwo(){
	 $("#dg").datagrid('load',{
		"careerOne.id":$("input[name='s_one']").val()
	 });
 }
 function resetSearch(){
	 $("#s_one").combobox("clear");
 }
 function openTwoAddDialog(){
	 $("#dlg").dialog("open").dialog("setTitle","添加二级职位");
	 url="${pageContext.request.contextPath}/careerTwo/save.do";
 }
 
 function openTwoModifyDialog(){
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length!=1){
		 $.messager.alert("系统提示","请选择一条要编辑的数据！");
		 return;
	 }
	 var row=selectedRows[0];
	 $("#dlg").dialog("open").dialog("setTitle","编辑二级职位");
	 $("#fm").form("load",{
		 name:row.name
	 });
	 $("#add_one").combobox('select',row.careerOne.id);
	 url="${pageContext.request.contextPath}/careerTwo/save.do?id="+row.id;
 }
 function saveTwo(){
	 $("#fm").form("submit",{
		url:url,
		onSubmit:function(){
			return $(this).form("validate");
		},
		success:function(result){
			var result=eval('('+result+')');
			if(result.success){
				$.messager.alert("系统提示","保存成功！");
				resetValue();
				$("#dlg").dialog("close");
				$("#dg").datagrid("reload");
			}else{
				$.messager.alert("系统提示","保存失败！");
				return;
			}
		}
	 });
 }
 function closeTwoDialog(){
	 $("#dlg").dialog("close");
	 resetValue();
 }
 function resetValue(){
	 $("#name").val("");
	 $("#add_one").combobox("clear");
 }
 //删除
 function deleteTwo(){
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length==0){
		 $.messager.alert("系统提示","请选择要删除的数据！");
		 return;
	 }
	 var strIds=[];
	 for(var i=0;i<selectedRows.length;i++){
		 strIds.push(selectedRows[i].id);
	 }
	 var ids=strIds.join(",");
	 $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
		if(r){
			$.post("${pageContext.request.contextPath}/careerTwo/delete.do",{ids:ids},function(result){
				if(result.success){
				    $.messager.alert("系统提示",result.msg);
				    $("#dg").datagrid("reload");
				}
			},"json");
		} 
	 });
 }
</script>
<title>Insert title here</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="二级职位管理" class="easyui-datagrid" style="background-color:#000"
   fitColumns="true" pagination="true" rownumbers="true" striped="true" 
   checkOnSelect="true" selectOnCheck="true" fit="true"
   url="${pageContext.request.contextPath}/careerTwo/list.do"
   toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="5" align="center" editor="text">编号</th>
   		<th field="name" width="30" align="center" editor="text">二级职位</th>
   		<th field="car" width="10" align="center" editor="text" data-options="formatter:function(v,r){return r.careerOne.name}">一级职位</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		<a href="javascript:openTwoAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
 		<a href="javascript:openTwoModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteTwo()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 	</div>
 	<div>
 		&nbsp;一级职位：&nbsp;<input class="easyui-combobox" id="s_one" name="s_one" data-options="panelHeight:'auto',editable:false,
               			valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/careerOne/listAll.do'"/>
 		<a href="javascript:searchTwo()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 		<a href="javascript:resetSearch()" class="easyui-linkbutton" iconCls="icon-undo" plain="true">重置</a>
 	</div>
 </div>
 
 <div id="dlg" class="easyui-dialog" style="width:350px;height:170px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>一级职位：</td>
   			<td>
   				<input class="easyui-combobox" id="add_one" name="add_one" data-options="panelHeight:'auto',editable:false,
               			valueField:'id',textField:'name',url:'${pageContext.request.contextPath}/careerOne/listAll.do'"/>
			</td>
   		</tr>
   		<tr>
   			<td>二级职位：</td>
   			<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveTwo()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeTwoDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>