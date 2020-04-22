SELECT '201912' PARAM , LAST_DAY(TO_DATE('19/12','YYYY/MM')) DT
FROM dual;


문자열 ==>  날짜 ==> 마지막 날짜로 변경 ==> 일자

SELECT TO_DATE('201912','YYYYMM') PARAM,
      --LAST_DAY(TO_DATE('19/12','YYYY/MM')),
     TO_CHAR(LAST_DAY(TO_DATE('2019/12','YYYY/MM')),'DD') DT
FROM dual;

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7369;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);


Plan hash value : 3956160932

실행계획을 보는 순서(id)
* 들여쓰기 되어있으면 자식 오퍼레이션
1. 위에서 아래로
    *단 자식 오퍼레이션이 있으면 자식부터 읽는다.
  1 ==> 0 순서로 읽는다   
---------------------
-----------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = 7369;

SELECT * 
FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7300 + '69';

SELECT*
FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT ename, sal,TO_CHAR(sal, 'L009,999.00')
FROM emp;

NULL과 관련된 함수
NVL
NVL2
NULLIF
COALESCE

왜 null 처리를 해야할까?
NULL에 대한 연산결과는 NULL이다

ex) emp 테이블에 존재하는 sal,comm 두개의 컬럼 값을 합한 값을 알고 싶어 다음과 같이 SQL 작성
SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr1이 null이면 expr2값을 리턴하고
expr1이 null이 아니면 expr1을 리턴

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) sal_plus_comm
FROM emp;

RED_DT 컬럼이 NULL일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, reg_dt 
FROM users;
