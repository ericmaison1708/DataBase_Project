-- Cho biết top 10 khách hàng chi mạnh tay nhất để mua hàng 
-- trong các chuỗi cửa hàng từ ngày x đến ngày y?
CREATE OR ALTER PROC sales.usp_Top10BestCustomerInPeriod(
    @start DATETIME,
    @end DATETIME
)
AS
BEGIN
    SELECT TOP 10 WITH TIES
        c.CustomerId,
        c.LastName + ' ' + c.MidName + ' ' + c.FirstName 'Full Name',
        c.PhoneNumber,
        c.Email,
        SUM(oi.Quantity) 'Số lượng',
        SUM(oi.Quantity * oi.Price) 'Tổng chi tiêu'
    FROM
        sales.Customers c INNER JOIN sales.Orders o
        ON c.CustomerId = o.CustomerId
        INNER JOIN sales.OrderItems oi
        ON o.OrderId = oi.OrderId
    WHERE
        o.CreatedDate >= @start
        AND
        o.CreatedDate <= @end
    GROUP BY
        c.CustomerId, c.FirstName, c.MidName, c.LastName,
        c.PhoneNumber, c.Email
    ORDER BY
        [Tổng chi tiêu]
END;
GO
EXEC sales.usp_Top10BestCustomerInPeriod
    '2022-03-01',
    '2022-10-30';