-- Thống kê doanh thu từng mặt hàng trong năm 2022 Sắp xếp giảm dần theo doanh thu
CREATE OR ALTER PROC sales.usp_StatByProducts(
	@year INT
)
AS
BEGIN
	SELECT
		p.ProductId,
		p.Name,
		p.Price,
		SUM(oi.Quantity) [Số lượng],
		SUM(oi.Quantity * oi.Price) [Tổng doanh thu]
	FROM
		production.Products p INNER JOIN sales.OrderItems oi
		ON p.ProductId = oi.ProductId
		INNER JOIN sales.Orders o
		ON o.OrderId = oi.OrderId
	WHERE
		YEAR(o.CreatedDate) = @year
	GROUP BY
		p.ProductId,
		p.Name,
		p.Price
	ORDER BY
		[Số lượng] DESC;
END;
GO
-- thống kê theo năm 2022
EXEC sales.usp_StatByProducts 2022; 