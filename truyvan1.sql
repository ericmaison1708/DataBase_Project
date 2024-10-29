-- Hãy cho biết thông tin các sản phẩm có trong cửa hàng cùng số lượng tương ứng của cửa hàng mã TGDD2?
SELECT
	p.*,
	s.Quantity,
	st.StoreId, st.Name
FROM	
	sales.Stores st
	INNER JOIN production.Stocks s
	ON st.StoreId = s.StoreId
	INNER JOIN production.Products p
	ON s.ProductId = p.ProductId
WHERE 
	st.StoreId = 'TGDD2'


