# JOIN

-- SELECT <열 목록>
-- FROM <첫 번째 테이블>
-- 		INNER JOIN <두 번째 테이블>
-- 		ON <조인될 조건>
-- [WHERE 검색 조건]

USE market_db;

# 모든 열에 대해서 조회할 것인데, 
# buy 테이블과 member 테이블을 INNER JOIN 할 것이고, 
# mem_id 가 같은 것끼리 조인하도록 하며, 
# buy테이블의 mem_id 가 'APN' 인 것만 조회
SELECT *
	FROM buy
		INNER JOIN member
        ON buy.mem_id = member.mem_id
	WHERE buy.mem_id = 'APN';
    
# 모든 열에 대해서 조회할 것인데, 
# buy 테이블과 member 테이블을 INNER JOIN 할 것이고, 
# mem_id 가 같은 것끼리 조인해서 조회
SELECT *
	FROM buy
		INNER JOIN member
        ON buy.mem_id = member.mem_id;
        
# mem_id, mem_name, prod_name, addr, 연락처는 국번과 번호 합쳐서 조회할 것인데,
# buy 테이블과 member 테이블의 mem_id 가 같은것 끼리 INNER JOIN 해서 조회할 것
# 이때 SELECT 절의 mem_id 의 경우, buy 테이블이 것을 반환할지, member 테이블의 것을 반환 할지 지정해줘야함.
SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) AS '연락처'
	FROM buy
		INNER JOIN member
        ON buy.mem_id = member.mem_id;
        
# 하지만 명확하게 하기 위해서 조회할 데이터들의 컬럼명을 테이블명을 포함하여 정확히 지정해주는 것이 좋음
SELECT buy.mem_id, member.mem_name, buy.prod_name, addr, CONCAT(phone1, phone2) AS '연락처'
	FROM buy
		INNER JOIN member
        ON buy.mem_id = member.mem_id;
        
# 근데 이렇게 하면 너무 코드가 길어짐
# 그래서 테이블 이름에 alias(별명)을 줄 수 있음
SELECT b.mem_id, m.mem_name, b.prod_name, m.addr, CONCAT(phone1, phone2) AS '연락처'
	FROM buy b
		INNER JOIN member m
        ON b.mem_id = m.mem_id;

# 내부 조인의 한계는 위의 예시에서 buy 테이블과 member 테이블을 INNERE JOIN 했을 때, buy 테이블에 없는 member 면,
# 즉, 구매한적이 없는 member 는 아예 조회되지 않음.
# 즉, 내부 조인은 두 테이블에 모두 포함된, 조인되는 것만 반환함.
# 하지만 만약, 구매한 적이 없는 member 도 조회하여 '구매한적 없음!' 이런식으로 조회하길 원한다면?
# 즉, 두 테이블에 모두 포함되어 조인되는 것도 반환하고, 조인이 안되는 것들도(한쪽에만 잇는 것들도)반환하려면 외부 조인을 사용!!

# 외부 조인
-- SELECT <열 목록>
-- FROM <첫 번째 테이블(LEFT 테이블)>
-- 		<LEFT : RIGHT : FULL> OUTER JOIN <두 번째 테이블(RTGHT 테이블)>
-- 		ON <조인될 조건>
-- [WHERE 검색 조건];

# member 테이블 기준으로 LEFT OUTER JOIN
SELECT m.mem_id, m.mem_name, b.prod_name, m.addr
	FROM member m
		LEFT OUTER JOIN buy b
        ON m.mem_id = b.mem_id
	ORDER BY m.mem_id;
    
# buy 테이블 기준으로 RIGHT OUTER JOIN
SELECT m.mem_id, m.mem_name, b.prod_name, m.addr
	FROM member m
		RIGHT OUTER JOIN buy b
        ON m.mem_id = b.mem_id
	ORDER BY m.mem_id;
    
# 상호 조인 (CROSS JOIN)
# 상호 조인의 결과의 전체 행 갯수는, 두 테이블의 행의 개수를 곱한 개수임
# ON 구문이 없다.
# 결과의 내용은 의미가 없다. 랜덤으로 조인하기 때문
# 상호 조인의 주 용도는 테스트하기 위해 대용량의 데이터를 생성할 때 사용
SELECT *
FROM buy
	CROSS JOIN member;

# 상호 조인해서 테이블 생성하는 방법 -> 근데 buy 테이블과 member 테이블의 mem_id 컬럼명이 중복되어서 테이블 생성 불가
CREATE TABLE cross_table1
	SELECT *
		FROM buy b
			CROSS JOIN member m;

# 이러한 경우, 직접 데이터 컬럼을 선택해주면 생성 가능 
CREATE TABLE cross_table
	SELECT m.*, b.num, b.prod_name, b.group_name, b.price, b.amount
		FROM buy b
			CROSS JOIN member m;
            
SELECT * FROM cross_table;

# 자체 조인(SELF JOIN)
# 자체 조인은 1개의 테이블을 사용한다.
# 별도의 문법이 있는 것은 아니고, 1개로 조인하면 자체 조인이 되는 것이다.
-- SELECT <열 목록>
-- FROM <테이블> 별칭A
-- 		INNER JOIN <테이블> 별칭B
-- 		ON <조인될 조건>
-- [WHERE 검색 조건]
USE market_db;
CREATE TABLE emp_table (emp CHAR(4), manager CHAR(4), phone VARCHAR(8));

INSERT INTO emp_table VALUES('대표', NULL, '0000');
INSERT INTO emp_table VALUES('영업이사', '대표', '1111');
INSERT INTO emp_table VALUES('관리이사', '대표', '2222');
INSERT INTO emp_table VALUES('정보이사', '대표', '3333');
INSERT INTO emp_table VALUES('영업과장', '영업이사', '1111-1');
INSERT INTO emp_table VALUES('경리부장', '관리이사', '2222-1');
INSERT INTO emp_table VALUES('인사부장', '관리이사', '2222-2');
INSERT INTO emp_table VALUES('개발팀장', '정보이사', '3333-1');
INSERT INTO emp_table VALUES('개발주임', '정보이사', '3333-1-1');

# 경리부장의 직속상관의 번호를 알고 싶을때,
SELECT A.emp '직원', B.emp '직속상관', B.phone '직속상관연락처'
	FROM emp_table A
		INNER JOIN emp_table B
        ON A.manager = B.emp
	WHERE A.emp = '경리부장';