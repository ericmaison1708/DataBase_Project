-- Hãy cho biết thông tin các cửa hàng có địa chỉ quận không trùng với địa chỉ quận của các cửa hàng khác.
SELECT
	s.StoreId [Mã cửa hàng],
	s.Name [Tên cửa hàng],
	s.District [Quận]
FROM
	sales.Stores s
WHERE
	s.District <> ALL(
					SELECT
						s1.District
					FROM
						sales.Stores s1
						INNER JOIN sales.Stores s2
						ON s1.StoreId > s2.StoreId
					WHERE
						s1.District = s2.District
					)
ORDER BY
	s.Name