<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
   // 게시물 목록 저장용 ArrayList 생성
   List<BoardVO> boardList = new ArrayList<>();
    
    // 데이터베이스 드라이버 로딩 문자열 
    String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    // 데이터베이스 연결 문자열
    String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    String DB_USER = "mboard";
    String DB_PASSWORD = "1234";
    
    Connection conn = null;   // 커넥션 객체
    PreparedStatement pstmt = null;   // 쿼리문 생성 및 실행 객체
    ResultSet rs = null;   // 쿼리 실행 결과 반환 객체
    
    try {
        Class.forName(JDBC_DRIVER);   // jdbc 드라이버 로딩
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); // 커넥션 객체 획득
        
        
        
        String sql = "select bno, title, member_id, reg_date , HIT_NO  from board " ;    
        pstmt = conn.prepareStatement(sql);   // PreparedStatement 객체 얻기(쿼리문 전달)
        rs = pstmt.executeQuery(); // 게시물 목록 반환
        
      while(rs.next()){
         BoardVO board = new BoardVO();
         board.setBno(rs.getInt("bno"));
         board.setTitle(rs.getString("title"));
         board.setMemberId(rs.getString("member_id"));
         board.setRegDate(rs.getDate("reg_Date"));
         board.setHitNo(rs.getInt("HIT_NO"));
         boardList.add(board); // 게시물 목록에 추가
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
    
    // 게시물목록을 현재 페이지 객체에 저장
    pageContext.setAttribute("boardList", boardList);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
</head>
   <body>
   <table border="1">
      <tr>
         <th>게시물</th>
         <th>제목</th>
         <th>작성자</th>
         <th>작성일자</th>
         <th>조회수</th>
      </tr>
      <c:forEach var="board" items="${boardList }">
         <tr>
            <td>${board.bno }</td>
            <td><a href="${contextPath }/boardDetail.jsp?bno=${board.bno}"> ${board.title }</a></td>
            <td>${board.memberId }</td>
            <td>${board.regDate }</td>
            <td>${board.hitNo }</td>
         </tr>      
      </c:forEach>
   </table>
   <br>
   <a href="${contextPath }/boardInsertForm.jsp">게시물 작성</a>
   
</body>
</html>   
