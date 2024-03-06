# StoredProcedure
# StoredProcedure 에서 사용한 세미콜론(;)을 인식하도록 DELIMETER 명령어로 임시로 구분기호를 재정의
DELIMITER //
# myProc 라는 이름의 StoredProcedure 정의
CREATE PROCEDURE myProc()
BEGIN
	SELECT * FROM member WHERE member_name = '나훈아';
	SELECT * FROM product WHERE product_name = '삼각김밥';
END //
# 임시로 변경한 DELIMETER 를 세미콜론(;)으로 원상복구
DELIMITER ;

# myProc 라는 이름의 StoredProcedure 호출
CALL myProc();