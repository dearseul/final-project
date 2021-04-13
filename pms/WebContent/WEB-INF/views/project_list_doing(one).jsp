<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>   
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<fmt:requestEncoding value="UTF-8" /> 
<!DOCTYPE html>
<html>
<head>
        <meta charset="utf-8" />
        <title>Project List(개인_진행)</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="${path}/Admin/dist/assets/images/favicon.ico">

        <!-- third party css -->
        <link href="${path}/Admin/dist/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="${path}/Admin/dist/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />

		<!-- App css -->
		<link href="${path}/Admin/dist/assets/css/modern/bootstrap-modern.min.css" rel="stylesheet" type="text/css" id="bs-default-stylesheet" />
		<link href="${path}/Admin/dist/assets/css/modern/app-modern.min.css" rel="stylesheet" type="text/css" id="app-default-stylesheet" />

		<link href="${path}/Admin/dist/assets/css/modern/bootstrap-modern-dark.min.css" rel="stylesheet" type="text/css" id="bs-dark-stylesheet" />
		<link href="${path}/Admin/dist/assets/css/modern/app-modern-dark.min.css" rel="stylesheet" type="text/css" id="app-dark-stylesheet" />

		<!-- icons -->
		<link href="${path}/Admin/dist/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
	<script src="${path}/a00_com/jquery.min.js"></script>
	<script src="${path}/a00_com/popper.min.js"></script>
	<script src="${path}/a00_com/bootstrap.min.js"></script>
	<script src="${path}/a00_com/jquery-ui.js"></script>		
