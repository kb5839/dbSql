SELECT ���� ���� :
��¥ ����(+-) : ��¥ + ����, -���� : ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
���� ����(..) : �����ð��� �ٷ��� ����...
���ڿ� ���� 
���ͷ� : ǥ����
        ���� ���ͷ� : ���ڷ� ǥ��
        ���� ���ͷ� : java : "���ڿ�" / sql 'sql'
            SELECT SELECT * FROM|| table_name
            SELECT 'SELECT * FROM' || table_name
            ���ڿ� ���տ��� : +�� �ƴ� || (java������ +)
            ��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ���� ����'
                TO_DATE('20200417', 'YYYYMMDD')

WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����

SELECT *
FROM users
WHERE userid = 'brown';

sal���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND
�񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000 AND sal <= 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101', 'YYYYMMDD') AND TO_DATE('19830101', 'YYYYMMDD');

IN ������
�÷� | Ư���� IN (��1,��2,....)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�� �ϸ� TURE

SELECT *
FROM emp
WHERE deptno IN (10,30);
==> deptno�� 10�̰ų� 30���� ����
deptno = 10 or deptno =30

SELECT *
FROM emp
WHERE deptno =10
OR deptno =30;   

SELECT userid ���̵�, usernm �̸�, alias ����
FROM users
WHERE userid IN('brown','cony','sally');

���ڿ� ��Ī ���� : LIKE ���� / JAVA : .startsWith(prefix) , .endsWith(suffix)
����ŷ ���ڿ� : % - ��� ���ڿ�(���� ����)
            _ - � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE

�÷� | Ư���� LIKE ���� ���ڿ�;
'cony' : cony�� ���ڿ�
'co%' : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� �� �ִ� ���ڿ� / 'cony', 'con', 'co'
'%co%' : co�� �����ϴ� ���ڿ� / 'cony', 'sally cony'
'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �ü� �ִ� ���ڿ�

���� �̸�(ename)�� �빮�� S�� �����ϴ� ������ ��ȸ

SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';


NULL ��
SQL �񱳿����� : =
    WHERE usernm = 'brown'

MGR�÷� ���� ���� ��� ������ ��ȸ    
SELECT *
FROM emp
WHERE mgr IS NULL;

SQL���� NULL ���� ���� ��� �Ϲ����� �񱳿�����(=)�� ������� ���ϸ�
            IS �����ڸ� ����Ѵ�.

���� �ִ� ��Ȳ���� � �� : =, !=, <>
NULL : IS NULL , IS NOT NULL

emp���̺��� mgr �÷� ���� NULL�� �ƴ� ������ ��ȸ

SELECT *
FROM emp
WHERE comm IS NOT NULL;

IN �����ڸ� �񱳿����ڷ� ����
SELECT*
FROM emp
WHERE mgr IN(7698,7839);
==> WHERE mgr = 7698 OR mgr = 7839

SELECT*
FROM emp
WHERE mgr NOT IN(7698,7839);
==> WHERE (mgr != 7698 AND mgr != 7839)

SELECT*
FROM emp
WHERE job = 'SALESMAN' AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT*
FROM emp
WHERE deptno != 10 AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT*
FROM emp
WHERE deptno NOT IN 10 AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT*
FROM emp
WHERE deptno IN (20,30) AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT*
FROM emp
WHERE job = 'SALESMAN' OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno LIKE '78%';  

SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno >= 7800 AND empno < 7900;  

SELECT*
FROM emp
WHERE job = 'SALESMAN' OR empno >= 7800 AND empno < 7900 AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

���� : {a,b,c} == {a,c,b}
table���� ��ȸ, ����� ������ ����.(�������� ����)
==> ���нð��� ���հ� ������ ����

SQL������ �����͸� �����Ϸ��� ������ ������ �ʿ��ϴ�.
ORDER BY �÷���[��������], �÷���2 [��������]

������ ���� : ��������(DEFAULT)- ASC , �������� - DESC

�����̸����� �������� ����
SELECT*
FROM emp
ORDER BY ename ASC;

�����̸����� �������� ����
SELECT*
FROM emp
ORDER BY ename DESC;

job�� �������� �������� �����ϰ� job�� ������� �Ի����ڷ� �������� ����
SELECT*
FROM emp
ORDER BY job ASC, hiredate DESC;


