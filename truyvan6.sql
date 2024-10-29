-- Hãy cho biết khách hàng có số điện thoại 0974123453 đã mua những mặt hàng nào,
-- thời điểm nào, giá cả, tổng thành tiền là bao nhiêu?

SELECT
	c.LastName + ' ' + c.MidName + ' ' + c.FirstName [Họ tên],
	c.PhoneNumber,
	o.CreatedDate,
	p.Name [Tên sản phẩm], p.Price [Giá gốc],
	oi.Price [Giá khuyến mãi], oi.Quantity [Số lượng], 
	oi.Quantity * oi.Price [Tổng hóa đơn]
FROM
	sales.Customers c
	INNER JOIN sales.Orders o
	ON c.CustomerId = o.CustomerId
	INNER JOIN sales.OrderItems oi
	ON o.OrderId = oi.OrderId
	INNER JOIN production.Products p
	ON oi.ProductId = p.ProductId
WHERE
	c.PhoneNumber = '0974123453'
