-- Cho biết top 5 mặt hàng bán chạy nhất về số lượng từ ngày x đến ngày y?
CREATE OR ALTER PROC sales.usp_Top5BestSellingProducts(
    @start DATETIME,
    @end DATETIME
)
AS
BEGIN
    SELECT TOP 5 WITH TIES
        p.ProductId,
        p.Name,
        p.Price,
        SUM(oi.Quantity) 'Số lượng',
        SUM(oi.Quantity * oi.Price) 'Doanh thu'
    FROM
        production.Products p INNER JOIN sales.OrderItems oi
        ON p.ProductId = oi.ProductId
        INNER JOIN sales.Orders o
        ON o.OrderId = oi.OrderId
    WHERE
        o.CreatedDate >= @start
        AND
        o.CreatedDate <= @end
    GROUP BY
        p.ProductId,
        p.Name,
        p.Price
    ORDER BY
        [Số lượng] DESC;
END;
GO
EXEC sales.usp_Top5BestSellingProducts
    '2022-01-01',
    '2022-09-30';