EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7369;
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    87 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    87 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

ROWID - ���̺� ���� ����� �����ּ� (java - �ν��Ͻ� ����/ c - ������)

SELECT ROWID, emp.*
FROM emp;

����ڿ� ���� ROWID ���
EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE ROWID = 'AAAE5xAAFAAAAEVAAA';
| Id  | Operation                  | Name | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT           |      |     1 |    99 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY USER ROWID| EMP  |     1 |    99 |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------

INDEX �ǽ�
emp���̺� ���� ������ pk_emp PRIMARY KEY �������� ����

ALTER TABLE emp DROP CONSTRAINT pk_emp;

�ε��� ���� empno ���� �̿��Ͽ� ������ ��ȸ
EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7782)


2.emp ���̺� empno �÷����� PRIMARY KEY �������� ���� �� ���
(empno�÷����� ������ unique �ε����� ����)

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
| Id  | Operation                   | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |        |     1 |    87 |     1   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP    |     1 |    87 |     1   (0)| 00:00:01 |
|*  2 |   INDEX UNIQUE SCAN         | PK_EMP |     1 |       |     0   (0)| 00:00:01 |
--------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
   

3.2��SQL�� ����   

2��
SELECT*
FROM emp
WHERE empno = 7782;

3��
EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

| Id  | Operation         | Name   | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |        |     1 |    13 |     0   (0)| 00:00:01 |
|*  1 |  INDEX UNIQUE SCAN| PK_EMP |     1 |    13 |     0   (0)| 00:00:01 |
----------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - access("EMPNO"=7782)
   
4. emptno �÷��� non-unique �ε����� �����Ǿ� �ִ� ���
ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    87 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    87 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_01 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("EMPNO"=7782)
 

5. emp ���̺��� job ���� ��ġ�ϴ� �����͸� ã�� ������
�����ε���
idx_emp_01 - empno

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     3 |   261 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     3 |   261 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("JOB"='MANAGER')
   
idx_emp_01�� ��� ������ empno�÷� �������� �Ǿ� �ֱ� ������ job �÷��� �����ϴ�
SQL������ ȿ�������� ����� �� ���� ������ TABLE ��ü �����ϴ� ������ �����ȹ�� ������

==> idx_emp_02 (job) ������ ���� �����ȹ ��
CREATE INDEX idx_emp_02 ON emp (job);

6. emp ���̺��� job = 'MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ
�ε��� ��Ȳ
idx_emp_01 - empno
idx_emp_02 - job

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';


SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
   
   
7. emp ���̺��� job = 'MANAGER' �̸鼭 ename �� C�� �����ϴ� ����� ��ȸ
�� ���ο� �ε��� �߰� - idx_emp_03 - job, ename
CREATE INDEX idx_emp_03 ON emp (job, ename);
�ε��� ��Ȳ
idx_emp_01 - empno
idx_emp_02 - job   
idx_emp_03 - job, ename

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';


SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    87 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    87 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_03 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("JOB"='MANAGER' AND "ENAME" LIKE 'C%')
       filter("ENAME" LIKE 'C%')
       
8. emp���̺��� job = 'MANAGER' �̸鼭 ename �� C�� ������ ����� ��ȸ
�ε��� ��Ȳ
idx_emp_01 - empno
idx_emp_02 - job   
idx_emp_03 - job, ename

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE '%C';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

RULE BASED OPTIMIZER - ��Ģ��� ����ȭ��(����Ŭ ���� 9i) -> ����ī�޶�
COST BASED OPTIMIZER - ����� ����ȭ��(����Ŭ ���� 10g) -> �ڵ�ī�޶�

9. ���� �÷� �ε����� �÷� ������ �߿伺
�ε��� ���� �÷� - (job, ename) vs (ename, job)
*** �����ؾ� �ϴ� sql�� ���� �ε��� �÷� ������ �����ؾ� �Ѵ�

���� sql - job = manager, ename�� c�� �����ϴ� ��� ������ ��ȸ
���� �ε��� ����
DROP INDEX idx_emp_03;
CREATE INDEX idx_emp_04 ON emp (ename, job);
�ε��� ��Ȳ
idx_emp_01 - empno
idx_emp_02 - job   
idx_emp_03 - job, ename
idx_emp_04 - ename, job

EXPLAIN PLAN FOR
SELECT*
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

| Id  | Operation                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT            |            |     1 |    87 |     2   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID| EMP        |     1 |    87 |     2   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN          | IDX_EMP_04 |     1 |       |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("ENAME" LIKE 'C%' AND "JOB"='MANAGER')
       filter("JOB"='MANAGER' AND "ENAME" LIKE 'C%')

���ο����� �ε���
idx_emp_01 ����(pk_emp �ߺ�)
DROP INDEX idx_emp_01;

emp ���̿� empno �÷��� PRIMARY KEY�� ������� ����
pk_emp - empno
ALTER TABLE emp ADD CONSTRINT pk_PRIMARY KEY (empno);

�ε��� ��Ȳ
pk_emp - empno
idx_emp_02 - job   
idx_emp_04 - ename, job

EXPLAIN PLAN FOR
SELECT*
FROM emp,dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

NESTED LOOP JOIN
HASH JOIN
SORT MERGE JOIN

