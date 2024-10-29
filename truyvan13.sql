-- Thống kê số lượng hàng hóa bán được của từng nhân viên trong năm 2022. 
-- Sắp xếp giảm dần theo doanh thu?
CREATE OR ALTER PROC sales.usp_StatBySeller(
	@year INT
)
AS
BEGIN
	SELECT
		s.StaffId,
		s.LastName + ' ' + s.MidName  + ' ' + s.FirstName [Họ tên nhân viên],
		s.Email,
		s.PhoneNumber,
		s.Status,
		SUM(oi.Quantity) [Tổng số lượng],
		SUM(oi.Quantity * oi.Price) [Doanh thu]
	FROM
		sales.Staffs s INNER JOIN sales.Orders o
		ON s.StaffId = o.StaffId
		INNER JOIN sales.OrderItems oi
		ON o.OrderId = oi.OrderId
	WHERE
		YEAR(o.CreatedDate) = @year
	GROUP BY
		s.StaffId, s.FirstName, s.LastName, s.MidName,
		s.Email, s.PhoneNumber, s.Status
	ORDER BY
		[Tổng số lượng] DESC;
END;
GO
-- thống kê theo năm 2022
EXEC sales.usp_StatBySeller 2022; 