�θ�-�ڽ� ���̺� ����

1. ���̺� ������ ����
    1_�θ�(dept)
    2_�ڽ�(emp)

2. ������ ������ ����
    1_�θ�(dept)
    2_�ڽ�(emp)

3. ������ ������ ����
    1_�ڽ�(emp)
    2_�θ�(dept)
    
���̺� �����(

DROP TABLE emp_test;

CREATE TABLE emp_test ( 
empno NUMBER (4),
ename VARCHAR2(10),
deptno NUMBER (2)
);

���̺� ������ ���������� Ư���� �������� ����

�������� Ÿ�� - PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK

���̺� ������ ����  PRIMARY KEY �߰�
���� - ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������� Ÿ�� (������ �÷�[,]);

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);

���̺� ����� �������� ����
���� - ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�

������ �߰��� �������� pk_emp_test ����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

���̺� �������� �ܷ�Ű �������� �߰� �ǽ�
emp_test.deptno ==> dept_test.deptno

dept_test���̺��� deptno�� �ε��� ���� �Ǿ��ִ��� Ȯ��

ALTER TABLE emp_test ADD CONSTRAINT �������Ǹ� ��������Ÿ�� (�÷�) REFERENCES �������̺�� (�������̺� �÷���);

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

������ ����;

�������� Ȱ��ȭ ��Ȱ��ȭ
���̺� ������ ���������� ���� �ϴ� ���� �ƴ϶� ��� ����� ����, Ű�� ����
���� - ALTER TABLE ���̺�� ENABLE or DISABLE CONSTRAINT �������Ǹ�;

������ ������ fk_emp_test_dept_test FOREIGN KEY ���������� ��Ȱ��ȭ;
ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

fk_emp_test_dept_test ���������� ��Ȱ��ȭ�Ǿ� �ֱ� ������ emp_test ���̺��� 99�� �μ� �̿��� ���� �Է� ������ ��Ȳ

dept_test ���̺� 88�� �μ��� ������ �Ʒ� ������ ���������� ����
INSERT INTO emp_test VALUES (9999,'brown',88);

���� ��Ȳ - emp_test ���̺� dept_test ���̺� �������� �ʴ� 88�� �μ��� ����ϰ� �ִ� ��Ȳ
            fk_emp_test_dept_test ���������� ��Ȱ��ȭ�� ����
            
�������� ���Ἲ�� ���� ���¿��� fk_emp_test_detp_test�� Ȱ��ȭ ��Ű��?

ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;

emp, dept ���̺��� ���� PRIMARY KEY, FOREIGN KEY ������ �ɷ� ���� ���� ��Ȳ
emp ���̺��� empno�� key�� dept ���̺��� deptno�� key�� �ϴ� PRIMARY KEY ������ �߰��ϰ�

emp.deptno ==> dept.deptno�� �����ϵ��� FOREIGN KEY�� �߰�

�������Ǹ��� �����ð��� �ȳ��� ������� ���

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

