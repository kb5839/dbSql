dt �÷��� ����� ������ �ߺ��� �����ؼ� ��ȸ�ϴ�

dt �÷����� �����Ͱ� 5/8 ~ 6/7�� �ش��ϴ� ����Ʈ Ÿ�� �ڷᰡ ����Ǿ� �ִµ�
5/1 ~ 5/31�� �ش��ϴ� ��¥(�����)�� �ߺ����� ��ȸ�ϰ� �ʹ�
���ϴ� ��� - 5/8 ~5/31 �ִ� 24���� ���� ��ȸ�ϰ� ���� ��Ȳ

SELECT TO_CHAR(dt,'YYYYMMDD'), COUNT(*)
FROM gis_dt
WHERE dt BETWEEN TO_DATE ('20200508' , 'YYYYMMDD') AND TO_DATE('20200531 23:59:59','YYYYMMDD HH24:MI:SS')
GROUP BY TO_CHAR(dt,'YYYYMMDD')
ORDER BY dt DESC;

�츮�� ���ϴ� ���� �ִ� ���� ��� -

SELECT TO_CHAR(d,'YYYYMMDD')
FROM
(SELECT TO_DATE('20200501','YYYYMMDD') + (LEVEL-1) d
FROM dual
CONNECT BY LEVEL <= 31) a
WHERE EXISTS (SELECT 'X'
FROM gis_dt
WHERE dt BETWEEN TO_DATE(TO_CHAR(d,'YYYYMMDD') || '00:00:00','YYYYMMDDHH24:MI:SS') AND 
TO_DATE(TO_CHAR(d,'YYYYMMDD') || '23:59:59','YYYYMMDDHH24:MI:SS'));

PL/SQL => PL/SQL�� �����ϴ� ���� ����Ŭ ��ü
        �ڵ� ��ü�� ����Ŭ�� ����(����Ŭ ��ü�ϱ�)
        ������ �ٲ� �Ϲ� ���α׷��� ���� ���� �� �ʿ䰡 ����
        
SQL => SQL ���ष�� �Ϲ� ���� ����(java)
    ���� SQL�� ���õ� ������ �ٲ�� java������ ������ ���ɼ��� ŭ
    
PL/SQL - Procedual Laguage / Structured Query Language
SQL - ������, ������ ����(�̺��ϰ� ����, CASE, DECODE..)

������ �ϴٺ��� � ���ǿ� ���� ��ȸ�ؾ��� ���̺� ��ü�� �ٲ�ų�, ������ ��ŵ�ϴ� ���� �������� �κ��� �ʿ� �� ���� ����

�������� - �ҵ��� 25%�� �ſ�ī�� + ���ݿ����� + üũī��� �Һ�
�Һ� �ݾ��� �ҵ��� 25%�� �ʰ��ϴ� �ݾ׿� ���ؼ� 
�ſ�ī��� ���� - 20%, ���ݿ����� 30%, üũī�� 25%�� �����ϴ�
�� �����ݾ��� 300������ ������ ����
�� ���߱��뿡 ���� �߰������� 100������ ���� ������ �ְ�
�� ������忡 ���ݿ� ���ؼ��� �߰������� 100������ ���� ������ �ִ�.

DBMS�󿡼� ���Ͱ��� ������ ������ SQL�� �ۼ��ϴµ��� ������ ����(��������)
�Ϲ����� ���α׷��� ���� ����ϴ� ��������(if, case), �ݺ���(for,while), �������� Ȱ�� �Ҽ� �ִ� PL/SQL�� ���大������~

*���� - �򰥸�~

java���� sysout => console�� ���
PL/SQL���� ����
SET SERVEROUTPUT ON; �α׸� �ܼ�â�� ��°����ϰԲ� �ϴ� ����

