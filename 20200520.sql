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

202005 => 해당월의 1일이 속하는 주의 일요일은 몇일인가?
202005 => 해당월의 마지막일자가 속하는 주의 토요일은 몇일인가?
SELECT TO_DATE('202005','yyyymm'), TO_CHAR(TO_DATE('202005','yyyymm'),'d'),
TO_DATE('202005','yyyymm') - TO_CHAR(TO_DATE('202005','yyyymm'),'d')+1 S,

LASTDAY(TO_DATE('202005','yyyymm')),TO_CHAR(LASTDAY(TO_DATE('202005','yyyymm')),'d'),
LASTDAY(TO_DATE('202005','yyyymm')) + (7 - TO_CHAR(LASTDAY(TO_DATE('202005','yyyymm')),'d')) e,
(LASTDAY(TO_DATE('202005','yyyymm'))
FROM dual;

부서별 급여 순위

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

위의 복잡한 쿼리를 분석함수를 이용하여 간단히;
RANK관련함수 - RANK, DENSE_RANK, FOW_NUMBER
RANK - 순위 구하기, 동일 값에 대해서는 동일한 순위를 부여하고 후순위는+1
        1등이3명이면 2등,3등이 없고 그 후순위는4등
DENSE_RANK - 순위 구하기, 동일한 값에 대해서는 동일한 순위를 부여하고
후순위는 그대로 유지 1등이 3명이면 그다음 후순위는 2등
ROW_NUMBER - 정렬 순서대로 1부터 순차적인 값을 부여, 순위의 중복이 없다.

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

분석함수를 사용하지 않고 기존 지식으로만 구현한 쿼리
SELECT a.*,b.cnt
FROM
(SELECT empno, ename, deptno
FROM emp) a,
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) b
WHERE a.deptno = b.deptno
ORDER BY a.deptno, a.empno;

분석함수 - 기존에 배운 집계함수(그룹함수) 5가지를 분석함수에서도 제공
그룹함수 - SUM, MAX, MIN, AVG, COUNT

SELECT empno, ename, deptno, COUNT(*) OVER(PARTITION BY deptno)
FROM emp;

SELECT empno, ename, deptno, ROUND(AVG(sal) OVER(PARTITION BY deptno),0) avg
FROM emp;


SELECT empno, ename, deptno,
MAX(sal) OVER(PARTITION BY deptno) max_sal,
MIN(sal) OVER(PARTITION BY deptno) min_sal
FROM emp;

그룹내 행순서 - 
LAG - 특정행의 이전
LEAD - 특정행의 이후

전체직원의 급여 순위에서 자신보다 급여 랭크가 한단계 낮은 사람의 급여 가져오기
단 급여가 같을때는 입사일자가 빠른사람이 순위가 높은 것으로 계산

SELECT empno, ename, hiredate, sal,
    LEAD(sal) OVER(ORDER BY sal DESC,hiredate)lead_sal
FROM emp
ORDER BY sal DESC;

전체직원의 급여 순위에서 자신보다 급여 랭크가 한단계 높은 사람의 급여 가져오기
단 급여가 같을때는 입사일자가 빠른사람이 순위가 높은 것으로 계산

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


그룹 내 행순서 - WINDOWING
SELECT empno, ename, deptno, sal,
SUM(sal) OVER(ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) C_SUM
FROM emp;

물리적 행 지정
EX_ ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING

SELECT empno, ename, deptno, sal,
SUM(sal) OVER(ORDER BY sal ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) C_SUM
FROM emp;


SELECT empno, ename, deptno, sal,
SUM(sal) OVER(PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) C_SUM
FROM emp;

WINDOWING
ROWS - 물리적 ROW를 지칭
RANGE - 논리적인 ROW를 지칭
        같은 값을 같은 범위로 인식
DEFAULT - 

SELECT empno, ename, deptno, sal,
SUM(sal) OVER(ORDER BY sal ROWS UNBOUNDED PRECEDING) rowss,
SUM(sal) OVER(ORDER BY sal RANGE UNBOUNDED PRECEDING) ranges
FROM emp;

계층 누적합
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
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd) a
START WITH leaf = 1
CONNECT BY PRIOR parent_org_cd = org_cd) a)
GROUP BY org_cd, parent_org_cd, lv)
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

dt 컬럼의 년월일 정보를 중복을 제거해서 조회하는
20200501 ~ 20200630 -61
SELECT dt
FROM gis_dt
ORDER BY dt desc;