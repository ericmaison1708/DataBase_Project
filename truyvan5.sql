-- Hãy liệt kê tình trạng giao hàng và số đơn hàng của cửa hàng mã TGDD291
-- nếu đã giao -> hiển thị Đã giao hàng
-- nếu chưa giao -> hiển thị Chưa giao hàng

SELECT 
	c.CustomerId, c.FirstName, c.PhoneNumber,
	COUNT(o.CustomerId) [Số đơn hàng],
	CASE 
		WHEN o.ShippedDate IS NULL THEN N'Chưa giao hàng'
		WHEN o.ShippedDate IS NOT NULL THEN N'Đã giao hàng'
	END [Trạng thái giao hàng]
FROM
	sales.Orders o 
	INNER JOIN sales.Customers c
	ON o.CustomerId = c.CustomerId
WHERE
	o.StoreId = 'TGDD291'
GROUP BY
	c.CustomerId, c.FirstName, c.PhoneNumber, o.ShippedDate

	