부모-자식 테이블 관계

1. 테이블 생성시 순서
    1_부모(dept)
    2_자식(emp)

2. 데이터 생성시 순서
    1_부모(dept)
    2_자식(emp)

3. 데이터 삭제시 순서
    1_자식(emp)
    2_부모(dept)
    
테이블 변경시(

DROP TABLE emp_test;

CREATE TABLE emp_test ( 
empno NUMBER (4),
ename VARCHAR2(10),
deptno NUMBER (2)
);

테이블 새성시 제약조건을 특별히 생성하지 않음

제약조건 타입 - PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK

테이블 변경을 통한  PRIMARY KEY 추가
문법 - ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건 타입 (적용할 컬럼[,]);

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);

테이블 변경시 제약조건 삭제
문법 - ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명

위에서 추가한 제약조건 pk_emp_test 삭제
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

테이블 생성이후 외래키 제약조건 추가 실습
emp_test.deptno ==> dept_test.deptno

dept_test테이블의 deptno에 인덱스 생성 되어있는지 확인

ALTER TABLE emp_test ADD CONSTRAINT 제약조건명 제약조건타입 (컬럼) REFERENCES 참조테이블명 (참조테이블 컬럼명);

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

삭제는 동일;

제약조건 활성화 비활성화
테이블에 설정된 제약조건을 삭제 하는 것이 아니라 잠시 기능을 끄고, 키는 설정
문법 - ALTER TABLE 테이블명 ENABLE or DISABLE CONSTRAINT 제약조건명;

위에서 설정한 fk_emp_test_dept_test FOREIGN KEY 제약조건을 비활성화;
ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

fk_emp_test_dept_test 제약조건이 비활성화되어 있기 때문에 emp_test 테이블에는 99번 부서 이외의 값이 입력 가능한 상황

dept_test 테이블에 88번 부서가 없지만 아래 쿼리는 정상적으로 실행
INSERT INTO emp_test VALUES (9999,'brown',88);

현재 상황 - emp_test 테이블에 dept_test 테이블에 존재하지 않는 88번 부서를 사용하고 있는 상황
            fk_emp_test_dept_test 제약조건은 비활성화된 상태
            
테이터의 무결성이 깨진 상태에서 fk_emp_test_detp_test를 활성화 시키면?

ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;

emp, dept 테이블에는 현재 PRIMARY KEY, FOREIGN KEY 제약이 걸려 있지 않은 상황
emp 테이블은 empno를 key로 dept 테이블은 deptno를 key로 하는 PRIMARY KEY 제약을 추가하고

emp.deptno ==> dept.deptno를 참조하도록 FOREIGN KEY를 추가

제약조건명은 수업시간에 안내한 방법으로 명명

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

