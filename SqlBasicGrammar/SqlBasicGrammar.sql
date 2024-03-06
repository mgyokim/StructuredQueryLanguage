# 사용할 Dababase 지정
USE market_db;

# member 테이블에 있는 모든 열을 선택
SELECT * 
FROM member;

# member 테이블에 있는 데이터들 중, mem_name 이 '블랙핑크' 인 것의 데이터 선택
SELECT * 
FROM member 
WHERE mem_name = '블랙핑크';

# 다른 Database 를 사용중이더라도, Database를 직접 지정하여 조회 가능
SELECT * 
FROM market_db.member 
WHERE mem_name = '블랙핑크';

# 데이터 열을 직접 지정하여 조회
SELECT height, debut_date, addr
FROM member 
WHERE mem_name = '블랙핑크';

# 데이터 열을 직접 지정하여 조회할 때, 열에 별칭을 지정하여 조회할 수 있음, 별칭에 띄어쓰기가 있으면 "로 감싸야함 
# 별칭은 참조일 뿐임. 실제 값이 아님.
SELECT height 키, debut_date '데뷔 일자', addr 주소
FROM member 
WHERE mem_name = '블랙핑크';

# mem_number가 4인 것을 조회
SELECT * FROM member WHERE mem_number = 4;

# height가 162보다 작거나 같은 데이터의 mem_id, mem_name 을 조회
SELECT mem_id, mem_name
FROM member
WHERE height <= 162;

# height가 165보다 크거나 같고, 회원수가 6명 초과인 데이터의 mem_name, height, mem_number 조회
SELECT mem_name, height, mem_number
FROM member
WHERE height >= 165 AND mem_number > 6;

# height이 165보다 크거나 같은, 또는 mem_number 가 6명 초과인 데이터의 mem_name, height, mem_number 조회
SELECT mem_name, height, mem_number
FROM member
WHERE height >= 165 OR mem_number > 6;

# height이 163 이상 165 이하 인 데이터의 mem_name, height 조회 (1)
SELECT mem_name, height
FROM member
WHERE height >= 163 AND height <= 165;

# height이 163 이상 165 이하 인 데이터의 mem_name, height 조회 (2)
SELECT mem_name, height
FROM member
WHERE height BETWEEN 163 AND 165;

# addr이 경기 또는 전남 또는 경남인 데이터의 mem_name, addr 을 조회(1)
SELECT mem_name, addr
FROM member
WHERE addr = '경기' OR addr = '전남' OR addr = '경남';

# addr이 경기 또는 전남 또는 경남인 데이터의 mem_name, addr 을 조회(2)
SELECT mem_name, addr
FROM member
WHERE addr IN('경기', '전남', '경남');

# mem_name이 '우'로 시작하는 데이터 조회
SELECT *
FROM member
WHERE mem_name LIKE '우%';

# mem_name이 'XX핑크' 인(앞에두글자 + 핑크) 데이터 조회 -> 언더바 갯수 2
SELECT *
FROM member
WHERE mem_name LIKE '__핑크';