�������� Ȯ��
������ �������ִ� �޴�(���̺� ���� => �������� tab0
USER _CONS_COLUMN - �������� �÷� ����(��_

�÷�Ȯ��
��
SELECT*
DESC
USER_TAB_COLUMNS
WHERE TABLE_NAME = 'emp';

SELECT 'SELECT* FROM ' || TABLE


���̺�, �÷� �ּ� - USER_TAB_COMMENTS, USER_COL_COMMENTS;

SELECT*
FROM user_tab_comments;

�Ǽ� ���񽺼� ���Ǵ� ���̺��� ���� ���ʰ��� �������ʴ� ��찡 ����.


���̺��� �ּ� �����ϱ�
���� - COMMENTS ON TABLE ���̺�� IS '�ּ�';

emp ���̺� �ּ� �����ϱ�
COMMENT ON TABLE emp IS 'Slave';

SELECT*
FROM emp;

�÷��ּ�Ȯ��
SELECT*
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

�÷� �ּ� ����
COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�';

empno, ename, hiredate

COMMENT ON COLUMN EMP.EMPNO IS '���';
COMMENT ON COLUMN EMP.ENAME IS '�̸�';
COMMENT ON COLUMN EMP.HIREDATE IS '�Ի�����';

SELECT *
FROM user_col_comments,user_tab_comments
WHERE TABLE_NAME IN ('CYCLE','CUSTOMER','DAILY','PRODUCT')
AND USER_COL_COMMENTS.TABLE_NAME = USER_TAB_COMMENTS.TABLE_NAME;

SELECT t.*, c.COMMENTS, c.COLUMN_NAME
FROM user_tab_comments t ,user_col_comments c
WHERE t.TABLE_NAME = c.TABLE_NAME
AND t.TABLE_NAME IN ('CYCLE','CUSTOMER','DAILY','PRODUCT');


View�� ������~~~~
������ ������ ���� = SQL
�������� ������ ������ �ƴϴ�

view ��� �뵵
-������ ����(���ʿ��� �÷� ������ ����)
-���ֻ���ϴ� ������ ���� ����
-IN-LINE VIEW�� ����ص� ������ ����� ����� ���� ������ MAIN ������ ������� ������ �ִ�.

view�� �����ϱ� ���ؼ��� CREATE VIEW ������ ���� �־�� �Ѵ�(DBA����)

SYSTEM ������ ����
GRANT CREATE VIEW TO ����������� �ο��� ������;

���� - CREATE [OR REPLACE] VIEW ���̸� [�÷���Ī1,�÷���Ī2....] AS
        SELECT ����;
        
emp ���̺��� sal, comm �÷��� ������ 6���� �÷��� ��ȸ�� ������ v_emp view�� ����

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

view (v_emp)�� ���� ������ ��ȸ
SELECT*
FROM v_emp;

v_emp view�� kb���� ����
HR�������� �λ� �ý��� ������ ���� emp���̺��� �ƴ� sal,comm��ȸ�� ���ѵ�
v_emp view�� ��ȸ�Ҽ� �ֵ��� ���� �ο�

[hr������������]���Ѻο��� HR �������� v_emp ��ȸ
SELECT*
FROM kb.v_emp;

[kb������������]kb�������� hr�������� v_emp view�� ��ȸ�Ҽ� �ִ� ���� �ο�
GRANT SELECT ON v_emp TO hr;

[hr������������]v_emp view ������ hr ������ �ο��� ���� ��ȸ�׽�Ʈ
SELECT*
FROM kb.v_emp;

�ǽ�
v_emp_dept �並 ����
emp, dept ���̺��� deptno�÷����� �����ϰ�
emp.empno, ename, dept.deptno, dname 4���� �÷����� ����

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT emp.empno, ename, DEPT.DEPTNO, dname
FROM emp,dept
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT*
FROM v_emp_dept;

VIEW ����
DROP VIEW �� �̸�

VIEW�� ���� DML ó��
SIMPLE VIEW�� ���� ����

SIMPLE VIEW - ���ε��� �ʰ�, �Լ�, GROUP BY, ROWNUM�� ������� ���� ������ ������ VIEW
COMPLEX VIEW - SIMPLE VIEW�� �ƴ� ����

v_emp - SIMPLE VIEW

SELECT*
FROM v_emp;

v_emp�� ���� SMITH�� brown���� ����
UPDATE v_emp SET ename = 'brown'
WHERE empno = 7369;

SELECT*
FROM emp;

v_emp�÷����� sal �÷��� �������� �ʱ� ������ ����
UPDATE v_emp SET sal = 1000
WHERE empno = 7369;

ROLLBACK;

SEQUENCE
������ �������� �������ִ� ����Ŭ ��ü
�����ĺ��� ���� ������ �� �ַ� ���

�ĺ��� => �ش� ���� �����ϰ� ������ �� �ִ� ��
���� <=> ���� �ĺ���

���� - ���� �׷��Ѱ�
���� - �ٸ糽 ��

�Ϲ������� � ���̺�(����Ƽ) �� �ĺ��ڸ� ���ϴ� �����
����,����,������

�Խ����� �Խñ� - �Խñ� �ۼ��ڰ� ���� ����� �ۼ� �ߴ���
�Խñ��� �ĺ��� - �ۼ��� ID, �ۼ�����, ������
 ==> ���� �ĺ��ڰ� �ʹ� �����ϱ� ������ ������ ���̼��� ����
    ���� �ĺ��ڸ� ��ü�Ҽ� �ִ�(�ߺ����� �ʴ�) ���� �ĺ��ڸ� ���

������ �ϴٺ��� ������ ���� �����ؾ� �� ���� ����
ex) ���, �й�, �Խñ� ��ȣ
    ���, �й� - ü�谡 ����
    ��� - 15101001 ȸ�簡 �������� 15, 10�� 10�� �ش糯¥�� ù��° �Ի��ѻ��
    �Խñ۹�ȣ - ü�谡..., ��ġ�� �ʴ� ����
    
    ü�谡 �ִ� ���� �ڵ�ȭ�Ǳ� ���ٴ� ����� ���� Ÿ�� ��찡 ����
    ü�谡 ���� ���� �ڵ�ȭ�� �����ϴ� =>SEQUENCE ��ü�� Ȱ���Ͽ� �ս��� ��������
                                        =>�ߺ����� �ʴ� ���� ���� ��ȯ

�ߺ����� �ʴ� ���� �����ϴ� ���
1. KEY TABLE �� ����
    =>SELECT FOR UPDATE �ٸ� ����� ���ÿ� ������� ���ϵ��� ���°� ����
    =>���� ���� ���� ��, ������ ���� �̻ڰ�?  �����ϴ°� ����(SEQUENCE������ �Ұ���)
    
2. JAVA�� UUID Ŭ������ Ȱ��, ������ ���̺귯�� Ȱ��(����) => ������, ����, ī��

3. ORACLE DB - SEQUENCE



SEQUENCE ����
���� - CREATE SEQUENCE ������ ��

seq_emp��� �������� ����
CREATE SEQUENCE seq_emp;

���� - ��ü���� �������ִ� �Լ��� ���� ���� �޾ƿ´�
NEXTVAL - �������� ���� ���ο� ���� �޾ƿ´�
CURRVAL - ������ ��ü�� NEXTVAL�� ���� ���� ���� �ٽ��ѹ� Ȯ���� �� ���
            (Ʈ����ǿ��� NEXTVAL �����ϰ� ���� ����� ����)
;
SELECT seq_emp.NEXTVAL
FROM dual;

SELECT seq_emp.CURRVAL
FROM dual;

SELECT*
FROM emp_test;

SEQUENCE�� ���� �ߺ����� �ʴ� empno �� �����Ͽ� insert �ϱ�
�Ʒ� ������ ������ ����;
INSERT INTO emp_test VALUES(seq_emp.NEXTVAL, 'sally', 88);


































