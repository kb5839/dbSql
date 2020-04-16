SELECT * --모든 컬럼의 정보를 조회
FROM PROD; --데이터를 조회할 테이블 기술

--특정 컬럼에 대해서만 조회 : SELECT 컬럼1, 컬럼2....
--prod_id, prod_name컬럼만 prod 테이블에서 조회

SELECT prod_id, prod_name
FROM prod;

SELECT * 
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SQL 연산 : JAVA와는 다르게 대입X, 일반적 사직연산

SQL 데이터 타입 : 문자, 숫자, 날짜(date)

USERS 테이블이 (4/14 만들음) 존재
USERS 테이블의 모든데이터 조회

날짜 타입에 대한 연산 : 날짜는 +,- 연산 가능
date type + 정수 : date에서 정수날짜만큼 미래 날짜로 이동
date type - 정수 : date에서 정수날짜만큼 과거 날짜로 이동

SELECT userid, reg_dt + 5
FROM users;

컬럼 별칭 : 기존 컬럼명을 변경 하고 싶을때
syntax : 기존 컬럼명 [as] 별칭명칭
별칭명칭에 공백이 있으면 안되며, 공백이 표현되어야 할 경우 더블 쿼테이션으로 묶는다
또한 오라클에서는 객체명을 대문자 처리 하기 때문에 소문자로 별칭을 지정하기 위해서도 더블 쿼테이션을 사용한다.

SELECT userid id1
FROM users;

SELECT prod_id id, prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;

문자열 연산;
SELECT userid || 'test', reg_dt
FROM users;

SELECT userid||usernm
FROM users;

user_tables : oracle에서 관리하는 테이블 정보를 담고 있는 테이블(view) ==> data dictionary
SELECT *
FROM user_tables;

SELECT 'SELECT * FROM ' ||table_name|| ';' query 
FROM user_tables;

테이블의 구성 컬럼을 확인
1.tool(sql developer)을 통해 확인
    테이블 - 확인하고자 하는 테이블
2.SELECT *
    FROM 테이블
    일단 전체 조회 ==> 모든 컬럼이 표시
3.DESC 테이블명
4.data dictionary : user_tab_columns

DESC emp;

SELECT *
FROM user_tab_columns;

지금까지 배운 SELECT 구문
조회하고자 하는 컬럼 기술 : SELECT
조회하고자 하는 테이블 기술 : FROM
조회할 행을 제한하는 조건을 기술 : WHERE
WHERE 절에 기술한 조건이 참(TRUE)일 때 결과를 조회

java의 비교 연산 : a변수와 b변수의 값이 같은지 비교 ==
sql의 비교 연산 : =
int a =5;
int b =2;
if(a == b)

SELECT *
FROM users
WHERE userid = 'con';

emp테이블의 컬럼과 데이터 타입을 확인;

SELECT *
FROM EMP;

emp : employee
empno : 사원번호
ename : 사원이름
job : 담당업무(직책)
mgr : 담당자(관리자)
hiredate : 입사일
sal : 급여
comm : 성과급
deptno : 부서번호

SELECT *
FROM dept;

emp 테이블에서 직원이 속한 부서번호가 30번 보다 큰(>) 부서에 속한 직원을 조회;

SELECT *
FROM emp
WHERE deptno > 30;

!= 다를때
users 테이블에서 사용자 아이디가(userid)가 brown이 아닌 사용자를 조회
SELECT *
FROM users
WHERE userid != 'brown';

SQL리터럴
숫자 ; ...20,30.5
문자 : 싱글 쿼테이션 : 'Hello world'
날짜 : TO_DATE('날짜문자열', '날짜 문자열의 형식')

SELECT *
FROM emp
WHERE hiredate <= TO_DATE('19820101', 'YYYYMMDD'); 