-- Hãy cho biết thông tin về khách hàng mua hàng nhiều nhất trong năm 2022 và 2021. 
-- Tổng số hàng hóa và tổng tiền phải thanh toán là bao nhiêu?
CREATE OR ALTER PROC sales.usp_FindBestCustomerInYear(
    @year INT
)
AS
BEGIN
    SELECT TOP 1 WITH TIES
        c.CustomerId,
        c.FirstName,
        c.LastName,
        c.Email,
        c.PhoneNumber,
        c.City,
        SUM(oi.Quantity) 'Số lượng mua',
        SUM(oi.Quantity * oi.Price) 'Tổng chi tiêu'
    FROM
        sales.Customers c 
		INNER JOIN sales.Orders o
        ON c.CustomerId = o.CustomerId
        INNER JOIN sales.OrderItems oi
        ON o.OrderId = oi.OrderId
    WHERE
        YEAR(o.CreatedDate) = @year
    GROUP BY
        c.CustomerId,
        c.FirstName,
        c.LastName,
        c.Email,
        c.PhoneNumber,
        c.City
    ORDER BY
        [Tổng chi tiêu] DESC;
END;
GO
EXEC sales.usp_FindBestCustomerInYear 2022;
EXEC sales.usp_FindBestCustomerInYear 2021;