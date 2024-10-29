-- Hãy cho biết tên quản lý và số lượng nhân viên dưới quyền của quản lý đó nếu người đó quản lý từ 3 nhân viên trở lên?
SELECT
	st.Name [Cửa hàng],
	s2.LastName + ' ' + s2.MidName + ' ' + s2.FirstName [Họ tên quản lý],
	COUNT(s1.ManagerId) [Số nhân viên]
FROM
	sales.Staffs s1
	INNER JOIN sales.Staffs s2
	ON s1.ManagerId = s2.StaffId,
	sales.Stores st
WHERE
	st.StoreId = s2.StoreId
	AND
	EXISTS(
		SELECT	
			StaffId
		FROM
			sales.Staffs
		WHERE
			StaffId = s2.StaffId
			AND
			ManagerId IS NULL
	)
GROUP BY 
	s1.ManagerId,
	st.Name,
	s2.FirstName, s2.LastName, s2.MidName
HAVING
	COUNT(s1.ManagerId) >= 3
ORDER BY
	[Số nhân viên] DESC