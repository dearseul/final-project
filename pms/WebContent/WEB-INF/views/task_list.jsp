<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<fmt:requestEncoding value="UTF-8" /> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>Tasks List</title>
<style type="text/css">
	table#demo-foo-filtering tr:first-child th { background:  rgba(0, 0, 0, 0.075);}
	.wrap-tasklist-btn { position:absolute; top:20px; right:20px;  }
	table#demo-foo-pagination tr:first-child th { background:  rgba(0, 0, 0, 0.075);}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
<meta content="Coderthemes" name="author" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
 <!-- App favicon -->
<link rel="shortcut icon" href="${path }/Admin/dist/assets/images/favicon.ico">

<!-- plugin css -->
<link href="${path }/Admin/dist/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
 <!-- Plugins css -->
 <link href="${path }/Admin/dist/assets/libs/mohithg-switchery/switchery.min.css" rel="stylesheet" type="text/css" />
 <link href="${path }/Admin/dist/assets/libs/multiselect/css/multi-select.css" rel="stylesheet" type="text/css" />
 <link href="${path }/Admin/dist/assets/libs/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
 <link href="${path }/Admin/dist/assets/libs/selectize/css/selectize.bootstrap3.css" rel="stylesheet" type="text/css" />
 <link href="${path }/Admin/dist/assets/libs/bootstrap-touchspin/jquery.bootstrap-touchspin.min.css" rel="stylesheet" type="text/css" />

<!-- App css -->
<link href="${path }/Admin/dist/assets/css/modern/bootstrap-modern.min.css" rel="stylesheet" type="text/css" id="bs-default-stylesheet" />
<link href="${path }/Admin/dist/assets/css/modern/app-modern.min.css" rel="stylesheet" type="text/css" id="app-default-stylesheet" />

<link href="${path }/Admin/dist/assets/css/modern/bootstrap-modern-dark.min.css" rel="stylesheet" type="text/css" id="bs-dark-stylesheet" />
<link href="${path }/Admin/dist//assets/css/modern/app-modern-dark.min.css" rel="stylesheet" type="text/css" id="app-dark-stylesheet" />

<!-- icons -->
<link href="${path }/Admin/dist/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function(){

var mem = "${mem.id}";
if(mem==""){
	alert("????????? ?????????");
	location.href="${path}/main.do?method=loginform"; // ????????? ?????? ??? ?????? ???????????? ??????	
}

$("#btnAddTaskForm").click(function(){
	$("#addTaskModal").modal("show");
	
});



//?????? ???????????? ?????? ?????? submit?????? ??????
var doubleSubmitFlag = false;
function doubleSubmitCheck(){
    if(doubleSubmitFlag){
        return doubleSubmitFlag;
    }else{
        doubleSubmitFlag = true;
        return false;
    }
}



document.getElementById('startdte').value = new Date().toISOString().substring(0, 10); // ?????? ????????? ?????? 
$("#btnAddTask").click(function(){
	/* if(doubleSubmitCheck()) return; */
	// ?????? ???????????? ?????? ?????? submit??????
	 /* $("#addTaskModal>form")[0].reset(); */ // ??? ????????? ??????.
	 // ????????? ??????
	var nameObj = document.querySelector("#taskFrm [name=task_name]");
	var contObj = document.querySelector("#taskFrm [name=task_content]");
	var pnoObj = document.querySelector("#taskFrm [name=pno]");
	var prioObj = document.querySelector("#taskFrm [name=task_priority]");
	var endObj = document.querySelector("#taskFrm [name=enddte]");
	var startdte = document.querySelector("#taskFrm [name=startdte]").value;
	var enddte = document.querySelector("#taskFrm [name=enddte]").value;
	var startDate = new Date(startdte);
	var endDate = new Date(enddte);
/* 	var isValid=true; */
	if(startDate>endDate){
		alert("???????????? ????????? ????????? ??????????????????");
		return false;
	}
	if(nameObj.value==""){
		alert("????????? ????????? ??????????????????");
		nameObj.focus();
		return false;
	}
	if(contObj.value==""){
		alert("????????? ????????? ??????????????????");
		contObj.focus();
		return false;
	}if(pnoObj.value==""){
		alert("???????????? ??????????????????");
		pnoObj.focus();
		return false;
	}if(prioObj.value==""){
		alert("????????? ???????????? ??????????????????");
		prioObj.focus();
		return false;
	}if(endObj.value==""){
		alert("??????????????? ??????????????????");
		endObj.focus();
		return false;
	}	

		// ????????? check??? ???????????? ?????? ??????, ????????? ??????????????? ????????????	
	var sch = addtask(); //  ???????????? ????????? ?????? ?????????
	console.log("##????????? ?????????##");
	console.log(sch);

	// ????????? ?????? ?????? ajax(db?????????)
	$.ajax({
		  type:"post",
		  url:"${path}/task.do?method=insert",
		  data: sch,
		  dataType:"json", // ???????????? json ????????? ?????? ??????
		  success:function(data){
			  if(data.success=="Y")
			  console.log(data);

			  $("#addTaskModal").modal("hide");	  
			/*   $(document).load("${path}/task.do?method=list?no="+${param.no});  */
			
			  $("#success-alert-modal").modal("show");
			  $("#success-alert-modal .btn").click(function(){
				  window.location.reload(true);
			  });			 
		  },
		  error:function(err){
			  alert("????????????: "+err);
			  console.log(err);
		  }		 
	});  
	
});

