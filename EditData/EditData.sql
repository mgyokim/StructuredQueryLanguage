# INSERT, UPDATE, DELETE
USE market_db;
# hongong1 이라는 이름의 테이블 생성
CREATE TABLE hongong1(toy_id INT, toy_name CHAR(4), age INT);

# hongong1 테이블에 있는 모든 열 데이터를 추가하여 하나의 행데이터를 삽입
INSERT INTO hongong1 VALUES(1, '우디', 25);

# hongonh1 테이블에 있는 열 중에서 특정 열에만 데이터를 추가하여 하나의 행 데이터를 삽입 -> 데이터 열을 직접 지정해서 데이터를 넣어줘야함
INSERT INTO hongong1(toy_id, toy_name) VALUES (2, '버즈');

# hongong1 테이블에 있는 모든 열 데이터를 추가하여 하나의 행 데이터를 삽입
# 만약 직접 열데이터를 지정하여 준다면, 순서는 상관없음. 지정한데로만 잘 작성해주면 된다.
INSERT INTO hongong1(toy_name, age, toy_id) VALUES ('제시', 20, 3);

# hongong2 테이블 생성
# toy_id 에 AUTO_INCREMENT PRIMARY KEY 를 지정
CREATE TABLE hongong2(
toy_id INT AUTO_INCREMENT PRIMARY KEY,
toy_name CHAR(4),
age INT);

# 행 데이터를 삽입할 떄, toy_id 는 NULL 이라고 삽입해주면, 자동으로 생성된다.
INSERT INTO hongong2 VALUES(NULL, '보핍', 25);
INSERT INTO hongong2 VALUES(NULL, '슬링키', 22);
INSERT INTO hongong2 VALUES(NULL, '렉스', 21);

# hongong2 테이블 조회
SELECT *
FROM hongong2;

# AUTO_INCREMENT 를 100 부터 사용하겠다.
ALTER TABLE hongong2 AUTO_INCREMENT=100;

INSERT INTO hongong2 VALUES(NULL, '재남', 35);
INSERT INTO hongong2 VALUES(NULL, '재현', 39);

SELECT *
FROM hongong2;

# 테이블 만들 때 부터, AUTO_INCREMENT 를 1000부터 사용하겠다.
CREATE TABLE hongong3 (
toy_id INT AUTO_INCREMENT PRIMARY KEY,
toy_name CHAR(4),
age INT);

ALTER TABLE hongong3 AUTO_INCREMENT=1000;

# 근데, 1000 다음에 1001이 아니라, 1003, 1006, 1009 이런식으로 사용하고싶다면, 아래 구문을 사용할 것.
SET @@auto_increment_increment = 3;

INSERT INTO hongong3 VALUES (NULL, '토마스', 20);
INSERT INTO hongong3 VALUES (NUll, '제임스', 23);
INSERT INTO hongong3 VALUES (NULL, '고든', 25);

SELECT *
FROM hongong3;

# INSERT INTO ~ SELECT
# world Database의 도시 갯수를 조회
SELECT COUNT(*)
FROM world.city;

# world Database의 city 테이블의 구조를 조회
DESC world.city;

# city 테이블의 데이터 5개를 조회
SELECT *
FROM world.city
LIMIT 5;

# market_db에 city_popul 이라는 이름의 테이블을 생성
CREATE TABLE city_popul (city_name CHAR(35), population INT);

# world.city 테이블에 있는 Name과 Population 데이터를 가져와서 city_popul 테이블에 삽입
INSERT INTO city_popul
SELECT Name, Population FROM world.city;

# city_popul 테이을 조회
SELECT * 
FROM city_popul;

# UPDATE
# 기존에 입력되어 있는 값을 수정하는 명령어
# 'Seoul' 을 한글 '서울'로 업데이트
SELECT *
FROM city_popul
WHERE city_name = 'Seoul';

UPDATE city_popul
SET city_name = '서울'
WHERE city_name = 'Seoul';

SELECT *
FROM city_popul
WHERE city_name = '서울';

# city_name 이 'New York' 인 데이터의 city_name 은 '뉴욕' , population 은 0 으로 업데이트
UPDATE city_popul
SET city_name = '뉴욕', population = 0
WHERE city_name = 'New York'; # WHERE 없이 사용하면 모든 도시의 이름과 인구수가 업데이트 된다. 조심해야함.

SELECT *
FROM city_popul
WHERE city_name = '뉴욕';

# 만약 모든 나라의 인구수를 만(10000)단위로 업데이트하고싶다면,
UPDATE city_popul
SET population = population / 10000;

SELECT *
FROM city_popul
LIMIT 5;

# DELETE
# 데이터를 삭제
# city_popul 테이블의 데이터 중에서 city_name이 'New' 로 시작하는 데이터를 삭제
DELETE FROM city_popul
WHERE city_name LIKE 'New%';

# city_popul 테이블의 데이터 중에서 city_name이 'New' 로 시작하는 데이터를 삭제, 단, 앞의 5건만 삭제하고싶을때
DELETE FROM city_popul
WHERE city_name LIKE 'New%'
LIMIT 5;