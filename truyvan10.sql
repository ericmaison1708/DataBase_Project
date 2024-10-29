-- Hãy cho biết danh sách các sản phẩm thuộc loại Smartphone có số lượng tồn kho lớn hơn 400 đơn vị
SELECT
	p.ProductId, p.Name [Tên sản phẩm],
	st.Quantity, c.Name [Loại sản phẩm]
FROM
	production.Stocks st
	INNER JOIN production.Products p
	ON st.ProductId = p.ProductId
	INNER JOIN production.Categories c
	ON p.CategoryId = c.CategoryId
WHERE
	c.Name = 'Smartphone'
	AND st.Quantity > 400
ORDER BY
	st.Quantity DESC



