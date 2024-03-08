# MySQL Data Format
Use market_db;
# 만약, hongong4 라는 이름의 테이블이 존재하면 테이블 삭제
DROP TABLE IF EXISTS hongong4;

# 정수형
-- TINYINT 1byte -128~127
-- TINYINT UNSIGNED 0~255
-- SMALLINT 2byte -32768~32767
-- INT 4byte 약 -21억~21억
-- BIGINT 8byte 약 -900경~900경

# hongong4 라는 이름의 테이블 생성
CREATE TABLE hongong4(
	tinyint_col TINYINT,
    samllint_col SMALLINT,
    int_col INT,
    bigint_col BIGINT);

SELECT *
FROM hongong4;

# 각 데이터 타입의 범위에 맞는 값들을 테이블에 삽
INSERT INTO hongong4 VALUES(127, 32767, 2147483647, 9000000000000000000);

# 타입 값의 범위를 넘는 값들을 삽입하려고 할 때, 오류 메시지 출력
INSERT INTO hongong4 VALUES(128, 32768, 2147483647, 9000000000000000000);

# 문자형
-- CHAR(개수) 바이트수는 1~255 (고정형)
-- VARCHAR(개수) 바이트수는 1~16383 (가변형)

DROP TABLE big_table;
CREATE TABLE big_table(
	data1 CHAR(255) );
    
DROP TABLE big_table;
CREATE TABLE big_table(
	data2 VARCHAR(16383) );

# netflix_db 생성
CREATE DATABASE netflix_db;
USE netflix_db;

CREATE TABLE movie
	(
	 movie_id		INT, 
     movie_title 	VARCHAR(30),
     movie_director VARCHAR(20),
	 movie_star		VARCHAR(20),
     movie_script 	LONGTEXT, # 약 42억자의 문자열 데이터
     movie_film 	LONGBLOB  # 약 42억 바이트 데이터
     );


# 실수형
-- FLOAT 4byte 소수점 아래 7자리까지 표현
-- DOUBLE 8byte 소수점 아래 15자리까지 표

# 날짜-- DATE 3byte 날짜만 저장, YYY-MM--DD 형식으로 사용
-- TIME 3byte 시간만 저장, HH:MM:SS 형식으로 사용
-- DATETIME 8byte 날짜 및 시간을 저장, YYYY-MM-DD HH:MM:SS 형식으로 사용

# 변수 (주의할 점은, 임시 변수라는 것임, 다른 사용자는 모름, 워크벤치 껏다켜도 없어짐.)
-- SET @변수이름 = 변수의 값; -> 변수의 선언 및 값 대입
-- SELECT @변수이름 -> 변수의 값 출력
USE market_db;
SET @myVar1 = 5;
SET @myVar2 = 4.25;

SELECT @myVar1;
SELECT @myVar2;
SELECT @MyVar1 + @myVar2;

SET @txt = '가수 이름 ==> ';
SET @height = 166;
SELECT @txt, mem_name FROM member WHERE height > @height;

# 근데 이거는 문법 에러남
SET @count = 3;
SELECT mem_name, height FROM member ORDER BY height LIMIT @count;

# 따라서 아래와 이러한 경우에는 아래와 같은 구문을 사용할 수 있다.
SET @count = 3;
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?';
EXECUTE mySQL USING @count;

# 데이터 형 변환
SELECT AVG(price) '평균 가격' FROM buy;

# SIGNED 는 부호가 있는 정수형
SELECT CAST(AVG(price) AS SIGNED) '평균 가격' FROM buy;
-- 또는
SELECT CONVERT(AVG(price), SIGNED) '평균 가격' FROM buy;

SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR), 'X', CAST(amount AS CHAR), '=') '가격X수량',
	price*amount '구매액'
FROM buy;

# 암시적인 형변환
SELECT '100' + '200'; -- 문자와 문자를 더함 (정수로 변환되서 연산됨)
SELECT 100 + '200'; -- 정수와 문자를 더함(정수로 변환되어서 연산됨)
SELECT CONCAT('100', '200'); -- 문자와 문자를 연결 (문자로 처리)
SELECT CONCAT(100, '200'); -- 정수와 문자를 연결 (정수가 문자로 변환되서 처리)
SELECT 1 > '2mega'; -- 정수인 2로 변환되어서 비교
SELECT 3 > '2MEGA'; -- 정수인 2로 변환되어서 비교alter
SELECT 0 = 'mega2'; -- 문자는 0으로 변환됨 (문자열의 첫번째 글자에 대해서 숫자면 정수로변환해서 인식하고 문자면 0으로 변환해서 인식(비교)