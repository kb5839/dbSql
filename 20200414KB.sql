--한줄 주석
/* 여러줄 주석 */
SELECT * --모든 컬럼의 정보를 조회
FROM PROD; --PROD 테이블에서

SQL 실행방법
1. 실행하려는 SQL을 선택하여(SHIFT) CNTL + ENTER
2. 실행하려는 SQL문장 아무곳에서나 프롬프트를 위치시키고 CNTL + ENTER
* 단 위아래 다른 SQL 문장이 있을 경우 ;에 의해 SQL이 구분되지 못할경우 실행되지 못함

1.워킹 디렉토리 -> 로컬 저장소 생성(git init)
2.20200414.sql
3.로컬 저장소에 반영(add, commit)
4.원격 저장소 생성(github에 생성dbSql)
5.로컬 저장소 - 원격 저장소 연결
git add remote origin 4번에서 생성한 원격 저장소 주소
6.로컬 저장소에 commit 된 내역을 원격저장소로 반영(push)
git push -u origin master