<script type="text/javascript">
	$(document).ready(function(){
		
		$("#insertProject").click(function(){
			var sch = ProV();
			console.log("##등록할 데이터 확인 ##");
			console.log(sch);
			$.ajax({
				type:"post",
				url:"project.do?method=project_insert",
				data: sch,
				dataType: "json",
				success:function(data){
					if(data.success=="Y"){
						console.log(data);
						alert("등록 성공");
						$("#closeBtn").click();
						location.href="${path}/project.do?method=project_list";
					}
				},
				error:function(err){
					alert("에러발생: "+err);
					console.log(err);
				}
			});
			
		});
		
		<%--(project_no_seq.nextval, #{project_name},#{project_content},#{start1},#{end1},#{pm_pno}, #{project_status}) --%>
		
		function ProV(){
			var sch = {};
			sch.project_name = $("#project_name").val();
			sch.project_content = $("#project_content").val();
			sch.start1 = $("#start1").val();
			sch.end1 = $("#end1").val();
			sch.pm_pno = $("#pm_pno").val();
			sch.project_status = $("#project_status").val();
			return sch;
		}
	
});

</script>
    </head>

<body class="loading" data-layout-mode="detached" data-layout='{"mode": "light", "width": "fluid", "menuPosition": "fixed", "sidebar": { "color": "light", "size": "default", "showuser": true}, "topbar": {"color": "dark"}, "showRightSidebarOnPageLoad": true}'>

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Topbar Start -->
            <jsp:include page="top.jsp"/>
            <!-- end Topbar -->

            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="side.jsp" flush="false"/>
            <!-- Left Sidebar End -->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">
                        
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box page-title-box-alt">
                                    <h4 class="page-title">프로젝트 리스트</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Main</a></li>
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Project</a></li>
                                            <li class="breadcrumb-item active">Project List</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>     
                        <!-- end page title --> 

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-body">
                                    <!-- 
                                        <div class="row mb-2">
                                            <div class="col-sm-6">
                                            <!-- 멤버의 권한이 pm 일때만 프로젝트 추가 버튼 활성화 --
                                            <c:if test="${mem.auth == 'pm'}">
                                                <a href="${path}/project.do?method=project_insert_form" class="btn btn-danger mb-2"><i class="mdi mdi-plus-circle me-1"></i>프로젝트 추가</a>
                                            </c:if>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="float-sm-end">
                                                    
                                                    <button type="button" class="btn btn-success mb-2 mb-sm-0"><i class="mdi mdi-cog"></i></button>
                                                    
                                                </div>
                                            </div><!-- end col--
                                        </div>
                                        <!-- end row --
									 -->	
										<form:form modelAttribute="sch2" method="post">

                                        </form:form>
                                        
                                        <form:form method="post" action="${path }/taskdetail.do?method=updateSub">
										<!-- 프로젝트 추가 Modal 창 시작-->
											<!-- 모달창 버튼 시작 -->
											<c:if test="${mem.auth == 'pm'}"><!-- 권한이 PM인 사람만 추가버튼 가능 -->
											<div class="button-list">
	                                            <!-- 프로젝트 추가 모달 버튼 -->
	                                            
	                                            <button type="button" class="btn btn-success waves-effect waves-light" data-bs-toggle="modal" data-bs-target="#con-close-modal">프로젝트 추가</button>
	                                            
	                                        </div>
	                                        </c:if>
											<!-- 모달창 버튼 끝 -->
										<!-- sample modal content -->
    
                                        <div id="con-close-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">프로젝트 추가</h4>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body p-4">
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label for="a" class="form-label">프로젝트번호</label>
                                                                    <input type="text" class="form-control" id="a" placeholder="시퀀스로자동생성" readonly>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label for="project_name" class="form-label">프로젝트명</label>
                                                                    <input type="text" class="form-control" id="project_name" placeholder="프로젝트명">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="mb-3 no-margin">
                                                                    <label for="project_content" class="form-label">프로젝트내용</label>
                                                                    <textarea class="form-control" id="project_content" placeholder="프로젝트내용"></textarea>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label for="start1" class="form-label">시작일</label>
                                                                    <input type="text" class="form-control" id="start1" placeholder="Date">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label for="end1" class="form-label">종료일</label>
                                                                    <input type="text" class="form-control" id="end1" placeholder="Date">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label for="pm_pno" class="form-label">PM번호</label>
                                                                    <input type="text" class="form-control" id="pm_pno" placeholder="">
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="mb-3">
                                                                    <label for="project_status" class="form-label">프로젝트상태</label>
                                                                    <input type="text" class="form-control" id="project_status" placeholder="">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary waves-effect" id="closeBtn" data-bs-dismiss="modal">닫기</button>
                                                        <button type="button" class="btn btn-info waves-effect waves-light" id="insertProject">프로젝트 추가</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><!-- /.modal -->
										</form:form>
										<!-- 프로젝트 추가 Modal 창 끝 -->
										                
                                        <div class="table-responsive">
                                            <table class="table table-centered w-100 dt-responsive nowrap" 
                                            	id="products-datatable" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                            	
                                            	
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="all" style="width: 20px;">
                                                            <div class="form-check font-16 mb-0">
                                                                <input class="form-check-input" type="checkbox" id="productlistCheck">
                                                                <label class="form-check-label" for="productlistCheck">&nbsp;</label>
                                                            </div>
                                                        </th>
                                                        <th class="all">프로젝트명</th>
                                                        <th>프로젝트번호</th>
                                                        <th>프로젝트내용</th>
                                                        <th>시작일</th>
                                                        <th>종료일</th>
                                                        <th>담당PM</th>
                                                        <th>현재상태</th>
                                                        <th style="width: 85px;">Action</th>
                                                    </tr>
                                                </thead>
                                                <!-- ---------------------------------------------------- -->
                                                <!-- 테이블 몸통 시작(데이터베이스에 있는 목록 출력) -->
                                                <!-- ---------------------------------------------------- -->
                                                <tbody>
                                                
                                                	<c:forEach var="bd" items="${plist}">
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-16 mb-0">
                                                                <input class="form-check-input" type="checkbox" id="productlistCheck1">
                                                                <label class="form-check-label" for="productlistCheck1">&nbsp;</label>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <h5 class="m-0 d-inline-block align-middle"><a href="${path}/project.do?method=project_detail&no=${bd.project_no}" class="text-dark">${bd.project_name}</a></h5>
                                                        </td>
                                                        <td>
                                                            ${bd.project_no}
                                                        </td>
                                                        <td>
                                                            ${bd.project_content}
                                                        </td>
                                                        <td>
                                                            ${bd.start1}
                                                        </td>
                                                        <td>
                                                            ${bd.end1}
                                                        </td>
                                                        <td>
                                                            ${bd.pm_pno}
                                                        </td>
                                                        <td>
                                                        	<c:choose>
                                                            <c:when test="${bd.project_status == '완료'}">
                                                            	<span class="badge badge-soft-success">
                                                            </c:when>
                                                            <c:otherwise>
                                                            	<span class="badge badge-soft-danger">
                                                            </c:otherwise>
                                                            </c:choose>${bd.project_status}</span>
                                                        </td>
                    
                                                        <td>
                                                            <ul class="list-inline table-action m-0">
                                                                <li class="list-inline-item"> 
                                                                    <a href="javascript:void(0);" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                                                </li>
                                                                <li class="list-inline-item"> 
                                                                    <a href="javascript:void(0);" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                                                </li>
                                                                <li class="list-inline-item"> 
                                                                    <a href="javascript:void(0);" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                                                </li>
                                                            </ul>
                                                        </td>
                                                    </tr>
													</c:forEach>
                                                    

                                                </tbody>
                                            	<!-- ---------------------------------------------------- -->
                                                <!-- 테이블 몸통 끝-->
                                                <!-- ---------------------------------------------------- -->
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->

                        
                    </div> <!-- container -->
					
                </div> <!-- content -->

                <!-- Footer Start -->
                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6">
                                <script>document.write(new Date().getFullYear())</script> &copy; Minton theme by <a href="">Coderthemes</a> 
                            </div>
                            <div class="col-md-6">
                                <div class="text-md-end footer-links d-none d-sm-block">
                                    <a href="javascript:void(0);">About Us</a>
                                    <a href="javascript:void(0);">Help</a>
                                    <a href="javascript:void(0);">Contact Us</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- end Footer -->

            </div>
            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <!-- Right Sidebar -->
        <jsp:include page="right.jsp" flush="false"/>
        <!-- /Right-bar -->

        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>

        <!-- Vendor js -->
        <script src="${path}/Admin/dist/assets/js/vendor.min.js"></script>

        <!-- third party js -->
        <script src="${path}/Admin/dist/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
        <script src="${path}/Admin/dist/assets/libs/jquery-datatables-checkboxes/js/dataTables.checkboxes.min.js"></script>
        <!-- third party js ends -->

        <script src="${path}/Admin/dist/assets/js/pages/product-list.init.js"></script>

        <!-- App js -->
        <script src="${path}/Admin/dist/assets/js/app.min.js"></script>
        
    </body>
</html>