function addtask(){
    var sch = {};
    sch.no = ${param.no};
    sch.project_no = ${param.no};
    sch.task_name = $("[name=task_name]").val();
    sch.task_content = $("[name=task_content]").val();
    sch.pno = $("[name=pno]").val();
    sch.task_priority = $("[name=task_priority]").val();
    // ????????? ????????? ?????? ??????  
    // Date????????? ???????????? ???????????? ???????????? ??????????????? ??????.
    // ??????????????? ????????? data.start//date.end??? ISO ????????? ?????? ??????
    // ?? calendar api?????? ???????????? ?????? ?????? ????????? ISO????????? ????????????
  	// ????????????. ex) Date ==> toISOString() ??????
  	
    sch.startdte = $("[name=startdte]").val()+"T00:00:00.000Z";
    sch.enddte = $("[name=enddte]").val()+"T18:00:00.000Z";
    // alert('????????? ?????????:'+sch.start);
    
    return sch;
 }
function checkExistData(value, dataName) {
    if (value == "") {
        alert(dataName + " ??????????????????!");
        return false;
    }
    return true;
}

});
</script>
    </head>
    <body class="loading">
        <!-- Begin page -->
        <div id="wrapper">

            <!-- Topbar Start -->
            <jsp:include page="top.jsp"></jsp:include>
            <!-- end Topbar -->

            <!-- ========== Left Sidebar Start ========== -->
			<jsp:include page="side.jsp"></jsp:include>
            <!-- Left Sidebar End -->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">
                        <div class="row">
						   <div class="row" style="padding-top:10px;">
							<a href="#"><button class="btn btn-primary btn-md">${project.project_name}</button></a>
							</div> 
							<div class="col-xl-12">
								 <ul class="nav nav-tabs nav-bordered" style="padding-top:10px;">
						            <li class="nav-item">
						                      <a href="${path }/task.do?method=view&no=${param.no}"  class="nav-link ">
						                    <span class="d-inline-block d-sm-none"><i class="bx bx-book-open"></i></span>
						                    <span class="d-none d-sm-inline-block">?????????</span>
						                </a>
						            </li>
						            <li class="nav-item">
						                <a href="${path}/task.do?method=list&no=${param.no}" class="nav-link active">
						                    <span class="d-inline-block d-sm-none"><i class="bx bx-task"></i></span>
						                    <span class="d-none d-sm-inline-block">??????????????????</span>
						                </a>
						            </li>
						            <li class="nav-item">
						                <a href="${path}/dashboard.do?method=list&no=${param.no}"  class="nav-link">
						                    <span class="d-inline-block d-sm-none"><i class="bx bxs-dashboard"></i></span>
						                    <span class="d-none d-sm-inline-block">????????????</span>
						                </a>
						            </li>
						            <li class="nav-item">
						                <a href="${path}/gantt.do?method=gantt&no=${param.no}"  class="nav-link">
						                    <span class="d-inline-block d-sm-none"><i class=" bx bx-bar-chart-square"></i></span>
						                    <span class="d-none d-sm-inline-block">????????????</span>
						                </a>
						            </li>
						            <li class="nav-item">
						                <a href="${path}/cal.do?method=list&no=${param.no}"  class="nav-link">
						                    <span class="d-inline-block d-sm-none"><i class="bx bx-calendar"></i></span>
						                    <span class="d-none d-sm-inline-block">?????????</span>
						                </a>
						            </li>
						            <li class="nav-item">
						                <a href="${path}/task.do?method=log&no=${param.no}"  class="nav-link">
						                    <span class="d-inline-block d-sm-none"><i class="bx bx-comment-dots"></i></span>
						                    <span class="d-none d-sm-inline-block">????????????</span>
						                </a>
						            </li>
						            <li class="nav-item">
						                <a href="${path}/risk.do?method=riskBoard&no=${param.no}"  class="nav-link">
						                           <span class="d-inline-block d-sm-none"><i class="bx bx-info-circle"></i></span>
						                           <span class="d-none d-sm-inline-block">????????? ??????</span>
						                </a>
						            </li>
						            <c:if test="${mem.auth=='pm' }">
								 <li class="nav-item"><a
									href="${path}/risk.do?method=riskRequest&no=${param.no}" class="nav-link "> <span
										class="d-inline-block d-sm-none"><i
											class="bx bx-info-circle"></i></span> <span
										class="d-none d-sm-inline-block">????????? ??????</span>
								</a></li>
								</c:if>
						         </ul> 
							</div>
						</div>
                        <!-- start page title -->
