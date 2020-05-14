�����ȹ - SQL�� ���������� � ������ ���ļ� �������� ������ �ۼ�
        *����ϴµ� ��� ���� ����� �ʿ�(�ð�)
        
2���� ���̺��� �����ϴ� SQL
2���� ���̺� ���� �ε����� 5���� �ִٸ�
������ �����ȹ ���� �?? ����� ���� => ª�� �ð��ȿ� �س��� �Ѵ�(������ ���� �ؾ��ϹǷ�)

���� ������ SQL�� ����� ��� ������ �ۼ��� �����ȹ�� �����Ұ��
���Ӱ� ������ �ʰ� ��Ȱ���� �Ѵ�(���ҽ� ����)

���̺� ���� ��� - ���̺� ��ü(1), ������ �ε���(5)
a => b
b => a
����� �� - 36�� * 2�� = 72��

������ SQL �̶� - SQL ������ ��ҹ��� ������� ��ġ�ϴ� SQL
�Ʒ� �ΰ��� sql�� ���� �ٸ� sql�� �ν��Ѵ�
SELECT* FROM emp;
Select* FROM emp;

Ư�������� ������ ��ȸ�ϰ� ������ - ����� �̿��ؼ�
SELECT /* 202004_B */ *
FROM emp
WHERE empno = 7499;

SYNONYM - ��ü�� ��Ī�� �����ؼ� ��Ī�� ���� ���� ��ü�� ���
���� - CREATE SYNONYM �ó�� �̸� FOR ��� ������Ʈ;

kb.v_emp ==> v_emp �ó������ ����

CREATE SYNONYM v_emp FOR kb.v_emp;

v_emp�� ���� ���� ��ü�� kb.v_emp�� ����� �� �ִ�

SQL CATEGORY
DML
DDL
DCL
TCL

Data Dictionary - �ý��� ������ ���� �ִ� view, ����Ŭ�� ��ü������ ����
category (���ξ�)
USER - �ش� ����ڰ� �����ϰ� �ִ� ��ü ���
ALL - �ش� ����� ���� + ������ �ο����� ��ü ���
DBA - ��� ��ü���
V$ - ����, �ý��� ����

Multiple insert - �������� �����͸� ���ÿ� �Է��ϴ� insert�� Ȯ�屸��

1. unconditional insert - ������ ���� ���� ���̺� �Է��ϴ� ���
���� - INSERT ALL
            INTO ���̺��
            [,INTO ���̺��]
            VALUES (...) | SELECT QUERY;
            
SELECT*
FROM emp_test;

emp_test ���̺��� �̿��Ͽ� emp_test2 ���̺� ����
CREATE TABLE emp_test2 AS
SELECT* 
FROM emp_test
WHERE 1 != 1;

empno, ename, deptno
emp_test, emp_test2 ���̺� ���� �Է�
INSERT ALL
INTO emp_test
INTO emp_test2
SELECT 9998, 'brown' , 88 FROM dual UNION ALL
SELECT 9997, 'cony' , 88 FROM dual;

SELECT*
FROM emp_test2;

2. conditional insert - ���ǿ� ���� �Է��� ���̺��� ����
���� - 
INSERT ALL
WHEN ���� ....THEN
INTO �Է� ���̺� VALUES
WHEN ���� ....THEN
INTO �Է� ���̺�2 VALUES
ELSE
INTO �Է� ���̺�3 VALUES

SELECT ����� ���� ���� EMPNO = 9998 �̸� EMP_TEST���� �����͸� �Է�
                                �׿ܿ��� EMP_TEST2�� �����͸� �Է�

