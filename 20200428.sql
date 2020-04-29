SELECT empno,
FROM emp
WHERE emp.deptno = dept.deptno
AND sal > 2500
AND empno > 7600
AND dname = 'RESEARCH';

exerd
join1
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM lprod, prod
WHERE lprod.lprod_gu = prod.prod_lgu;

join2 결과 건수를 구하는 SQL
74 ==> 1
건수 ==> COUNT

SELECT COUNT(*)
FROM
(SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer, prod
WHERE prod.prod_buyer = buyer.buyer_id);

SELECT COUNT(*)
FROM lprod, prod
WHERE lprod.lprod_gu = prod.prod_lgu;

SELECT buyer.buyer_name, COUNT(*)
FROM buyer, prod
WHERE prod.prod_buyer = buyer.buyer_id
GROUP BY buyer.buyer_name;

join3
SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name,cart.cart_qty
FROM member,cart,prod
WHERE member.mem_id = cart.cart_member
AND cart.cart_prod = prod.prod_id;

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name,cart.cart_qty
FROM member JOIN cart ON (member.mem_id = cart.cart_member) 
            JOIN prod ON (cart.cart_prod = prod.prod_id);
WHERE 
AND cart.cart_prod = prod.prod_id;

참고사항
SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno;

SELECT*
FROM customer;

pid : product id
pnm : product name
SELECT *
FROM product;

cycle : 애음주기
cid : 고객id
pid : 제품id
day : 애음요일
cnt : 수량 
SELECT *
FROM cycle;
join4 오라클
SELECT *
FROM customer, cycle
WHERE customer.cnm IN ('brown','sally')
AND customer.cid = cycle.cid;
join4 ANSI
SELECT cid, cnm, pid, day, cnt
FROM customer NATURAL JOIN cycle
WHERE customer.cnm IN ('brown','sally');
join5
SELECT customer.CID, customer.CNM,product.PID,product.PNM,cycle.day,cycle.CNT
FROM customer, cycle, product
WHERE customer.cnm IN ('brown','sally')
AND customer.cid = cycle.cid
AND cycle.PID = product.PID;
join6
SELECT customer.CID, customer.CNM,product.PID,product.PNM,SUM(cycle.CNT)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.PID = product.PID
GROUP BY customer.CID, customer.CNM,product.PID,product.PNM
ORDER BY cid;
join7
SELECT product.PID,product.PNM,SUM(cycle.CNT) CNT
FROM cycle, product
WHERE cycle.PID = product.PID
GROUP BY product.PID,product.PNM
ORDER BY pnm;
