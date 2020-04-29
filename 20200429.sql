OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<===>
INNER JOIN(�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN    : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp���̺��� �÷��� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� INNER JOIN ó����
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ��.

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�

������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�.
==KING�� ����� ������ NULL�̱� ������ ���ο� �����ϰ�
KING�� ������ ������ �ʴ´�(emp 14 == 
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

���� ������ OUTER �������� ����
(KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������,
������ ����� ������ ���� ������ ������ �ʴ´�.)
ANSI-SQL : OUTER;
SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp m LEFT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACLE-SQL : OUTER
oracle join
1.FROM���� ������ ���̺� ���(�޸��� ����)
2.WHERE���� ���� ���� ���
3.���� �÷�(�����)�� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ� �ش�
==> ������ ���̺� �ݴ����� ���̺��� �÷�

SELECT m.empno, m.ename, e.empno, e.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ
������ ����� �̸�, ���̵� �����Ͽ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸
������  ON���� ���������; - OUTER������ �ϰ���� ���̶�� ������ ON���� �����ϴ°� �´�.
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND e.deptno = 10);
������ WHERE���� ���������; - 
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno );
WHERE e.deptno = 10;
����Ŭ
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+) 
AND e.deptno = 10;

outerjoin1;
SELECT*
FROM buyprod
WHERE buy_date = TO_DATE('2005/01/25','YYYY/MM/DD');
����Ŭ����
SELECT b.BUY_DATE, b.BUY_PROD, p.PROD_ID, p.PROD_NAME, b.BUY_QTY
FROM buyprod b, prod p 
WHERE b.buy_date(+) = TO_DATE('2005/01/25','YYYY/MM/DD')
AND p.PROD_ID = b.BUY_PROD(+);
�Ƚù���
SELECT b.BUY_DATE, b.BUY_PROD, p.PROD_ID, p.PROD_NAME, b.BUY_QTY
FROM prod p LEFT OUTER JOIN buyprod b ON (p.prod_id = b.buy_prod 
AND b.buy_date = TO_DATE('2005/01/25','YYYY/MM/DD'));

outerjoin2;
SELECT TO_DATE('2005/01/25','YYYY/MM/DD') BUY_DATE, b.BUY_PROD, p.PROD_ID, p.PROD_NAME, b.BUY_QTY
FROM buyprod b, prod p 
WHERE b.buy_date(+) = TO_DATE('2005/01/25','YYYY/MM/DD')
AND p.PROD_ID = b.BUY_PROD(+);

outerjoin3;
SELECT TO_DATE('2005/01/25','YYYY/MM/DD') BUY_DATE, b.BUY_PROD, p.PROD_ID, p.PROD_NAME, NVL(b.BUY_QTY, 0) buy_qty
FROM buyprod b, prod p 
WHERE b.buy_date(+) = TO_DATE('2005/01/25','YYYY/MM/DD')
AND p.PROD_ID = b.BUY_PROD(+);

outerjoin4;
SELECT p.PID,p.PNM,c.CID,c.DAY,c.CNT
FROM cycle c, product p
WHERE p.PID = c.PID(+)
AND c.CID(+) = 1;

SELECT p.PID,p.PNM,1 CID,NVL(c.DAY,0) day,NVL(c.CNT,0) cnt
FROM product p LEFT OUTER JOIN cycle c ON (p.PID = c.PID AND c.CID = 1);

outerjoin5;
SELECT p.PID,p.PNM, c.CID, cu.CNM, c.DAY, c.CNT
FROM cycle c, product p, customer cu
WHERE c.PID = p.PID
AND cu.CID = c.CID
AND cu.cid = 1;

SELECT*
FROM product, cycle, customer
WHERE product.PID = cycle.PID
AND cycle.CID = customer.CID;

CROSS JOIN
���� ������ ������� ���� ���
��� ������ ���� �������� ����� ��ȸ�ȴ�
emp 14* dept 4 = 56

ANSI
SELECT*
FROM emp CROSS JOIN dept;
ORACLE(�������̺� ����ϰ� WHERE���� ������ ������� �ʴ´�)
SELECT*
FROM emp,dept;
crossjoin1;
SELECT*
FROM customer, product;

��������
WHERE : ������ �����ϴ� �ุ ��ȸ�ǵ��� ����

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1.SELECT
    SCALAR SUB QUERY
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� 1���� �÷��̾�� �Ѵ�. EX) dual���̺�
2.FROM
    INLINE-VIEW
    SELECT ������ ()�� ���� ��
3.WHERE
    SUB QUERY
    WHERE ���� ���� ����
    
SMITH�� ���� �μ��� ���� �������� ���� ������?
1.SMITH�� ���� �μ��� �������?
2.1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ
==>�������� 2���� ������ ���� ����
    �ι�° ������ ù��° ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�.
    (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 20������ 30������ ������ ���� ==> �������� ���鿡�� ���� ����)
    
ù��° ����;
SELECT deptno
FROM emp
WHERE ename = 'SMITH');

�ι�° ����
SELECT *
FROM emp
WHERE deptno = 20;

���������� ���� ���� ����

SELECT *
FROM emp;
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'WARD');
                
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT ROUND(AVG(sal),2)
                            FROM emp);
