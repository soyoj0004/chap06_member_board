<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.sql.*, com.javalab.vo.*" %>

<!-- 컨텍스트패스(진입점폴더) 변수 설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<%
	// 로그인폼에서 파라미터 전달
	String memberId = request.getParameter("memberId");
	String password = request.getParameter("password");
    
	// 데이터베이스의 드라이버 로딩 문자열
	String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	// 데이터베이스 연결 문자열
	String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	String DB_USER = "mboard";
	String DB_PASSWORD = "1234";

	Connection conn = null; // 커넥션 객체
    PreparedStatement pstmt = null; // 쿼리문 생성 및 실행 객체
    ResultSet rs = null; // 쿼리 실행 결과 반환 객체
    
    boolean loginSuccess = false; // 로그인 성공 여부 판별 플래그
    MemberVO member = null;
    
    try {
    	Class.forName(JDBC_DRIVER); // jdbc 드라이버 로딩
    	conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); // 커넥션 객체 획득
    	
    	String sql = "SELECT member_id , name, email FROM member WHERE member_id = ? AND password = ?";
    	pstmt = conn.prepareStatement(sql); // PreparedStatement 객체 얻기(쿼리문 전달)
    	pstmt.setString(1, memberId); 	// 첫번쨰 ? 표에 파라미터 세팅
    	pstmt.setString(2, password); 	// 두번쨰 ? 표에 파라미터 세팅
    			
    	rs = pstmt.executeQuery(); 		// 쿼리문 실행해서 결과 전달 받기
    	
    	if (rs.next()) { // 결과가 있으면 즉, 로그인 성공
    		loginSuccess = true; // 로그인 성공 여부 플래그를 true로 설정
    		
    		member = new MemberVO(); // 자바빈즈 객체 생성 -> 생성된 객체를 세션에 보관
    		member.setMemberId(rs.getString("member_id")); // 자바빈즈에 데이터베이스 조회 값 세팅
    		member.setName(rs.getString("name"));
    		member.setEmail(rs.getString("email"));
    		
    		// 세션에 사용자 저장
    		HttpSession ses = request.getSession();
    		ses.setAttribute("member", member);
    	}
    } catch (Exception e) {
    	e.printStackTrace();
    } finally {
    	try {
    		if (rs != null) rs.close();
    		if (pstmt != null) pstmt.close();
    		if (conn != null) conn.close();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
    String contextPath = request.getContextPath(); // 컨텍스트패스 얻기
    
    if (loginSuccess) {
    	// sendRedirect() : 사용자로 하여금 새로운 페이지로 이동하도록 지시
    	// 이떄는 외부에서 들어오는 새로운 요청으로 컨텍스트패스 필요
    	// "/" 루트 : 컨텍스트패스(웹루트) 경로에서 index.jsp페이지를 찾겠다.
    	response.sendRedirect(contextPath + "/index.jsp"); // index.jsp 페이지로 이동
    } else {
    	// out 객체는 jsp에서 기본으로 제공하는 객체로 웹브라우저에 직접 출력하는 기능 
    	out.println("<script>");
    	out.println("alert('아이디와 비밀번호를 확인하세요');");
    	out.println("history.back();"); // 다시 이전페이지(로그인 페이지)로 이동
    	out.println("<script>");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginProcess.jsp</title>
</head>
<body>

</body>
</html>