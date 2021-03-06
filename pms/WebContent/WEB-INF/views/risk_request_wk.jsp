<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.util.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
<fmt:requestEncoding value="UTF-8" /> 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<c:if test="${mem.auth == 'ceo' }"><title>최고경영자</title></c:if>
	<c:if test="${mem.auth == 'hp' }"><title>인사담당자</title></c:if>
	<c:if test="${mem.auth == 'pm' }"><title>프로젝트 매니저</title></c:if>
	<c:if test="${mem.auth == 'wk' }"><title>개발자</title></c:if>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
	<meta content="Coderthemes" name="author" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >	
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
	
	<script src="${path}/a00_com/jquery-ui.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){

		$('.risk_item').on("click", function(){
			console.log($(this).children().eq(8).children().val());	//배열에서 8번째 값의 안에 있는 input의 value값을 가져온다.
 			var risk_no = $(this).children().eq(8).children().val();
 			var no = $(this).children().eq(6).children().val();
			console.log($(this).children().eq(6).children().val());	//배열에서 6번째 값의 안에 있는 input의 value값을 가져온다.
 			$('[name=risk_no]').val(risk_no);
 			$('[name=risk_writer]').val("${mem.name}");
 			$('[name=no]').val(${ra.project_no});
 			
 			
 			location.href="${path}/risk.do?method=riskDetail&no="+no+"&risk_no="+risk_no;
 			//$('#detail_form').submit();
		})
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
					</div>

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box page-title-box-alt">
                                    <h4 class="page-title">리스크</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="${path}/main.do?method=main">메인</a></li>
                                            <li class="breadcrumb-item active">리스크 요청</li>
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
                            			<c:if test="${mem.auth == 'wk' || mem.auth == 'pm'}">
                                        <div class="row mb-2">
                                            <div class="col-sm-6">
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="float-sm-end">
                                                    <button type="button" class="btn btn-success mb-2 mb-sm-0"><i class="mdi mdi-cog"></i></button>
                                                </div>
                                            </div><!-- end col-->
                                        </div>
                          				</c:if>
                                        <!-- end row -->
                
                                        <div class="table-responsive">
                                            <form id="detail_form" method="post">
                                            <input type="hidden" value="" name="risk_no">
                                            <table class="table table-centered w-100 dt-responsive nowrap" id="products-datatable" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th class="all" style="width: 20px;">
                                                            <div class="form-check mb-0 font-16">
                                                                <input class="form-check-input" type="checkbox" id="productlistCheck">
                                                                <label class="form-check-label" for="productlistCheck">&nbsp;</label>
                                                            </div>
                                                        </th>
                                                        <th class="all">번호</th><th>제목</th><th>내용</th><th>리스크 카테고리</th>
                                                        <th>리스크 상태</th><th>프로젝트</th><th>작성자</th><th>등록일</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach var="ra" items="${riskrequestwk}">
                                                    <tr class="risk_item">
                                                        <td>
                                                            <div class="form-check mb-0 font-16">
                                                                <input class="form-check-input" type="checkbox" id="productlistCheck1">
                                                                <label class="form-check-label" for="productlistCheck1">&nbsp;</label>
                                                            </div>
                                                        </td>
                                                        <td>${ra.rnum}</td>
                                                        <td><h5 class="m-0 d-inline-block align-middle">${ra.risk_title}</h5></td>
                                                        <td><div>${fn:substring(ra.risk_content, 0, 10)}...</div></td>
                                                        <td>[${ra.risk_category}]</td>
                                                        <td>${ra.risk_status}</td>
                                                        <td>${ra.project_name}<input type="hidden" value="${ra.project_no}"></td>
                                                        <td><div>${mem.name}</div></td>
                                                        <td><fmt:formatDate value="${ra.regdte}"/><input type="hidden" value="${ra.risk_no}"></td>
                                                    </tr>
                                              		</c:forEach>
                                                    <!-- 복붙해야할부분 -->
                                                </tbody>
                                            </table>
                                    		</form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end row -->
                    </div> <!-- container -->
                </div> <!-- content -->
                <!-- Footer Start -->
                <jsp:include page="footer.jsp"/>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->


        </div>
        <!-- END wrapper -->

        <jsp:include page="right.jsp"></jsp:include>
        
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