PL/SQL block�� �⺻����
DECLARE - �����(���� ���� ����, ��������)
BEGIN - �����(������ �����Ǵ� �κ�)
EXCEPTION - ���ܺ�(���ܰ� �߻� ������ CATCH�Ͽ� �ٸ� ������ �����ϴ� �κ�(java try-catch)

PL/SQL �͸�(�̸��� ����,��ȸ��) ��
SET SERVEROUTPUT ON;
DECLARE
   -- JAVJ - ����TYPE ������
  --  PL/SQL - ������ ����TYPE
    
    v_deptno NUMBER(2);
    v_dname VARCHAR2(14);
BEGIN
   -- dept ���̺��� 10�� �μ��� �ش��ϴ� �μ���ȣ, �μ����� DECLARE���� ������ �ΰ��� ������ ���
    
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' ' || v_dname); --�ڹ��� so
END;
/
������ Ÿ�� ����
v_deptno, v_dname �ΰ��� ���� ���� => dept ���̺��� �÷� ���� �������� ����
                                =>dept ���̺��� �÷� ������ Ÿ�԰� �����ϰ� ���� �ϰ� ���� ��Ȳ
������ Ÿ���� ���� �������� �ʰ� ���̺��� �÷� Ÿ���� ����  �ϵ��� ���� �Ҽ� �ִ�
=>���̺� ������ �ٲ� pl/sql ��Ͽ� ����� ������ Ÿ���� �������� �ʾƵ� �ڵ����� ����ȴ�.

���̺��.�÷���%TYPE;

DECLARE
  v_deptno dept.deptno%TYPE;
  v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' ' || v_dname);
END;
/

��¥�� �Է¹޾� => ��ȸ���� �����ϱ������� 5�ϵ��� ��¥�� �����ϴ� �Լ�
ȸ�縸�� Ư���� ������ �ʿ��� ��� �Լ��� ���� �� �ִ�.

PROCEDURE - �̸��� �ִ� PL/SQL ��, ���ϰ��� ����
            ������ ���� ó���� �����͸� �ٸ� ���̺� �Է��ϴ� ����
            �����Ͻ� ������ ó���� �� ���
            ����Ŭ ��ü => ����Ŭ ������ ������ �ȴ�
            ������ �ִ� ������� ���ν��� �̸��� ���� ������ ����
            
            
CREATE OR REPLACE PROCEDURE printdept (p_deptno IN dept.deptno%TYPE) IS 
v_deptno dept.deptno%TYPE;
v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE( v_deptno || '  ' || v_dname);
END;
/

���ν��� ���� ��� - EXEC ���ν����̸�

EXEC printdept;

���ڰ� �ִ� printdept ����
EXEC printdept(20);


PL/SQL ������ SELECT ������ ���� ���� �� �����Ͱ� �Ѱǵ� �ȳ��� ��� NO_DATA_FOUND ���ܸ� ������

CREATE OR REPLACE PROCEDURE printemp (p_empno IN emp.empno%TYPE) IS 
v_ename emp.ename%TYPE;
v_dname dept.dname%TYPE;
BEGIN
    SELECT ename, dname INTO v_ename, v_dname
    FROM dept, emp
    WHERE empno = p_empno
    AND emp.deptno = dept.deptno;
    
    DBMS_OUTPUT.PUT_LINE( v_ename || '  ' || v_dname);
END;
/
EXEC printemp(7499);

CREATE OR REPLACE PROCEDURE registdept_test (p_test IN (DEPT_TEST.DEPTNO%TYPE,dept_test.dname%TYPE,dept_test.loc%TYPE)) IS 
v_deptno DEPT_TEST.DEPTNO%TYPE;
v_dname dept_test.dname%TYPE;
v_loc dept_test.loc%TYPE;
BEGIN
    INSERT deptno, dname, loc INTO v_deptno, v_dname, v_loc
    FROM dept_test;
    
    EXEC registdept_test(99,'ddit', 'daejeon');
END;
/

SELECT*
FROM dept_test;

