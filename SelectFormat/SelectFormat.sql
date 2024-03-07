# 기본적인 SELECT 절의 순서는 다음과 같다
-- SELECT 열 이름
-- FROM 테이블 이름
-- WHERE 조건식
-- GROUP BY 열 이름
-- HAVING 조건식
-- ORDER BY 열 이름
-- LIMIT 숫자


# ORDER BY
USE market_db;
# debut_date 기준으로 오름차순 정렬하여 조회
SELECT mem_id, mem_name, debut_date
FROM member
ORDER BY debut_date; # ASC 는 오름차순인데 생략 가능

# debut_date 기준으로 내림차순 정렬하여 mem_id, mem_name, debut_date를 조회
SELECT mem_id, mem_name, debut_date
FROM member
ORDER BY debut_date DESC;

# height가 164이상인 데이터의 mem_id, mem_name, debut_date, height를 조회, 
# 단, height 를 기준으로 내림차순 정렬
SELECT mem_id, mem_name, debut_date, height
FROM member
WHERE height >= 164
ORDER BY height DESC;

# height가 164이상인 데이터의 mem_id, mem_name, debut_date, height를 조회, 
# 단, height 를 기준으로 내림차순 정렬, 
# 만약 height 가 동률이라면, debut_date 를 기준으로 오름차순 정렬
SELECT mem_id, mem_name, debut_date, height
FROM member
WHERE height >= 164
ORDER BY height DESC, debut_date ASC;

# member 를 조회하는데, 앞의 3개의 행 데이터만 조회함
SELECT *
FROM member
LIMIT 3;

# 데뷔일자가 빠른 데이터의 mem_name, debut_date 를 앞에서 3개만 조회
SELECT mem_name, debut_date
FROM member
ORDER BY debut_date ASC
LIMIT 3;

# 키가 큰 순서로 정렬한 데이터의 mem_name, height 를 4번째 데이터부터 2개만 조회 
SELECT mem_name, height
FROM member
ORDER BY height DESC
LIMIT 3, 2;

# member 테이블의 addr 데이터를 조회
SELECT addr 
FROM member;

# member 테이블의 addr 데이터를 조회하는데, addr을 기준으로 오름차순 정렬
SELECT addr
FROM member
ORDER BY addr;

# member 테이블의 addr 데이터를 조회하는데, 중복된 데이터는 제거하고 조회
SELECT DISTINCT addr
FROM member;

# GROUP BY
# buy 테이블에서 mem_id, amount 를 조회하는데, mem_id를 기준으로 정렬해라
SELECT mem_id, amount
FROM buy
ORDER BY mem_id;

# buy 테이블에서 mem_id, amount 를 조회하는데, mem_id 를 기준으로 합쳐서 amount의 합계를 조회(1)
SELECT mem_id, SUM(amount)
FROM buy
GROUP BY mem_id;

# buy 테이블에서 mem_id, amount 를 조회하는데, mem_id 를 기준으로 합쳐서 amount의 합계를 조회(2)
# 별칭을 추가해서 깔끔하게 조회
SELECT mem_id '회원 아이디', SUM(amount) '총 구매 개수'
FROM buy
GROUP BY mem_id;

# mem_id 당 얼마를 썻는지 조회
# 별칭을 추가해서 깔끔하게 조회
SELECT mem_id '회원 아이디', SUM(price * amount) '총 구매 금액'
FROM buy
GROUP BY mem_id;

# 전체 회원의 평균 구매 개수 조회
SELECT AVG(amount) '평균 구매 개수'
FROM buy;

# mem_id 의 구매시 평균 구매 개수
SELECT mem_id, AVG(amount) '평균 구매 개수'
FROM buy
GROUP BY mem_id;

# 회원이 몇명인지 조회 (행 데이터의 갯수를 세는 것임)
SELECT COUNT(*)
FROM member;

# 연락처가 있는 회원의 수를 조회 (COUNT가 NULL인 것은 제외하고 수를 세어줌)
SELECT COUNT(phone1) '연락처가 있는 회원의 수' 
FROM member;

# 총 구매 금액이 1000 초과인 회원만 조회 --- GROUP BY 를 사용하는데 WHERE절에서 조건절을 사용해야한다면 HAVING 절을 사용할 것. 순서 유의
SELECT mem_id '회원 아이디', SUM(price * amount) '총 구매 금액'
FROM buy
GROUP BY mem_id
HAVING SUM(price * amount) > 1000;

# 총 구매 금액이 1000 초과인 회원만 조회하는데, 구매금액이 큰 순서대로 정렬해서 조회
SELECT mem_id '회원 아이디', SUM(price * amount) '총 구매 금액'
FROM buy
GROUP BY mem_id
HAVING SUM(price * amount) > 1000
ORDER BY SUM(price * amount) DESC;

