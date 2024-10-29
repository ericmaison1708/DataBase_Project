-- Lấy ra 10 đơn hàng được đặt gần đây nhất

SELECT TOP 10 WITH TIES
	c.LastName + ' ' + c.MidName + ' ' + c.FirstName [Họ tên],
	c.Street + ', ' + c.District + ', ' + c.City [Địa chỉ],
	c.Email, c.PhoneNumber,
	o.CreatedDate, o.OrderStatus
FROM
	sales.Customers c
	INNER JOIN sales.Orders o
	ON c.CustomerId = o.CustomerId
ORDER BY
	o.CreatedDate DESC
