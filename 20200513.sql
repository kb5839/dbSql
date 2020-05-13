CREATE TABLE dept_test2 AS
SELECT*
FROM dept
WHERE 1=1;

1
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2(deptno);
CREATE INDEX idx_u_dept_test2_02 ON dept_test2(dname);
CREATE INDEX idx_u_dept_test2_03 ON dept_test2(deptno,dname);

2
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_u_dept_test2_02;
DROP INDEX idx_u_dept_test2_03;

3
CREATE UNIQUE INDEX idx_emp_test_01 ON emp (empno);
CREATE INDEX idx_emp_test_02 ON emp (deptno);
CREATE INDEX idx_emp_test_03 ON emp (ename);
x


실행계획
수업시간에 배운 조인 
Inner Join - 조인에 성공하는 데이터만 조회하는 조인 기법
Outer Join - 조인에 실패해도 기준이되는 테이블의 컬럼정보는 조회하는 조인 기법
Cross Join - 묻지마 조인(카티션 프러덕트), 조인 조건을 기술하지 않아 연결가능한 모든 경우의 수로 조인되는 기법
Self Join - 같은 테이블 끼리 조인 하는 형태

개발자가 DBMS에 SQL을 실행 요청 하면 DBMS는 SQL을 분석하여
어떻게 두 테이블을 연결할 지를 결정, 3가지 방식의 조인 방식(물리적 조인 방식, 기술적 이야기)
1.NESTED LOOP JOIN
2.SORT MERGE JOIN
3.HASH JOIN

OLTP(OnLine Transaction Processing) - 실시간 처리 => 응답이 빨라야 하는 시스템(일반적인 웹 서비스)
OLAP(OnLine Analysis Processing) - 일괄처리 => 전체 처리속도가 중요 한 경우(은행 이자 계산, 새벽 한버에 계산)


