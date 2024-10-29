-- Hãy cho biết có khách hàng nào ở quận Long Biên hay không

BEGIN
	DECLARE @district NVARCHAR(50);
	DECLARE @numberOfCustomer INT;
	SET @district = N'Long Biên';

	SELECT
		@numberOfCustomer = COUNT(*)
	FROM
		sales.Customers
	WHERE 
		District = @district
	-- xử lí kết quả và đưa ra kết luận
	IF @numberOfCustomer = 0
	BEGIN
		PRINT N'Không có khách hàng nào ở quận ' + @district
	END
	ELSE
	BEGIN
		PRINT N'Có ' + CAST(@numberOfCustomer AS VARCHAR) + N' khách hàng ở quận ' + @district
	END
END