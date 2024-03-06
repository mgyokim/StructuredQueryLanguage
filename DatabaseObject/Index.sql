# Index
# member 테이블에서 member_name 값이 '아이유' 인 것을 검색. Index가 없는 상태 -> Full Table Scan
SELECT * FROM member WHERE member_name = '아이유';
# Index 생성 (member_name 가지고)
CREATE INDEX idx_member_name ON member(member_name);
# member 테이블에서 member_name 값이 '아이유' 인 것을 검색. Index가 있는 상태 -> Non-Unique Key Lookup
SELECT * FROM member WHERE member_name = '아이유';