CREATE OR REPLACE PROCEDURE registdept_test (p_deptno IN dept.deptno%TYPE, 
p_dname IN dept.dname%TYPE, p_loc IN DEPT.LOC%TYPE) IS 

BEGIN
    INSERT INTO dept_test VALUES(p_deptno, p_dname, p_loc);
  
END;
/

EXEC registdept_test(99,'ddit', 'daejeon');

SELECT*
FROM dept_test;

UPDATE dept_test SET (deptno,dname,loc) = (99,'ddid','daejeon');

���պ���
��ȸ����� �÷��� �ϳ��� ������ ��� �۾� ���ŷӴ� => ���� ������ ����Ͽ� �������� �ؼ�
1.%ROWTYPE - Ư�� ���̺��� ���� ��� �÷��� ������ �� �ִ� ���� ���� Ÿ��
(���� %TYPE - Ư�� ���̺��� �÷� Ÿ���� ����)
2.PL/SQL RECORD - ���� ������ �� �ִ� Ÿ��, �÷��� �����ڰ� ���� ���
                    ���̺��� ��� �÷��� ����ϴ°� �ƴ϶� �÷��� �Ϻθ� ����ϰ� ���� ��
3.PL/SQL TABLE TYPE - �������� ��, �÷��� ������ �� �ִ� Ÿ��

%ROWTYPE
�͸������ dept ���̺��� 10�� �μ������� ��ȸ�Ͽ� %ROWTYPE���� ������ ������ ������� �����ϰ�
DBMS_OUTPUT.PUT_LINE�� �̿��Ͽ� ���

DECLARE
v_dept_row dept%ROWTYPE;
BEGIN
SELECT* INTO v_dept_row
FROM dept
WHERE deptno = 10;

 DBMS_OUTPUT_PUT_LINE(v_dept_row.deptno || ' / ' || v_dept_row.dname || ' / ' || v_dept_row_loc );

END;
/

2.record - ���� �����Ҽ� �ִ� ����Ÿ��, �÷� ������ �����ڰ� ���� ������ �� �ִ�.
dept���̺��� deptno, dname �ΰ� �÷��� �� ������ �����ϰ� ���� ��


DECLARE
--deptno, dname �÷� �ΰ��� ���� ������ �� �ִ� TYPE ����
TYPE dept_rec IS RECORD(
deptno DEPT.DEPTNO%TYPE,
dname DEPT.DNAME%TYPE);
--���Ӱ� Ÿ������ ������ ����(class ����� �ν��Ͻ� ����)
v_dept_rec dept_rec;
BEGIN
SELECT deptno, dname INTO v_dept_rec
FROM dept
WHERE deptno = 10;
DBMS_OUTPUT.PUT_LINE ( v_dept_rec.deptno || ' / ' || v_dept_rec.dname);
END;
/

�������� ������ �� ��
SELECT ����� �������̱� ������ �ϳ��� �� ������ ������ �ִ� ROWTYPE �������� ����
������ ���� ���� �߻�
=> ���� ���� �����Ҽ� �ִ� TABLE TYPE ���

DECLARE
    v_dept_row dept%ROWTYPE;
BEGIN
    SELECT* INTO v_dept_row
    FROM dept;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno ||
            ' / ' || v_dept_row.dname || ' / ' || v_dept_row.loc);
END;
/

TABLE TYPE - �������� �����Ҽ� �ִ� Ÿ��
���� - TYPE Ÿ�Ը� IS TABLE OF �� Ÿ�� INDEX BY �ε��� Ÿ��;
dept ���̺��� �� ������ �����Ҽ� �ִ� ���̺� TYPE
List<Dept> dept_tab = new Arraylist<Dept>();
int[] intArray = new int[50];
java������ �ε����� ����

PL/SQL ������ �ΰ��� Ÿ������ ���� - ����(BINARY_INTEGER), ���ڿ�(VARCHAR(2))

TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER 

DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept dept_tab;
BEGIN
    SELECT* BULK COLLECT INTO v_dept
    FROM dept;
END;
/