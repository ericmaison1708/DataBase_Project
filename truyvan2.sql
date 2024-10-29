-- Hãy cho biết thông tin các khách hàng đã từng đến mua hàng tại cửa hàng có mã Cellphone48 
-- vào khoảng ngày 17-8-2022 đến 30-09-2022.
CREATE OR ALTER PROC usp_FindCustomerInAStore(
    @storeId VARCHAR(50),
    @start DATETIME,
    @end DATETIME
)
AS
BEGIN
    SELECT DISTINCT 
        c.*
    FROM
        sales.Orders o 
		INNER JOIN sales.Customers c
        ON o.CustomerId = c.CustomerId
        INNER JOIN sales.Stores s
        ON o.StoreId = s.StoreId
    WHERE
		s.StoreId = @storeId
		AND
        o.CreatedDate >= @start
        AND
        o.CreatedDate <= @end;
END;
GO
EXEC usp_FindCustomerInAStore 'Cellphone48', '2022-08-17', '2022-09-30';