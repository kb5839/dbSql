NULL처리 하는 방법(4가지 중에 본인 편한걸로 하나 이상은 기억)
NVL, NVL2

condition : CASE, DECODE

실행계획 : 실행계획이 먼지, 보는순서가 어떻게 되는지

emp테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 SALESMAN일 경우 SAL에서 5% 인상된 금액을 보너스로 지급
해당 직원의 job이 MANAGER이면서 deptno가 10이면 SAL에서 30% 인상된 금액을 보너스로 지급
                                그외는 10% 지급
해당 직원의 job이 PRESIDENT일 경우 SAL에서 20% 인상된 금액을 보너스로 지급
그외는 SAL만큼만 지급

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

집합 A =  {10,15,18,23,24,25,29,30,35,37}
소수 : {23,29,37} : COUNT-3,MAX-37,MIN-23,AVG-29.66,SUM-89
비소수 : {10,15,18,24,25,30,35} 


GROUP FUNCTION
여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
여러행을 입력받아 하나의 행으로 결과가 묶인다
EX) 부서별 급여 평균
    emp 테이블에는 14명의 직원이 있고,14명의 직원은 3개의 부서(10,20,30)에 속해 있다.
    부서별 급여 평균은 3개의 행으로 결과가 반환된다
    
    
GROUP BY 적용시 주의사항 : SELECT 기술할 수 잇는 컬럼이 제한됨
SELECT 그룹핑 기준 컬럼,그룹함수
FROM 테이블
GROUP BY 그풉핑 기준 컬럼
[ORDER BY];

부서별로 가장 높은 급여 값

SELECT deptno,
        MAX(sal), --부서별로 가장 높은 급여 값
        MIN(sal), --부서별로 가장 낮은 급여 값
        ROUND(AVG(sal),2), --부서별 급여 평균
        SUM(sal), --부서별 급여 합
        COUNT(sal), --부서별 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT(*), -- 부서별 행의 수
        COUNT(mgr)
FROM emp
GROUP BY deptno;

*그룹함수를 통해 부서번호 별 가능 높은 급여를 구할수는 있지만
 가장 높은 급여를 받는 사람의 이름은 알 수 없다.
 ==>추후 WINDOW/분석 함수를 통해 해결가능
 
emp 테이블의 그룹 기준을 부서번호가 아닌 전체 직원으로 설정하는 방법
그룹화와 관련 없는 문자열,상수 등은 SELECT절에 나올수있다
SELECT 
        MAX(sal), --전체로 가장 높은 급여 값
        MIN(sal), --전체로 가장 낮은 급여 값
        ROUND(AVG(sal),2), --전체 급여 평균
        SUM(sal), --전체 급여 합
        COUNT(sal), --전체 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT(*), -- 전체 행의 수
        COUNT(mgr)-- mgr컬럼이 null이 아닌 건수
FROM emp;

GROUP BY 절에 기술된 컬럼이 
    SELECT절에 나오지 않으면 ??? -정상출력
GROUP BY 절에 기술되지 않은 컬럼이 
    SELECT절에 나오면 ??? - 에러
    
GROUP 함수 연산시 NULL값은 제외된다.
30번 부서에는 NULL값을 갖는 행이 있지만 SUM(comm)의 값이 정상적으로 계산된것을 확인할수 있다.
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10,20번 부서의 SUM(comm) 컬럼이 NULL이아니라 0이 나오도록 NULL처리    
*특별한 사유가 아니면 그룹함수 계산결과에 NULL 처리를 하는것이 성능상 유리
NVL(SUM(comm),0) : comm컬럼에 sum 그룹합수를 적용하고 최종 결과에 NVL을 적용(1회 호출)
SUM(NVL(comm),0) : 모든 comm컬럼에 NVL 함수를 적용후(해당 그룹의 ROW수 만큼 호출) SUM 그룹함수 적용
SELECT deptno, NVL(SUM(comm),0)
FROM emp
GROUP BY deptno;
    
single row 함수는 where절에 기술할 수 있지만
multi row 함수(group 함수)는 where절에 기술할수없고
GROUP BY 절 이후 HAVING 절에 별도 기술

부서별 급여 합이 9000이 넘는 부서조회(위X/아래O)
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