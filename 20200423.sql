NVL (expr1, expr2)
if expr1 == null
    return expr2
else
    return expr1
    
NVL2(expr1, expr2, expr3)
if expr1 != null
    return expr2
else
    return expr3
    
NULLIF(expr1, expr2)
if expr1 == expr2
    return null
else
    return expr1
    
sal �÷��� ���� 3000�̸� null�� ����    
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

�������� : �Լ��� ������ ������ ������ ���� ����
          �������ڵ��� Ÿ���� ���� �ؾ���
���ڵ��߿� ���� ���������� null�� �ƴ� ���� ���� ����          
coalesce(expr1, expr2......)
if expr1 != null
    return expr1
else
    coalesce(expr2......)
    
mgr �÷� null
comm �÷� null

SELECT empno, ename, comm, sal, coalesce(comm, sal)
FROM emp;

SELECT empno, ename, mgr,NVL(mgr,9999) MGR_N,
    NVL2(mgr,mgr,9999) MGR_N_1, coalesce(mgr,9999) MGR_N_2
FROM emp;

SELECT userid, usernm, reg_dt, NVL(reg_dt,SYSDATE) N_REG_DT
FROM users
WHERE userid != 'brown';

����ȭ ==> os���� �ٸ� os��ġ
1.�ϵ忡�� �ڿ��� �̾ƸԴ´�
2.oracle mac �÷����� ����

condition
���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
java if, switch
1.case ����
2.decode �Լ�

1.CASE
CASE
    WHEN �� / ������ �Ǻ��� �� �ִ� �� THEN ������ ��
    [WHEN �� / ������ �Ǻ��� �� �ִ� �� THEN ������ ��]
    [ELSE ������ �� (�Ǻ����� ���� WHEN ���� ������� ����)]
END

emp���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� MANAGER�� ��� SAL���� 10% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿ܴ� SAL��ŭ�� ����

SELECT empno,ename,job,sal,
    CASE
        WHEN job = 'SALESMAN'  THEN sal * 1.05
        WHEN job = 'MANAGER'  THEN sal * 1.10
        WHEN job = 'PRESIDENT'  THEN sal * 1.20
        ELSE sal * 1 
    END BONUS
FROM emp;

2.DECODE[EXPR1, 
            search1, return1, 
            search2, return2, 
            search3,return3 
            [default])
EXPR1 == search1
    return return1
else if EXPR1 == search2
    return return1
else if EXPR1 == search3
    return return3
.....
else
    return default;
    
SELECT empno, ename, job ,sal,
    DECODE(job, 'SALESMAN',sal*1.05,
                'MANAGER',sal*1.10,
                'PRESIDENT'sal*1.20,
                sal) bonus
FROM emp;

SELECT*
FROM emp;

SELECT empno, ename, deptno,
    CASE
        WHEN deptno = 10 THEN 'ACOOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
    END dname
FROM emp;

SELECT empno,ename,deptno,
DECODE (deptno,10,'ACOOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','DDIT') dname
FROM emp;

SELECT empno, ename, hiredate,
CASE
WHEN MOD(TO_CHAR(hiredate,'YY'),2) = MOD(TO_CHAR(SYSDATE,'YY'),2) THEN '�ǰ����� �����'
ELSE '�ǰ����� ������'
END CONTACT_TO_DOCTOR
FROM emp;


SELECT userid, usernm, alias, reg_dt,
CASE
WHEN MOD(TO_CHAR(reg_dt,'YY'),2) = MOD(TO_CHAR(SYSDATE,'YY'),2) THEN '�ǰ����� �����'
ELSE '�ǰ����� ������'
END CONTACTTODOCTOR
FROM users;