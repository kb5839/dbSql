NULLó�� �ϴ� ���(4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
NVL, NVL2

condition : CASE, DECODE

�����ȹ : �����ȹ�� ����, ���¼����� ��� �Ǵ���

emp���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸� SAL���� 30% �λ�� �ݾ��� ���ʽ��� ����
                                �׿ܴ� 10% ����
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿ܴ� SAL��ŭ�� ����

2.DECODE[EXPR1, 
            search1, return1, 
            search2, return2, 
            search3,return3 
            [default])

SELECT empno,ename,job,sal,
        DECODE(job,'SALESMAN',SAL*1.05,
                    'MANAGER',DECODE(deptno,10,sal*1.3,sal*1.1),
                    'PRESIDENT',sal*1.2,sal) BONUS
FROM emp;

���� A =  {10,15,18,23,24,25,29,30,35,37}
�Ҽ� : {23,29,37} : COUNT-3,MAX-37,MIN-23,AVG-29.66,SUM-89
��Ҽ� : {10,15,18,24,25,30,35} 


GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�
EX) �μ��� �޿� ���
    emp ���̺��� 14���� ������ �ְ�,14���� ������ 3���� �μ�(10,20,30)�� ���� �ִ�.
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�
    
    
GROUP BY ����� ���ǻ��� : SELECT ����� �� �մ� �÷��� ���ѵ�
SELECT �׷��� ���� �÷�,�׷��Լ�
FROM ���̺�
GROUP BY ��Ǳ�� ���� �÷�
[ORDER BY];

�μ����� ���� ���� �޿� ��

SELECT deptno,
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal),2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� ��
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*), -- �μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;

*�׷��Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���Ҽ��� ������
 ���� ���� �޿��� �޴� ����� �̸��� �� �� ����.
 ==>���� WINDOW/�м� �Լ��� ���� �ذᰡ��
 
emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� �����ϴ� ���
�׷�ȭ�� ���� ���� ���ڿ�,��� ���� SELECT���� ���ü��ִ�
SELECT 
        MAX(sal), --��ü�� ���� ���� �޿� ��
        MIN(sal), --��ü�� ���� ���� �޿� ��
        ROUND(AVG(sal),2), --��ü �޿� ���
        SUM(sal), --��ü �޿� ��
        COUNT(sal), --��ü �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*), -- ��ü ���� ��
        COUNT(mgr)-- mgr�÷��� null�� �ƴ� �Ǽ�
FROM emp;

GROUP BY ���� ����� �÷��� 
    SELECT���� ������ ������ ??? -�������
GROUP BY ���� ������� ���� �÷��� 
    SELECT���� ������ ??? - ����
    
GROUP �Լ� ����� NULL���� ���ܵȴ�.
30�� �μ����� NULL���� ���� ���� ������ SUM(comm)�� ���� ���������� ���Ȱ��� Ȯ���Ҽ� �ִ�.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10,20�� �μ��� SUM(comm) �÷��� NULL�̾ƴ϶� 0�� �������� NULLó��    
*Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ°��� ���ɻ� ����
NVL(SUM(comm),0) : comm�÷��� sum �׷��ռ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm),0) : ��� comm�÷��� NVL �Լ��� ������(�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����
SELECT deptno, NVL(SUM(comm),0)
FROM emp
GROUP BY deptno;
    
single row �Լ��� where���� ����� �� ������
multi row �Լ�(group �Լ�)�� where���� ����Ҽ�����
GROUP BY �� ���� HAVING ���� ���� ���

�μ��� �޿� ���� 9000�� �Ѵ� �μ���ȸ(��X/�Ʒ�O)
SELECT deptno,SUM(sal)
FROM emp
WHERE SUM(sal)>9000
GROUP BY deptno;

SELECT deptno,SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal)>9000;

SELECT 
        MAX(sal)MAX_SAL, 
        MIN(sal)MIN_SAL, 
        ROUND(AVG(sal),2)AVG_SAL, 
        SUM(sal)SUM_SAL, 
        COUNT(sal)COUNT_SAL,
        COUNT(mgr)COUNT_MGR,
        COUNT(*)COUNT_ALL
       
FROM emp;

SELECT deptno,
        MAX(sal)MAX_SAL, 
        MIN(sal)MIN_SAL, 
        ROUND(AVG(sal),2)AVG_SAL, 
        SUM(sal)SUM_SAL, 
        COUNT(sal)COUNT_SAL,
        COUNT(mgr)COUNT_MGR,
        COUNT(*)COUNT_ALL
       
FROM emp
GROUP BY deptno;

SELECT CASE
        WHEN deptno = 10 THEN 'ACOOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        END dname,
        MAX(sal)MAX_SAL, 
        MIN(sal)MIN_SAL, 
        ROUND(AVG(sal),2)AVG_SAL, 
        SUM(sal)SUM_SAL, 
        COUNT(sal)COUNT_SAL,
        COUNT(mgr)COUNT_MGR,
        COUNT(*)COUNT_ALL
       
FROM emp
GROUP BY deptno
ORDER BY dname;

SELECT*
FROM emp;

my
SELECT TO_CHAR(hiredate,'YYYYMM') HIRE_YYYYMM,
        COUNT(TO_CHAR(hiredate,'YYYYMM')) COUNT
FROM emp
GROUP BY hiredate;

TCH
SELECT TO_CHAR(hiredate,'YYYYMM')HIRE, COUNT(*) COUNT
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');

SELECT TO_CHAR(hiredate,'YYYY')HIRE, COUNT(*) COUNT
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY HIRE;

SELECT COUNT(*) CNT
FROM dept;

SELECT COUNT(deptno)
FROM emp
GROUP BY deptno;

SELECT*
FROM emp;