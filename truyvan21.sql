-- Hãy cho biết top 3 mặt hàng bán kém nhất tính theo doanh thu trong năm 202x? 
-- Tổng số hàng hóa bán được và doanh thu là bao nhiêu?
CREATE OR ALTER PROC sales.usp_FindBestSellProductInYear(
	@year INT
)
AS
BEGIN
	SELECT TOP 3 WITH TIES
		p.ProductId,
		p.Name,
		p.Price,
		SUM(oi.Quantity) 'Total Item',
		SUM(oi.Quantity * oi.Price) 'Total',
		@year 'Year'
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
		Total ASC;
END;
GO
-- tìm mặt hàng đc mua nhiều nhất năm 2022 và năm 2023
EXEC sales.usp_FindBestSellProductInYear 2022; 
EXEC sales.usp_FindBestSellProductInYear 2023; 