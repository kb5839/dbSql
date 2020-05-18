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

���Ŀ��� �ƴ�����, �˻�-������ ���� ������ ǥ��
���������� ���� ���
1. Ȯ���� - ��ȣ���� �������� (EXISTS)
        => ���� ���� ���� ���� => ���� ���� ����
2. ������ - ���������� ���� ����Ǽ� ���������� ���� ���� ���ִ� ����

SELECT*
FROM emp
WHERE mgr IN (SELECT empno FROM emp);
13�� - �Ŵ����� �����ϴ� ������ ��ȸ

�μ��� �޿������ ��ü �޿���պ��� ū �μ��� �μ���ȣ,�μ��� �޿���� ���ϱ�
�μ��� �޿����
SELECT deptno,ROUND(AVG(sal),0)
FROM emp
GROUP BY deptno;
��ü �޿����
SELECT ROUND(AVG(sal),0)
FROM emp;

SELECT deptno,ROUND(AVG(sal),0)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),0) > (SELECT ROUND(AVG(sal),0)
                            FROM emp);

WITH�� - SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ�
SQL����� �ѹ��� �޸𸮿� �ε� �� �ݺ������� ����� �� �޸� ������ �����͸�
Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD
��, �ϳ��� SQL���� �ݺ����� SQL���� ������ ���� �߸� �ۼ��� SQL�� ���ɼ���
���⶧���� �ٸ� ���·� ������ �� �ִ����� ���� �غ��� ���� ��õ

WITH emp_avg_sal AS(SELECT ROUND(AVG(sal),0)
                            FROM emp)
SELECT deptno,ROUND(AVG(sal),0)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal),0) > (SELECT *
                            FROM emp_avg_sal);

CONNECT BY LEVEL - ���� �ݺ��ϰ� ���� ����ŭ ������ ���ִ� ���
��ġ - FROM(WHERE)�� ������ ���
DUAL ���̺�� ���� ���

���̺��࿡ ���� �Ѱ�, �޸𸮿��� ����
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <=5;

5�� �̻��� �����ϴ� ���̺��� ������ ���� ����
���� ������ �����Ͱ� 10000���̸� 10000�ǿ� ���� DISK I/O�� �߻�
SELECT ROWNUM
FROM emp
WHERE ROWNUM <=5;

1. �츮���� �־��� ���ڿ� ��� - 202005
    �־��� ����� �ϼ��� ���Ͽ� �ϼ��� ���� ����

�޷��� �÷��� 7�� - �÷��� ������ ���� - Ư�����ڴ� �ϳ��� ���Ͽ� ����    
SELECT TO_DATE('2020/05','YYYY/MM') + (LEVEL -1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('2020/05','YYYY/MM')),'DD');

SELECT TO_DATE('2020/05','YY/MM')
FROM dual;

�Ʒ�������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ�
������ ���鿡�� �ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����.
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

1���� �Ͽ����� �����ΰ�
���������� ������� �����ΰ�?


