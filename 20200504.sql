������

��Ģ ������ : +,-,*,/ : ���� ������
���� ������ : ? 1==1 ? true�� �� ���� : false �� �� ����

SQL ������
= : �÷�|ǥ���� = �� ==> ���� ������
    =1
IN : �÷�|ǥ���� IN (����)
 deptno IN (10,30) ==> IN(10,30), deptno (10,30)
 
EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

���������� ���� ���� ���� ���������� ���� ����� �׻� ���� �ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ�ȴ�.

�Ʒ� ������ ���ȣ ��������
�Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� ���̻� Ž���� ���� �ʰ� �ߴ�.
���� ���� ���ο� ������ ���� �� ���
SELECT*
FROM emp
WHERE EXISTS (SELECT 'X' FROM dept);

�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ���� : 14-KING = 13���� ����

SELECT*
FROM emp e
WHERE EXISTS (SELECT 'X' FROM emp m WHERE e.mgr = m.empno);

IS NOT NULL�� ���� ������ ����� ����� �ִ�
SELECT*
FROM emp
WHERE mgr IS NOT NULL;

sub9
cycle, product ���̺��� �̿��Ͽ� cid = 1 �� ���� �����ϴ� ��ǰ��
��ȸ�ϴ� ������ EXISTS �����ڸ� �̿��Ͽ� �ۼ��ϼ���
SELECT p.pid, p.pnm
FROM product p
WHERE EXISTS (SELECT* FROM cycle WHERE cycle.cid =1 AND CYCLE.PID = p.pid);

sub10
cycle, product ���̺��� �̿��Ͽ� cid = 1 �� ���� ���������ʴ� ��ǰ��
��ȸ�ϴ� ������ EXISTS �����ڸ� �̿��Ͽ� �ۼ��ϼ���
SELECT p.pid, p.pnm
FROM product p
WHERE NOT EXISTS (SELECT* FROM cycle WHERE cycle.cid =1 AND CYCLE.PID = p.pid);

���տ���
{1,5,3} U {2,3} = {1,2,3,5}
{1,5,3} ������ {2,3} = {3}
{1,5,3} - {2,3} = {1,5}
SQL���� �����ϴ� UNINO ALL(�ߺ� �����͸� ���� ���� �ʴ´�)
{1,5,3} U {2,3} = {1,5,3,2,3}

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL

UNION ������ : �ߺ�����(������ ������ ���հ� ����)
SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

UNION

SELECT empno,ename
FROM emp
WHERE empno IN (7566,7698)

UNION ALL������ : �ߺ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

UNION ALL

SELECT empno,ename
FROM emp
WHERE empno IN (7566,7698)

INTERSECT ������ : �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

INTERSECT

SELECT empno,ename
FROM emp
WHERE empno IN (7566,7698)

MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566,7698,7369)

MINUS

SELECT empno,ename
FROM emp
WHERE empno IN (7566,7698)

SQL ���տ������� Ư¡

���� �̸� : ù��° SQL�� �÷��� ���󰣴�

SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)
UNION
SELECT ename, empno
FROM emp
WHERE empno IN(7698)

2.������ �ϰ���� ��� �������� ���� ����
    ���� SQL���� ORDER BY ���Ұ�(�ζ��� �並 ����Ͽ� ������������ ORDER BY�� ������� ������ ����)

SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)
--ORDER BY nm, �߰������� ���ĺҰ�
UNION
SELECT ename, empno
FROM emp
WHERE empno IN(7698)
ORDER BY nm

3.SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�(������ ���� ����� ����),�� UNION ALL�� �ߺ����

4.�ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
    =>����ڿ��� ����� �����ִ� �������� ������
    =>UNION ALL�� ����� �� �ִ�
4.�˰���(����- ���� ����, ���� ����,
            �ڷ� ���� : Ʈ������(���� Ʈ��,�뷱�� Ʈ��)
                        heap
                        stack, queue
                        lust
���տ��꿡�� �߿��� ���� : �ߺ�����

�� ������ ���� ������(����ŷ�� ���� + �Ƶ������� ���� + KFC�� ����)/�Ե����� ������
����Ͽ� ���� ���ü��� �� ������ ���ö�� �Ҽ� �ִ�.
;'����',fastfood.SIDO,fastfood.SIGUNGU,'���ù�������'
SELECT od.sido, od.sigungu, od.cnt/lo.cnt city
FROM
(SELECT sido,sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb IN ('����ŷ','KFC','�Ƶ�����')
GROUP BY sigungu, sido) od,

(SELECT sido,sigungu, COUNT(*) cnt
FROM fastfood
WHERE gb = '�Ե�����'
GROUP BY sigungu, sido) lo
ORDER BY city desc

SELECT*
FROM tax
����1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�
1. ���ù��������� ���ϰ�(������ ���� ���ð� ������ ����)
2.�δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
3.���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�

����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������, ����û �õ�,����û �ñ���,����û �������� �ݾ� 1�δ� �Ű��

����2] �ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ����Ͽ��µ� (fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺��� 1�������)
CASE, DECODE ���

����3] �ܹ������� SQL�� �ٸ����·� ����

���� SQL ���� : WHERE, �׷쿬���� ���� GROUP BY, ������ �Լ�(COUNT),
                �ζ��� ��, ROWNUM, ORDER BY, ��Ī(�÷�,���̺�),ROUND, JOIN