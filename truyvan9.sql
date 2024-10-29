-- Hãy sắp xếp doanh thu bán hàng của các nhân viên trong 2022 theo thứ tự giảm dần?
SELECT	
	s.StaffId,
	s.LastName + ' ' + s.MidName + ' ' + s.LastName [Họ tên nhân viên],
	s.Email, s.PhoneNumber,
	SUM(oi.Quantity) [Tổng số hàng bán được],
	SUM(oi.Quantity * oi. Price) [Tổng doanh thu]
FROM
	sales.Staffs s
	INNER JOIN sales.Orders o
	ON s.StaffId = o.StaffId
	INNER JOIN sales.OrderItems oi
	ON o.OrderId = oi.OrderId
WHERE
	YEAR(o.CreatedDate) = 2022
GROUP BY
	s.StaffId,
	s.LastName + ' ' + s.MidName + ' ' + s.LastName,
	s.Email, s.PhoneNumber
ORDER BY
	[Tổng số hàng bán được] DESC
