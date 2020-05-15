ROLLUP - ����׷� ���� - ����� �÷��� �����ʿ��� ���� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1.GROUP BY job, deptno
2.GROUP BY job
3.GROUP BY ==> ��ü

ROLLUP���� �����Ǵ� ����׷��� ���� - ROLLUP�� ����� �÷��� +1;
SELECT NVL(job,'�Ѱ�'), deptno, GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT job, deptno, SUM(sal),GROUPING(job), DECODE(GROUPING(job),1,'�Ѱ�')
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT DECODE(GROUPING(job),1,'��',0,job) job,
DECODE(GROUPING(job),1,'��',DECODE(GROUPING(deptno),1,'�Ұ�',0,deptno)) detpno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

ROLLUP ���� ����Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��
(***** ���� �׷��� ����� �÷��� ������ ���� ������ �����鼭 ����);
SELECT dept.dname, emp.job, SUM(sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job)
ORDER BY dname, job desc;

2. GROUPING SETS
ROLLUP�� ���� - ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�
                ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
                ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
                
GROUPING SETS - �����ڰ� ���� ������ ����׷��� ���
                ROLLUP�� �ٸ��� ���⼺�� ����
                
���� - GROUP BY GROUPING SETS (col1,col2)
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS (col1,col2)
GROUP BY GROUPING SETS (col2,col1)

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno)

�׷������
1. job, deptno
2. mgr;
SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS ((job, deptno),mgr);

3. CUBE
���� - GROUP BY CUBE(col1, col2...)
����� �÷��� ������ ��� ���� (������ ��Ų��)
GROUP BY CUBE (job, deptno);

1       2
job,    deptno
job,    x
x,      deptno
x,      x

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE (job,deptno);

�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

SELECT job, deptno, mgr, SUM(sal+NVL(comm,0)) sal
FROM emp
GROUP BY job, rollup(job,deptno), cube(mgr);

��ȣ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ� emp_test ���̺� ����
2. emp_test ���̺� dname �÷� �߰�(dept ���̺� ����)

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT*
FROM emp;
DESC dept;
ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;

3.subquery�� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ���� �ۼ�
emp_test�� dname  �÷��� ���� dept ���̺��� dname �÷����� update
emp_test ���̺��� deptno ���� Ȯ���ؼ� dept ���̺��� deptno ���̶� ��ġ�ϴ� dname �÷����� ������ update

emp_test���̺��� dname �÷��� dept ���̺��̿��ؼ� dname�� ��ȸ�Ͽ� ������Ʈ
update ����� �Ǵ� �� - 14 ==> WHERE ���� ������� ����

��������� ������� dname �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ
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

SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FORM emp
WHERE 1=2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����.

SELECT COUNT(*)
FORM emp
WHERE 1=2
GROUP BY deptno;