SELECT * --��� �÷��� ������ ��ȸ
FROM PROD; --�����͸� ��ȸ�� ���̺� ���

--Ư�� �÷��� ���ؼ��� ��ȸ : SELECT �÷�1, �÷�2....
--prod_id, prod_name�÷��� prod ���̺��� ��ȸ

SELECT prod_id, prod_name
FROM prod;

SELECT * 
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;

SQL ���� : JAVA�ʹ� �ٸ��� ����X, �Ϲ��� ��������

SQL ������ Ÿ�� : ����, ����, ��¥(date)

USERS ���̺��� (4/14 ������) ����
USERS ���̺��� ��絥���� ��ȸ

��¥ Ÿ�Կ� ���� ���� : ��¥�� +,- ���� ����
date type + ���� : date���� ������¥��ŭ �̷� ��¥�� �̵�
date type - ���� : date���� ������¥��ŭ ���� ��¥�� �̵�

SELECT userid, reg_dt + 5
FROM users;

�÷� ��Ī : ���� �÷����� ���� �ϰ� ������
syntax : ���� �÷��� [as] ��Ī��Ī
��Ī��Ī�� ������ ������ �ȵǸ�, ������ ǥ���Ǿ�� �� ��� ���� �����̼����� ���´�
���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ��� ���� �����̼��� ����Ѵ�.

SELECT userid id1
FROM users;

SELECT prod_id id, prod_name name
FROM prod;

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;

���ڿ� ����;
SELECT userid || 'test', reg_dt
FROM users;

SELECT userid||usernm
FROM users;

user_tables : oracle���� �����ϴ� ���̺� ������ ��� �ִ� ���̺�(view) ==> data dictionary
SELECT *
FROM user_tables;

SELECT 'SELECT * FROM ' ||table_name|| ';' query 
FROM user_tables;

���̺��� ���� �÷��� Ȯ��
1.tool(sql developer)�� ���� Ȯ��
    ���̺� - Ȯ���ϰ��� �ϴ� ���̺�
2.SELECT *
    FROM ���̺�
    �ϴ� ��ü ��ȸ ==> ��� �÷��� ǥ��
3.DESC ���̺��
4.data dictionary : user_tab_columns

DESC emp;

SELECT *
FROM user_tab_columns;

���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �÷� ��� : SELECT
��ȸ�ϰ��� �ϴ� ���̺� ��� : FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
WHERE ���� ����� ������ ��(TRUE)�� �� ����� ��ȸ

java�� �� ���� : a������ b������ ���� ������ �� ==
sql�� �� ���� : =
int a =5;
int b =2;
if(a == b)

SELECT *
FROM users
WHERE userid = 'con';

emp���̺��� �÷��� ������ Ÿ���� Ȯ��;

SELECT *
FROM EMP;

emp : employee
empno : �����ȣ
ename : ����̸�
job : ������(��å)
mgr : �����(������)
hiredate : �Ի���
sal : �޿�
comm : ������
deptno : �μ���ȣ

SELECT *
FROM dept;

emp ���̺��� ������ ���� �μ���ȣ�� 30�� ���� ū(>) �μ��� ���� ������ ��ȸ;

SELECT *
FROM emp
WHERE deptno > 30;

!= �ٸ���
users ���̺��� ����� ���̵�(userid)�� brown�� �ƴ� ����ڸ� ��ȸ
SELECT *
FROM users
WHERE userid != 'brown';

SQL���ͷ�
���� ; ...20,30.5
���� : �̱� �����̼� : 'Hello world'
��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ����')

SELECT *
FROM emp
WHERE hiredate <= TO_DATE('19820101', 'YYYYMMDD'); 