<!--                         <div class="row">
                            <div class="col-12">
                                <div class="page-title-box page-title-box-alt">
                                    <h4 class="page-title">Tasks List</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Minton</a></li>
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks</a></li>
                                            <li class="breadcrumb-item active">Tasks List</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>   -->   
                        <!-- end page title --> 
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
									  <c:if test="${mem.auth == 'pm' }">
	                                       <div class="wrap-tasklist-btn">
	                                       <button type="button" class="btn btn-warning waves-effect waves-light" id="btnAddTaskForm"><i class="mdi mdi-briefcase-plus me-1"></i>????????? ??????</button>
	                                       </div>                                   
                                       </c:if>
                                       
                                        <h4 class="header-title">Tasks List</h4>
                                        <p class="sub-header">
                                            ?????? ??????????????? ?????? ????????? ????????? ?????????.
                                        </p>
    
                                        <div class="mb-2">
                                            <div class="row row-cols-lg-auto g-2 align-items-center">
                                                <div class="col-12">
                                                    <div>
                                                        <select id="demo-foo-filter-status" class="form-select form-select-sm">
                                                            <option value="">Show all</option>
                                                            <option value="High">High</option>
                                                            <option value="Medium">Medium</option>
                                                            <option value="Low">Low</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <input id="demo-foo-search" type="text" placeholder="Search" class="form-control form-control-sm" autocomplete="on">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="table-responsive">
                                            <table id="demo-foo-filtering" class="table table-bordered toggle-circle mb-0" data-page-size="7">
                                                <thead>
                                                <tr>
                                                	<th>Task ID</th>
                                                    <th data-toggle="true">Tasks</th>
                                                    <th>Assign to</th>
                                                    <th>Due Date</th>
                                                    <th>Task priority</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach var="task" items="${TaskList}">          
                                                <tr style="cursor:pointer;" onclick="location.href='${path}/taskdetail.do?method=list&task_no=${task.task_no}'">
                                                	<td>${task.task_no}</td>
                                                    <td>${task.task_name}</td>
                                                    <td>${task.name}</td>
                                                    <td> <fmt:parseDate value="${task.enddte}" var="dateFmt" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"/>
														 <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>
														 </td>                                                                                                 
                                                      <td>
                                                      
                                                      <c:choose>    
                                                      <c:when test="${task.task_priority eq 'High'}">
                                                      	<span class="badge label-table badge-soft-danger p-1">
                                                      </c:when>
                                                      <c:when test="${task.task_priority eq 'Medium'}">
                                                      	<span class="badge label-table badge-soft-primary p-1">
                                                      </c:when>
                                                      <c:otherwise>
                                                      	<span class="badge label-table badge-soft-success p-1">
                                                      </c:otherwise>
                                                  	</c:choose>	
                                                  	${task.task_priority}</span></td> 
                                                </tr>
                                            </c:forEach>                                                                   
                                                </tbody>
                                                <tfoot>
                                                <tr class="active">
                                                    <td colspan="10">
                                                        <div>
                                                            <ul class="pagination pagination-rounded justify-content-end footable-pagination mb-0"></ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div> <!-- end .table-responsive-->
                                    </div>
                                </div> <!-- end card -->
                            </div> <!-- end col -->
                        </div>
                        <!-- end row -->
                           <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="header-title">?????? ??????</h4>
                                        <p class="sub-header">
                                            ????????? ?????? ?????? ?????? ????????? ?????????.
                                        </p>

                                        <table class="tablesaw table mb-0" data-tablesaw-sortable data-tablesaw-sortable-switch>
                                            <thead>
                                            <tr>
                                                <th scope="col" data-tablesaw-sortable-col data-tablesaw-priority="persist">Task ID</th>
                                                <th scope="col" data-tablesaw-sortable-col data-tablesaw-sortable-default-col data-tablesaw-priority="3">Tasks</th>
                                                <th scope="col" data-tablesaw-sortable-col data-tablesaw-priority="2">Assign to</th>
                                                <th scope="col" data-tablesaw-sortable-col data-tablesaw-priority="1">Due Date</th>
                                                <th scope="col" data-tablesaw-sortable-col data-tablesaw-priority="4">Task priority</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                          <c:forEach var="task" items="${TaskList2}" begin="0" end="4">          
                                                <tr style="cursor:pointer;"  onclick="location.href='${path}/taskdetail.do?method=list&task_no=${task.task_no}'">
                                                	<td>${task.task_no}</td>
                                                    <td>${task.task_name}</td>
                                                    <td>${task.name}</td>
                                                    <td><fmt:parseDate value="${task.enddte}" var="dateFmt" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"/>
														 <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/></td>                                             
                                                      <td>
                                                      <c:choose>    
                                                      <c:when test="${task.task_priority eq 'High'}">
                                                      	<span class="badge label-table badge-soft-danger p-1">
                                                      </c:when>
                                                      <c:when test="${task.task_priority eq 'Medium'}">
                                                      	<span class="badge label-table badge-soft-primary p-1">
                                                      </c:when>
                                                      <c:otherwise>
                                                      	<span class="badge label-table badge-soft-success p-1">
                                                      </c:otherwise>
                                                  	</c:choose>	
                                                  	${task.task_priority}</span></td> 
                                                </tr>
                                            </c:forEach>                            
                                            </tbody>
                                        </table>
                                    </div>
                                </div> <!-- end card -->
                            </div> <!-- end col-->
                        </div>
                        <!-- end row -->
                        
                        <!-- start ????????? ????????? ????????? -->
                         <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">     
                                        <h4 class="header-title">Tasks List</h4>
                                        <p class="sub-header">
                                            ?????? ??????????????? ????????? ????????? ????????? ?????????.
                                        </p>
                                   
                                          <label class="d-inline-flex align-items-center mb-3">
                                            Show
                                            <select id="demo-show-entries" class="form-select form-select-sm mx-1">
                                                <option value="5">5</option>
                                                <option value="10">10</option>
                                                <option value="15">15</option>
                                                <option value="20">20</option>
                                            </select>
                                            entries
                                        </label>
                                        <div class="table-responsive">
                                            <table id="demo-foo-pagination" class="table mb-0 table-bordered" data-page-size="7">
                                                <thead>
                                                <tr>
                                                	<th>Task ID</th>
                                                    <th data-toggle="true">Tasks</th>
                                                    <th>Assign to</th>
                                                    <th>Due Date</th>
                                                    <th>Task priority</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach var="task" items="${doneTaskList}">          
                                                <tr style="cursor:pointer;" onclick="location.href='${path}/taskdetail.do?method=list&task_no=${task.task_no}'">
                                                	<td>${task.task_no}</td>
                                                    <td>${task.task_name}</td>
                                                    <td>${task.name}</td>
                                                    <td> <fmt:parseDate value="${task.enddte}" var="dateFmt" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"/>
														 <fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>
														 </td>                                                                                                 
                                                      <td>
                                                      
                                                      <c:choose>    
                                                      <c:when test="${task.task_priority eq 'High'}">
                                                      	<span class="badge label-table badge-soft-danger p-1">
                                                      </c:when>
                                                      <c:when test="${task.task_priority eq 'Medium'}">
                                                      	<span class="badge label-table badge-soft-primary p-1">
                                                      </c:when>
                                                      <c:otherwise>
                                                      	<span class="badge label-table badge-soft-success p-1">
                                                      </c:otherwise>
                                                  	</c:choose>	
                                                  	${task.task_priority}</span></td> 
                                                </tr>
                                            </c:forEach>                                                                   
                                                </tbody>
                                                <tfoot>
                                                <tr class="active">
                                                    <td colspan="10">
                                                        <div>
                                                            <ul class="pagination pagination-rounded justify-content-end footable-pagination mb-0"></ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div> <!-- end .table-responsive-->
                                    </div>
                                </div> <!-- end card -->
                            </div> <!-- end col -->
                        </div> 
                        
                        
                    </div> <!-- container-fluid -->

                </div> <!-- content -->
                
                
                
 				<!-- ????????? ?????? ??????  -->
				 <!--  Modal content for the Large example   tabindex="-1"-->
                <div class="modal fade" id="addTaskModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="myLargeModalLabel">??????????????? ??????</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">		
                             <form id="taskFrm">						
                            	<div class="row">
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label for="addTask_task_name" class="form-label">?????????</label>
                                            <input type="text" class="form-control"  name="task_name" placeholder="????????????">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                         
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label for="addTask_task_content" class="form-label">??????</label>
                                            <textarea row="5" class="form-control" name="task_content" ></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="addTask_name" class="form-label">?????????</label>
                                            <select class="form-control" name="pno">
                                            	  <option value="">????????????</option>
                                            	 <c:forEach var="mem" items="${taskMember}">
                                                   <option value="${mem.pno }">${mem.name }</option>
                                                 </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="addTask_task_priority" class="form-label">?????????</label>
                                            <select class="form-control" name="task_priority">
                                            	<option value="High">High</option>
                                            	<option value="Medium">Medium</option>
                                            	<option value="Low">Low</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="addTask_startdte" class="form-label">?????????</label>
                                            <input readonly="readonly" disabled="disabled" type="date" class="form-control" id="startdte" name="startdte">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="addTask_enddte" class="form-label">?????????</label>
                                            <input type="date" class="form-control" name="enddte">
                                        </div>
                                    </div>
                                
                                </div>      
                               <div class="modal-footer"><%--data-bs-dismiss="modal" --%>
                                <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">??????</button>
                                <button type="button" class="btn btn-info waves-effect waves-light"  id="btnAddTask">??????</button>
                              </div>     
                                </form>
                            </div>
                     
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
                
                <!-- Success Alert Modal -->
              <div id="success-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                  <div class="modal-dialog modal-sm">
                      <div class="modal-content modal-filled bg-success">
                          <div class="modal-body p-4">
                              <div class="text-center">
                                  <i class="bx bx-check-double h1 text-white"></i>
                                  <h4 class="mt-2 text-white">Well Done!</h4>
                                  <p class="mt-3 text-white">????????? ?????? ???????????????!</p>
                                  <button type="button" class="btn btn-light my-2" data-bs-dismiss="modal">Continue</button>
                              </div>
                          </div>
                      </div><!-- /.modal-content -->
                  </div><!-- /.modal-dialog -->
              </div><!-- /.modal -->
              
                <!-- Footer Start -->
            <jsp:include page="footer.jsp"/>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->


        </div>
        <!-- END wrapper -->

        <!-- Right Sidebar -->
        <jsp:include page="right.jsp"></jsp:include>        
        <!-- /Right-bar -->
        
        <!-- Right bar overlay-->

        <!-- Vendor js -->
        <script src="${path}/Admin/dist/assets/js/vendor.min.js"></script>
        <!-- Footable js -->
        <script src="${path}/Admin/dist/assets/libs/footable/footable.all.min.js"></script>
        <!-- Init js -->
        <script src="${path}/Admin/dist/assets/js/pages/foo-tables.init.js"></script>
        <!-- App js -->
        <script src="${path}/Admin/dist/assets/js/app.min.js"></script>
    </body>
</html>