제약조건 확인
툴에서 제공해주는 메뉴(테이블 선택 => 제약조건 tab0
USER _CONS_COLUMN - 제약조건 컬럼 정보(상세_

컬럼확인
툴
SELECT*
DESC
USER_TAB_COLUMNS
WHERE TABLE_NAME = 'emp';

SELECT 'SELECT* FROM ' || TABLE


테이블, 컬럼 주석 - USER_TAB_COMMENTS, USER_COL_COMMENTS;

SELECT*
FROM user_tab_comments;

실세 서비스서 사용되는 테이블의 수는 수십개로 끝나지않는 경우가 많다.


테이블의 주석 생성하기
문법 - COMMENTS ON TABLE 테이블명 IS '주석';

emp 테이블에 주석 생성하기
COMMENT ON TABLE emp IS 'Slave';

SELECT*
FROM emp;

컬럼주석확인
SELECT*
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

컬럼 주석 생성
COMMENT ON COLUMN 테이블명.컬럼명 IS '주석';

empno, ename, hiredate

COMMENT ON COLUMN EMP.EMPNO IS '사번';
COMMENT ON COLUMN EMP.ENAME IS '이름';
COMMENT ON COLUMN EMP.HIREDATE IS '입사일자';

SELECT *
FROM user_col_comments,user_tab_comments
WHERE TABLE_NAME IN ('CYCLE','CUSTOMER','DAILY','PRODUCT')
AND USER_COL_COMMENTS.TABLE_NAME = USER_TAB_COMMENTS.TABLE_NAME;

SELECT t.*, c.COMMENTS, c.COLUMN_NAME
FROM user_tab_comments t ,user_col_comments c
WHERE t.TABLE_NAME = c.TABLE_NAME
AND t.TABLE_NAME IN ('CYCLE','CUSTOMER','DAILY','PRODUCT');


View는 쿼리다~~~~
논리적인 데이터 집합 = SQL
물리적인 데이터 집합이 아니다

view 사용 용도
-데이터 보안(불필요한 컬럼 공개를 제한)
-자주사용하는 복잡한 쿼리 재사용
-IN-LINE VIEW를 사용해도 동일한 결과를 만들어 낼수 있으나 MAIN 쿼리가 길어지는 단점이 있다.

view를 생성하기 위해서는 CREATE VIEW 권한을 갖고 있어야 한다(DBA설정)

SYSTEM 계정을 통해
GRANT CREATE VIEW TO 뷰생성권한을 부여할 계정명;

문법 - CREATE [OR REPLACE] VIEW 뷰이름 [컬럼별칭1,컬럼별칭2....] AS
        SELECT 쿼리;
        
emp 테이블에서 sal, comm 컬럼을 제외한 6가지 컬럼만 조회가 가능한 v_emp view를 생성

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

view (v_emp)를 통한 데이터 조회
SELECT*
FROM v_emp;

v_emp view는 kb계정 소유
HR계정에게 인사 시스템 개발을 위해 emp테이블이 아닌 sal,comm조회가 제한된
v_emp view를 조회할수 있도록 권한 부여

[hr계정에서실행]권한부여전 HR 계정에서 v_emp 조회
SELECT*
FROM kb.v_emp;

[kb계정에서실행]kb계정에서 hr계정으로 v_emp view를 조회할수 있는 권한 부여
GRANT SELECT ON v_emp TO hr;

[hr계정에서실행]v_emp view 권한을 hr 계정에 부여한 이후 조회테스트
SELECT*
FROM kb.v_emp;

실습
v_emp_dept 뷰를 생성
emp, dept 테이블을 deptno컬럼으로 조인하고
emp.empno, ename, dept.deptno, dname 4개의 컬럼으로 구성

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno, ename, DEPT.DEPTNO, dname
FROM emp,dept
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT*
FROM v_emp_dept;

VIEW 삭제
DROP VIEW 뷰 이름

VIEW를 통한 DML 처리
SIMPLE VIEW일 때만 가능

SIMPLE VIEW - 조인되지 않고, 함수, GROUP BY, ROWNUM을 사용하지 않은 간단한 형태의 VIEW
COMPLEX VIEW - SIMPLE VIEW가 아닌 형태

v_emp - SIMPLE VIEW

SELECT*
FROM v_emp;

v_emp를 통해 SMITH를 brown으로 변경
UPDATE v_emp SET ename = 'brown'
WHERE empno = 7369;

SELECT*
FROM emp;

v_emp컬럼에는 sal 컬럼이 존재하지 않기 때문에 에러
UPDATE v_emp SET sal = 1000
WHERE empno = 7369;

ROLLBACK;

SEQUENCE
유일한 정수값을 생성해주는 오라클 객체
인조식별자 값을 생성할 때 주로 사용

식별자 => 해당 행을 유일하게 구별할 수 있는 값
본질 <=> 인조 식별자

본질 - 원래 그러한것
인조 - 꾸며낸 것

일반적으로 어떤 테이블(엔터티) 의 식별자를 정하는 방법은
누가,언제,무엇을

게시판의 게시글 - 게시글 작성자가 언제 어떤글을 작성 했는지
게시글의 식별자 - 작성자 ID, 작성일지, 글제목
 ==> 본질 식별자가 너무 복잡하기 때문에 개발의 용이성을 위해
    본질 식별자를 대체할수 있는(중복되지 않는) 인조 식별자를 사용

개발을 하다보면 유일한 값을 생성해야 할 때가 생김
ex) 사번, 학번, 게시글 번호
    사번, 학번 - 체계가 있음
    사번 - 15101001 회사가 설립년차 15, 10월 10일 해당날짜에 첫번째 입사한사람
    게시글번호 - 체계가..., 겹치지 않는 순번
    
    체계가 있는 경우는 자동화되기 보다는 사람의 손을 타는 경우가 많음
    체계가 없는 경우는 자동화가 가능하다 =>SEQUENCE 객체를 활용하여 손쉽게 구현가능
                                        =>중복되지 않는 정수 값을 반환

중복되지 않는 값을 생성하는 방법
1. KEY TABLE 을 생성
    =>SELECT FOR UPDATE 다른 사람이 동시에 사용하지 못하도록 막는게 가능
    =>손이 많이 가는 편, 하지만 값을 이쁘게?  유지하는게 가능(SEQUENCE에서는 불가능)
    
2. JAVA의 UUID 클래스를 활용, 별도의 라이브러리 활용(유료) => 금융권, 보험, 카드

3. ORACLE DB - SEQUENCE



SEQUENCE 생성
문법 - CREATE SEQUENCE 시퀀스 명

seq_emp라는 시퀀스를 생성
CREATE SEQUENCE seq_emp;

사용법 - 객체에서 제공해주는 함수를 통해 값을 받아온다
NEXTVAL - 시퀀스를 통해 새로운 값을 받아온다
CURRVAL - 시퀀스 객체의 NEXTVAL를 통해 얻어온 값을 다시한번 확인할 때 사용
            (트랜잭션에서 NEXTVAL 실행하고 나서 사용이 가능)
;
SELECT seq_emp.NEXTVAL
FROM dual;

SELECT seq_emp.CURRVAL
FROM dual;

SELECT*
FROM emp_test;

SEQUENCE를 통한 중복되지 않는 empno 값 생성하여 insert 하기
아래 쿼리를 여러번 실행;
INSERT INTO emp_test VALUES(seq_emp.NEXTVAL, 'sally', 88);


































