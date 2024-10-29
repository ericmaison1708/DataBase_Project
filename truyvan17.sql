-- Cho biết khách hàng nào đã mua sản phẩm gì, giá tiền, 
-- số lượng bao nhiêu trong khoảng thời gian từ ngày 2022-07-01 đến 2022-08-31?
CREATE OR ALTER PROC sales.usp_StatByCustomerInPeriod(
    @start DATETIME,
    @end DATETIME,
    @storeId NVARCHAR(50)
)
AS
BEGIN
    SELECT
        o.OrderId ,
        c.LastName + ' ' + c.MidName + ' ' + c.FirstName 'Họ tên',
        c.PhoneNumber,
        o.CreatedDate 'Ngày mua',
        p.Name 'Tên sản phẩm',
        p.Price 'Giá gốc',
        oi.Price 'Giá khuyến mãi',
        s.Name 'Tên cửa hàng',
        oi.Quantity,
        oi.Quantity * oi.Price 'Tổng thanh toán'
    FROM
        sales.Customers c INNER JOIN sales.Orders o
        ON c.CustomerId = o.CustomerId
        INNER JOIN sales.OrderItems oi
        ON o.OrderId = oi.OrderId
        INNER JOIN production.Products p
        ON oi.ProductId = p.ProductId
        INNER JOIN sales.Stores s
        ON s.StoreId = o.StoreId
    WHERE
        o.CreatedDate >= @start
        AND
        o.CreatedDate <= @end
    ORDER BY
        [Ngày mua]
END;
GO
-- thống kê theo khoảng thời gian 2022-07-01 đến 2022-08-31
EXEC sales.usp_StatByCustomerInPeriod
    '2022-07-01',
    '2022-08-31',
    'ViettelStore32';