INSERT ALL
WHEN  empno = 9998 THEN
    INTO emp_test VALUES (empno, ename, deptno)
    ELSE
    INTO emp_test2 (empno, deptno) VALUES (empno, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony' , 88 FROM dual;

ROLLBACK;

conditional insert (all) ==> first - ������ �����ϴ� ù ��° WHEN ���� ����
INSERT ALL
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony' , 88 FROM dual;        


INSERT FIRST
    WHEN empno <= 9998 THEN
        INTO emp_test VALUES (empno, ename, deptno)
    WHEN empno <= 9997 THEN
        INTO emp_test2 VALUES (empno, ename, deptno)
SELECT 9998 empno, 'brown' ename, 88 deptno FROM dual UNION ALL
SELECT 9997, 'cony' , 88 FROM dual; 

SELECT*
FROM emp_test2;


MERGE - �ϳ��� ������ ���� �ٸ� ���̺�� �ű� �Է�, �Ǵ� ������Ʈ �ϴ� ����
���� - 
MERGE INTO ���� ���(emp_test)
USING (�ٸ� ���̺� | VIEW | subquery)
ON (�������� USING ���� ���� ���� ���)
WHEN NOT MATCHED THEN
    INSERT (col1, col2 ...) VALUES (value1, value2...)
WHEN MATCHED THEN
    UPDATE SET col1 = value1, col2=value2

1.�ٸ� �����ͷ� ���� Ư�� ���̺�� �����͸� ���� �ϴ� ���

2.KEY�� ������� INSERT
  KEY�� ������� UPDATE

emp ���̺��� �����͸� emp_test ���̺�� ����
emp ���̺��� �����ϰ� emp_test ���̺��� �������� �ʴ� ������ �ű��Է�
emp ���̺��� �����ϰ� emp_test ���̺��� �����ϴ� ������ �ű��Է�

INSERT INTO emp_test VALUES (7369,'cony',88);

emp ���̺��� 14�ǵ����͸� emp_test ���̺� ������ empno�� �����ϴ��� �˻��ؼ�
������ empno�� ������ insert-empno,ename, ������ empno�� ������ update-ename
MERGE INTO emp_test
USING emp
ON (emp_test.empno = emp.empno)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES(emp.empno, emp.ename)
WHEN MATCHED THEN
    UPDATE SET ename = emp.ename;


SELECT*
FROM emp_test;

9999�� ������� �ű� �Է��ϰų�, ������Ʈ�� �ϰ���� ��
(����ڰ� 9999��, james ����� ����ϰų�, ������Ʈ �ϰ������)
���� ���� ���̺� => �ٸ� ���̺�� ����
�����͸� => Ư�� ���̺�� ����

MERGE ������ ������� ������

������ ���� ������ ���� SELECT ����
SELECT*
FROM emp_test
WHERE empno = 9999;

�����Ͱ� ������ => UPDATE
�����Ͱ� ������ => INSERT

MERGE INTO emp_test
USING dual
    ON (emp_test.empno = 9999)
WHEN NOT MATCHED THEN
    INSERT (empno, ename) VALUES (9999, 'james')
WHEN MATCHED THEN
    UPDATE SET ename = 'james';

REPORT GROUP FUNCTION
emp ���̺��� �̿��� �μ���ȣ�� ������ �޿� �հ�, ��ü������ �޿����� ��ȸ�ϱ� ����
GROUP BY�� ����ϴ� �ΰ��� SQL�� ������ �ϳ��� ��ġ��(UNION ALL) �۾��� ����

SELECT TO_CHAR(deptno) deptno, SUM(sal) sal
FROM emp
GROUP BY deptno

UNION

SELECT '�հ�',SUM(sal)
FROM emp

Ȯ��� GROUP BY 3����
1. GROUP BY ROLLUP
���� - GROUP BY ROLLUP (�÷�, �÷�2....)
���� - ����׷��� ������ִ� �뵵
����׷� ���� ��� - ROLLUP ���� ����� �÷��� �����U���� ���� �ϳ��� �����ϸ鼭 ����׷��� ����
������ ����׷��� UNION�� ����� ��ȯ

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

����׷� - 1. GROUP BY job, deptno
             UNION
          2. GROUP BY job
             UNION
          3. ��ü�� GROUP BY
          
          
SELECT deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno);  

����׷��� ������ - ROLLUP ���� ����� �÷��� ���� +1;

