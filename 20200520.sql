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

202005 => �ش���� 1���� ���ϴ� ���� �Ͽ����� �����ΰ�?
202005 => �ش���� ���������ڰ� ���ϴ� ���� ������� �����ΰ�?
SELECT TO_DATE('202005','yyyymm'), TO_CHAR(TO_DATE('202005','yyyymm'),'d'),
TO_DATE('202005','yyyymm') - TO_CHAR(TO_DATE('202005','yyyymm'),'d')+1 S,

LASTDAY(TO_DATE('202005','yyyymm')),TO_CHAR(LASTDAY(TO_DATE('202005','yyyymm')),'d'),
LASTDAY(TO_DATE('202005','yyyymm')) + (7 - TO_CHAR(LASTDAY(TO_DATE('202005','yyyymm')),'d')) e,
(LASTDAY(TO_DATE('202005','yyyymm'))
FROM dual;

�μ��� �޿� ����

SELECT ename, sal, deptno, 
FROM emp
ORDER BY deptno, sal desc

SELECT lv, ROWNUM rn
FROM
(SELECT a.*,b.lv
FROM 
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno)a, 
(SELECT LEVEL lv FROM dual
CONNECT BY LEVEL <=6) b)
WHERE a.cnt >= lv

���� ������ ������ �м��Լ��� �̿��Ͽ� ������;
RANK�����Լ� - RANK, DENSE_RANK, FOW_NUMBER
RANK - ���� ���ϱ�, ���� ���� ���ؼ��� ������ ������ �ο��ϰ� �ļ�����+1
        1����3���̸� 2��,3���� ���� �� �ļ�����4��
DENSE_RANK - ���� ���ϱ�, ������ ���� ���ؼ��� ������ ������ �ο��ϰ�
�ļ����� �״�� ���� 1���� 3���̸� �״��� �ļ����� 2��
ROW_NUMBER - ���� ������� 1���� �������� ���� �ο�, ������ �ߺ��� ����.

SELECT ename, sal, deptno, 
    RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_rank
FROM emp;

SELECT ename, sal, deptno, 
    RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_rank,
    DENSE_RANK() OVER(PARTITION BY deptno ORDER BY sal) sal_dense_rank,
    ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal) sal_row_rank
FROM emp;

SELECT ename, sal, deptno, 
    RANK() OVER (ORDER BY sal DESC, empno) sal_rank,
    DENSE_RANK() OVER(ORDER BY sal DESC, empno) sal_dense_rank,
    ROW_NUMBER() OVER(ORDER BY sal DESC, empno) sal_row_NUMBER
FROM emp;

�м��Լ��� ������� �ʰ� ���� �������θ� ������ ����
SELECT a.*,b.cnt
FROM
(SELECT empno, ename, deptno
FROM emp) a,
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) b
WHERE a.deptno = b.deptno
ORDER BY a.deptno, a.empno;

�м��Լ� - ������ ��� �����Լ�(�׷��Լ�) 5������ �м��Լ������� ����
�׷��Լ� - SUM, MAX, MIN, AVG, COUNT

SELECT empno, ename, deptno, COUNT(*) OVER(PARTITION BY deptno)
FROM emp;

SELECT empno, ename, deptno, ROUND(AVG(sal) OVER(PARTITION BY deptno),0) avg
FROM emp;


SELECT empno, ename, deptno,
MAX(sal) OVER(PARTITION BY deptno) max_sal,
MIN(sal) OVER(PARTITION BY deptno) min_sal
FROM emp;

�׷쳻 ����� - 
LAG - Ư������ ����
LEAD - Ư������ ����

��ü������ �޿� �������� �ڽź��� �޿� ��ũ�� �Ѵܰ� ���� ����� �޿� ��������
�� �޿��� �������� �Ի����ڰ� ��������� ������ ���� ������ ���

SELECT empno, ename, hiredate, sal,
    LEAD(sal) OVER(ORDER BY sal DESC,hiredate)lead_sal
FROM emp
ORDER BY sal DESC;

��ü������ �޿� �������� �ڽź��� �޿� ��ũ�� �Ѵܰ� ���� ����� �޿� ��������
�� �޿��� �������� �Ի����ڰ� ��������� ������ ���� ������ ���

SELECT empno, ename, hiredate, sal,
    LAG(sal) OVER(ORDER BY sal DESC,hiredate)lag_sal
FROM emp
ORDER BY sal DESC;

SELECT empno, ename, hiredate,job,sal,
    LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC,hiredate)lag_sal
FROM emp;

SELECT a.empno, a.ename, a.sal, SUM(b.sal) c_sum
FROM
(SELECT a.*, ROWNUM rn
FROM
(SELECT empno, ename, sal
FROM emp 
ORDER BY sal) a) a,

(SELECT a.*, ROWNUM rn
FROM
(SELECT empno, ename, sal
FROM emp 
ORDER BY sal) a) b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal
ORDER BY a.sal;


�׷� �� ����� - WINDOWING
SELECT empno, ename, deptno, sal,
SUM(sal) OVER(ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) C_SUM
FROM emp;

������ �� ����
EX_ ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING

SELECT empno, ename, deptno, sal,
SUM(sal) OVER(ORDER BY sal ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) C_SUM
FROM emp;


SELECT empno, ename, deptno, sal,
SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) C_SUM
FROM emp;

WINDOWING
ROWS - ������ ROW�� ��Ī
RANGE - ������ ROW�� ��Ī
        ���� ���� ���� ������ �ν�
DEFAULT - 

SELECT empno, ename, deptno, sal,
SUM(sal) OVER(ORDER BY sal ROWS UNBOUNDED PRECEDING) rowss,
SUM(sal) OVER(ORDER BY sal RANGE UNBOUNDED PRECEDING) ranges
FROM emp;

���� ������
SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, total
FROM
(SELECT org_cd, parent_org_cd, lv, SUM(total) total
FROM
(SELECT a.*, SUM(no_emp_c) OVER (PARTITION BY gp ORDER BY rn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) total
FROM
(SELECT a.*, ROWNUM rn, lv + ROWNUM gp,
COUNT(*) OVER (PARTITION BY org_cd) cnt,
no_emp / COUNT(*) OVER (PARTITION BY org_cd) no_emp_c
FROM
(SELECT org_cd, parent_org_cd, no_emp,
    CONNECT_BY_ISLEAF leaf, LEVEL lv
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd) a
START WITH leaf = 1
CONNECT BY PRIOR parent_org_cd = org_cd) a)
GROUP BY org_cd, parent_org_cd, lv)
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

dt �÷��� ����� ������ �ߺ��� �����ؼ� ��ȸ�ϴ�
20200501 ~ 20200630 -61
SELECT dt
FROM gis_dt
ORDER BY dt desc;