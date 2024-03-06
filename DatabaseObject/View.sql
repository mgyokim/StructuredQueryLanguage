# View
# member_view 라는 이름으로 View 생성
CREATE VIEW member_view
AS
	SELECT * FROM member;

# member_view 라는 이름의 View 에 접근
SELECT * FROM member_view;