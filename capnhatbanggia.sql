-- Cập nhật bảng giá sau khuyến mãi cho các mặt hàng được chọn mà có áp dụng chương trình khuyến mãi.
CREATE OR ALTER FUNCTION sales.fn_FindProductPrice(
	@orderItemId INT,
	@discountId INT
)
RETURNS FLOAT(2)
AS
BEGIN
	DECLARE @price FLOAT(2);
	IF @discountId IS NULL
	BEGIN
		SELECT 
			 @price = p.Price
		FROM
			sales.OrderItems oi INNER JOIN production.Products p
			ON oi.ProductId = p.ProductId
		WHERE
			@orderItemId = oi.OrderItemId
	END;
	ELSE
	BEGIN
		SELECT 
			 @price = p.Price - (p.Price * d.DiscountPercent / 100) - d.DiscountAmount
		FROM
			sales.OrderItems oi INNER JOIN production.Products p
			ON oi.ProductId = p.ProductId
			INNER JOIN sales.Discounts d
			ON oi.DiscountId = d.DiscountId
		WHERE
			@orderItemId = oi.OrderItemId
	END;
	RETURN @price;
END;
GO
UPDATE sales.OrderItems
SET Price = sales.fn_FindProductPrice(OrderItemId, DiscountId);