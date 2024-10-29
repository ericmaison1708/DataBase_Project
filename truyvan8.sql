-- Hãy cho biết top 3 mặt hàng được khách mua nhiều nhất tính theo doanh thu trong năm 2022 và 2023? 
-- Tổng hàng hóa đã bán và doanh thu là bao nhiêu?

CREATE OR ALTER PROC sales.usp_FindBestSellProductInYear(
	@year INT
)
AS
BEGIN
	SELECT TOP 3 WITH TIES
		p.ProductId,
		p.Name,
		p.Price,
		SUM(oi.Quantity) 'Số lượng',
		SUM(oi.Quantity * oi.Price) 'Tổng bán',
		@year 'Năm'
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
		[Tổng bán] DESC;
END;
GO
-- tìm mặt hàng đc mua nhiều nhất năm 2022 và năm 2023
EXEC sales.usp_FindBestSellProductInYear 2022; 
EXEC sales.usp_FindBestSellProductInYear 2023; 