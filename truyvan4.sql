-- Hãy cho biết thông tin các nhân viên quản lý, họ đang làm tại cửa hàng nào, quản lý bao nhiêu nhân viên?. 
-- Kết quả sắp xếp giảm dần theo số lượng nhân viên mà người quản lý đang quản lý.

SELECT
        m.StaffId,
		m.LastName + ' ' + m.MidName + ' ' + m.FirstName [Họ tên],
        m.Email,
        m.PhoneNumber,
        st.Name,
        COUNT(s.ManagerId) [Số nhân viên]
FROM    
        sales.Staffs m
        INNER JOIN sales.Staffs s
        ON m.StaffId = s.ManagerId
        INNER JOIN sales.Stores st
        ON s.StoreId = st.StoreId
WHERE
        m.StaffId IN(
            SELECT
                StaffId
            FROM
                sales.Staffs
            WHERE
                ManagerId IS NULL
        )   
GROUP BY
        m.StaffId,
        m.Email,
        m.PhoneNumber,
        m.LastName,
		m.MidName,
        m.FirstName,
        st.Name,
        s.ManagerId
HAVING
        COUNT(s.ManagerId) > 0
ORDER BY
        COUNT(s.ManagerId) DESC;