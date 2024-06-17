package com.javalab.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 게시물 자바 빈즈 클래스
 */

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@ToString

public class BoardVO implements Serializable {

   private static final long serialVersionUID = 1L;

   private int bno;          // 게시물 번호
   private String title;       // 게시물 제목
   private String content;      // 게시물 내용
   private String memberId;   // 게시물 작성자 ID
   private Date regDate;      // 게시물 작성일자
   private int hitNo;  // 조회수 증가
}
