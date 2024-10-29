-- Lấy tên và số lượng sản phẩm của các đơn hàng có giá trị cao hơn giá trị trung bình của tất cả các đơn hàng.
SELECT
	p.Name [Tên sản phẩm],
	SUM(oi.Quantity) [Tổng số lượng],
	AVG(oi.Quantity) [Trung bình]
FROM
	production.Products p
	INNER JOIN sales.OrderItems oi
	ON p.ProductId = oi.ProductId
	INNER JOIN sales.Orders o
	ON oi.OrderId = o.OrderId
WHERE
	oi.Quantity > ( SELECT
						AVG(Quantity)
					FROM
						sales.OrderItems)
GROUP BY
	p.Name
ORDER BY
	[Tổng số lượng] DESC