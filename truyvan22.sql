-- Hãy cho biết doanh thu trung bình của tất cả các cửa hàng phân phối

SELECT
	st.Name [Tên cửa hàng],
	st.Street + ', ' + st.District + ', ' + st.City [Địa chỉ],
	AVG(oi.Quantity * oi.Price) [Doanh thu trung bình]
FROM
	sales.Stores st
	INNER JOIN sales.Orders o
	ON st.StoreId = o.StoreId
	INNER JOIN sales.OrderItems oi
	ON o.OrderId = oi.OrderId
GROUP BY
	st.Name, st.Street, st.District, st.City
ORDER BY
	[Doanh thu trung bình] DESC
