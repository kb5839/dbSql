DROP TABLE dept_test;

SELECT*
FROM dept;

CREATE TABLE dept_test AS
SELECT*
FROM dept;

INSERT INTO dept_test VALUES(99,'it1', 'daejeon');
INSERT INTO dept_test VALUES(98,'it2', 'daejeon');

SELECT*
FROM dept_test;

DELETE dept_test
WHERE NOT EXISTS ( 
SELECT 'X'
FROM emp
WHERE emp.deptno = dept_test.deptno);

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT*
FROM emp;

SELECT*
FROM emp_test;

UPDATE emp_test et
SET sal = sal+200
WHERE sal < 
(SELECT deptno,ROUND(AVG(sal),0)
FROM emp_test et1
WHERE et.deptno = et1.deptno
GROUP BY et.deptno);

공식용어는 아니지만, 검색-도서에 자주 나오는 표현
서브쿼리의 사용된 방법
1. 확인자 - 상호연관 서브쿼리 (EXISTS)
        => 메인 쿼리 부터 실행 => 서브 쿼리 실행
2. 공급자 - 서브쿼리가 먼저 실행되서 메인쿼리에 값을 공급 해주는 역할

SELECT*
FROM emp
WHERE mgr IN (SELECT empno FROM emp);
13건 - 매니저가 존재하는 직원을 조회

부서별 급여평균이 전체 급여평균보다 큰 부서의 부서번호,부서별 급여평균 구하기
부서별 급여평균
SELECT deptno,ROUND(AVG(sal),0)
FROM emp
GROUP BY deptno;
전체 급여평균
SELECT ROUND(AVG(sal),0)
FROM emp;

SELECT deptno,ROUND(AVG(sal),0)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),0) > (SELECT ROUND(AVG(sal),0)
                            FROM emp);

WITH절 - SQL에서 반복적으로 나오는 QUERY BLOCK(SUBQUERY)을 별도로 선언하여
SQL실행시 한번만 메모리에 로딩 후 반복적으로 사용할 때 메모리 공간의 데이터를
활용하여 속도 개선을 할 수 있는 KEYWORD
단, 하나의 SQL에서 반복적인 SQL블럭이 나오는 것은 잘못 작성한 SQL일 가능성이
높기때문에 다른 형태로 변경할 수 있는지를 검토 해보는 것을 추천

WITH emp_avg_sal AS(SELECT ROUND(AVG(sal),0)
                            FROM emp)
SELECT deptno,ROUND(AVG(sal),0)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),0) > (SELECT *
                            FROM emp_avg_sal);

CONNECT BY LEVEL - 행을 반복하고 싶은 수만큼 복제를 해주는 기능
위치 - FROM(WHERE)절 다음에 기술
DUAL 테이블과 많이 사용

테이블행에 행이 한건, 메모리에서 복제
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <=5;

5행 이상이 존재하는 테이블을 가지고 행을 제한
만약 복제할 데이터가 10000건이면 10000건에 대한 DISK I/O가 발생
SELECT ROWNUM
FROM emp
WHERE ROWNUM <=5;

1. 우리에게 주어진 문자열 년월 - 202005
    주어진 년월의 일수를 구하여 일수만 행을 생성

달력의 컬럼은 7개 - 컬럼의 기준은 요일 - 특정일자는 하나의 요일에 포함    
SELECT TO_DATE('2020/05','YYYY/MM') + (LEVEL -1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('2020/05','YYYY/MM')),'DD');

SELECT TO_DATE('2020/05','YY/MM')
FROM dual;

아래방식으로 SQL을 작성해도 쿼리를 완성하는게 가능하나
가독성 측면에서 너무 복잡하여 인라인뷰를 이용하여 쿼리를 좀더 단순하게 만든다.
SELECT TO_DATE('2020/05','YYYY/MM') + (LEVEL -1) dt,
DECODE (TO_CHAR(TO_DATE('2020/05','YYYY/MM') + (LEVEL -1),'D'),'1', TO_DATE('2020/05','YYYY/MM') + (LEVEL -1) 'SUN')
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('2020/05','YYYY/MM')),'DD');


SELECT 
               MIN(DECODE(d,1,dt)) sun, MIN(DECODE(d,2,dt)) mon, MIN(DECODE(d,3,dt)) tue,
               MIN(DECODE(d,4,dt)) wed, MIN(DECODE(d,5,dt)) thu, MIN(DECODE(d,6,dt)) fri, 
               MIN(DECODE(d,7,dt)) sat
FROM
(SELECT TO_DATE(:yyyymm,'YYYY/MM') + (LEVEL -1) dt,
    TO_CHAR(TO_DATE(:yyyymm,'YYYY/MM') + (LEVEL -1), 'D' ) d,
    TO_CHAR(TO_DATE(:yyyymm,'YYYY/MM') + (LEVEL -1), 'iw' ) iw
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYY/MM')),'DD'))
GROUP BY DECODE(d,1,iw+1,iw)
ORDER BY DECODE(d,1,iw+1,iw);

create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;



SELECT         NVL(MIN(DECODE(M,1,S)),0) jan, NVL(MIN(DECODE(M,2,S)),0) feb, NVL(MIN(DECODE(M,3,S)),0) mar,
               NVL(MIN(DECODE(M,4,S)),0) apr, NVL(MIN(DECODE(M,5,S)),0) may, NVL(MIN(DECODE(M,6,S)),0) jun
FROM
(SELECT TO_CHAR(DT,'MM')M, SUM(sales) S
FROM sales
GROUP BY TO_CHAR(DT,'MM'))


SELECT*
FROM sales

1일의 일요일은 몇일인가
마지막날의 토요일은 몇일인가?


