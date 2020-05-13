CREATE TABLE dept_test2 AS
SELECT*
FROM dept
WHERE 1=1;

1
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2(deptno);
CREATE INDEX idx_u_dept_test2_02 ON dept_test2(dname);
CREATE INDEX idx_u_dept_test2_03 ON dept_test2(deptno,dname);

2
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_u_dept_test2_02;
DROP INDEX idx_u_dept_test2_03;

3
CREATE UNIQUE INDEX idx_emp_test_01 ON emp (empno);
CREATE INDEX idx_emp_test_02 ON emp (deptno);
CREATE INDEX idx_emp_test_03 ON emp (ename);
x


�����ȹ
�����ð��� ��� ���� 
Inner Join - ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ���
Outer Join - ���ο� �����ص� �����̵Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
Cross Join - ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾ� ���ᰡ���� ��� ����� ���� ���εǴ� ���
Self Join - ���� ���̺� ���� ���� �ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û �ϸ� DBMS�� SQL�� �м��Ͽ�
��� �� ���̺��� ������ ���� ����, 3���� ����� ���� ���(������ ���� ���, ����� �̾߱�)
1.NESTED LOOP JOIN
2.SORT MERGE JOIN
3.HASH JOIN

OLTP(OnLine Transaction Processing) - �ǽð� ó�� => ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
OLAP(OnLine Analysis Processing) - �ϰ�ó�� => ��ü ó���ӵ��� �߿� �� ���(���� ���� ���, ���� �ѹ��� ���)


