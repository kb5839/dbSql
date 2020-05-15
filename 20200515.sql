ROLLUP - 서브그룹 생성 - 기술된 컬럼을 오른쪽에서 부터 지워나가며 GROUP BY를 실행

아래 쿼리의 서브그룹
1.GROUP BY job, deptno
2.GROUP BY job
3.GROUP BY ==> 전체

ROLLUP사용시 생성되는 서브그룹의 수는 - ROLLUP에 기술한 컬럼수 +1;
SELECT NVL(job,'총계'), deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT job, deptno, SUM(sal),GROUPING(job), DECODE(GROUPING(job),1,'총계')
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT DECODE(GROUPING(job),1,'총',0,job) job,
DECODE(GROUPING(job),1,'계',DECODE(GROUPING(deptno),1,'소계',0,deptno)) detpno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

ROLLUP 절에 기술되는 컬럼의 순서는 조회 결과에 영향을 미친다
(***** 서브 그룹을 기술된 컬럼의 오른쪽 부터 제거해 나가면서 생성);
SELECT dept.dname, emp.job, SUM(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job)
ORDER BY dname, job desc;

2. GROUPING SETS
ROLLUP의 단점 - 관심없는 서브그룹도 생성 해야한다
                ROLLUP절에 기술한 컬럼을 오른쪽에서 지워나가기 때문에
                만약 중간과정에 있는 서브그룹이 불필요 할 경우 낭비.
                
GROUPING SETS - 개발자가 직접 생성할 서브그룹을 명시
                ROLLUP과 다르게 방향성이 없다
                
사용법 - GROUP BY GROUPING SETS (col1,col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col1,col2)
GROUP BY GROUPING SETS (col2,col1)

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno)

그룹기준을
1. job, deptno
2. mgr;
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno),mgr);

3. CUBE
사용법 - GROUP BY CUBE(col1, col2...)
기술된 컬럼의 가능한 모든 조합 (순서는 지킨다)
GROUP BY CUBE (job, deptno);

1       2
job,    deptno
job,    x
x,      deptno
x,      x

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job,deptno);

여러개의 REPORT GROUP 사용하기
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

SELECT job, deptno, mgr, SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY job, rollup(job,deptno), cube(mgr);

상호연관 서브쿼리 업데이트
1. emp테이블을 이용하여 emp_test 테이블 생성
2. emp_test 테이블에 dname 컬럼 추가(dept 테이블 참고)

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT*
FROM emp;
DESC dept;
ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;

3.subquery를 이용하여 emp_test 테이블에 추가된 dname 컬럼을 업데이트 해주는 쿼리 작성
emp_test의 dname  컬럼의 값을 dept 테이블의 dname 컬럼으로 update
emp_test 테이블의 deptno 값을 확인해서 dept 테이블의 deptno 값이랑 일치하는 dname 컬럼값을 가져와 update

emp_test테이블의 dname 컬럼을 dept 테이블이용해서 dname값 조회하여 업데이트
update 대상이 되는 행 - 14 ==> WHERE 절을 기술하지 않음

모든직원을 대상으로 dname 컬럼을 dept 테이블에서 조회하여 업데이트
UPDATE emp_test 
SET dname = (SELECT dname FORM dept
WHERE emp_test.deptno = dept.deptno)

CREATE TABLE dept_test AS
SELECT*
FROM dept;

DROP TABLE dept_test;

ALTER TABLE dept_test ADD (empcnt NUMBER);

DESC dept_test;

UPDATE dept_test
SET empcnt = (SELECT COUNT(*)
                FROM emp
                WHERE emp.deptno = dept_test.deptno);
                
UPDATE dept_test
SET empcnt = (SELECT COUNT(*)
                FROM emp
                WHERE emp.deptno = dept_test.deptno
                GROUP BY deptno);
                
SELECT*
FROM dept_test;

SELECT 결과 전체를 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴

SELECT COUNT(*)
FORM emp
WHERE 1=2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을 경우 조회되는 행이 없다.

SELECT COUNT(*)
FORM emp
WHERE 1=2
GROUP BY deptno;