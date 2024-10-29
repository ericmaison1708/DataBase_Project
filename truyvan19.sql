-- Giả sử lương cứng 10tr. Lương quản lý bằng 1.5 lần lương cứng
-- Bán được dưới 100tr tiền hàng thưởng 10% lương cứng. 
-- Bán được từ 100 đến dưới 200tr tiền hàng thưởng 25% lương. 
-- Bán được 200 đến dưới 300tr tiền hàng thưởng 35% lương. 
-- Bán được 300 đến dưới 400tr tiền hàng thưởng 45% lương. 
-- Bán được 400 – 500tr tiền hàng thưởng 60% lương. Bán được 500 đến dưới 800tr tiền hàng thưởng 80% lương. 
-- Bán được trên 800tr tiền hàng thưởng 120% lương.

DECLARE @startDate DATE = '2023-01-01';
DECLARE @endDate DATE = '2023-12-31';
DECLARE @baseSalary FLOAT = 10000000; 

SELECT
    s.StaffId,
    s.LastName + ' ' + s.MidName + ' ' + s.FirstName [Họ tên nhân viên],
    s.Email,
    s.PhoneNumber,
    SUM(oi.Price * oi.Quantity) [Doanh thu],
    CASE 
        WHEN s.ManagerId IS NULL THEN @baseSalary * 1.5
        ELSE @baseSalary
    END AS [Lương],
    CASE
        WHEN SUM(oi.Price * oi.Quantity) < 100000000 THEN @baseSalary * 0.1
        WHEN SUM(oi.Price * oi.Quantity) >= 100000000 AND SUM(oi.Price * oi.Quantity) < 200000000 THEN @baseSalary * 0.25
        WHEN SUM(oi.Price * oi.Quantity) >= 200000000 AND SUM(oi.Price * oi.Quantity) < 300000000 THEN @baseSalary * 0.35
        WHEN SUM(oi.Price * oi.Quantity) >= 300000000 AND SUM(oi.Price * oi.Quantity) < 400000000 THEN @baseSalary * 0.45
        WHEN SUM(oi.Price * oi.Quantity) >= 400000000 AND SUM(oi.Price * oi.Quantity) < 500000000 THEN @baseSalary * 0.60
        WHEN SUM(oi.Price * oi.Quantity) >= 500000000 AND SUM(oi.Price * oi.Quantity) < 800000000 THEN @baseSalary * 0.80
        WHEN SUM(oi.Price * oi.Quantity) >= 800000000 THEN @baseSalary * 1.2
        ELSE 0
    END AS [Thưởng],
    (
     CASE 
        WHEN s.ManagerId IS NULL THEN @baseSalary * 1.5
        ELSE @baseSalary
    END +
    CASE
        WHEN SUM(oi.Price * oi.Quantity) < 100000000 THEN @baseSalary * 0.1
        WHEN SUM(oi.Price * oi.Quantity) >= 100000000 AND SUM(oi.Price * oi.Quantity) < 200000000 THEN @baseSalary * 0.25
        WHEN SUM(oi.Price * oi.Quantity) >= 200000000 AND SUM(oi.Price * oi.Quantity) < 300000000 THEN @baseSalary * 0.35
        WHEN SUM(oi.Price * oi.Quantity) >= 300000000 AND SUM(oi.Price * oi.Quantity) < 400000000 THEN @baseSalary * 0.45
        WHEN SUM(oi.Price * oi.Quantity) >= 400000000 AND SUM(oi.Price * oi.Quantity) < 500000000 THEN @baseSalary * 0.60
        WHEN SUM(oi.Price * oi.Quantity) >= 500000000 AND SUM(oi.Price * oi.Quantity) < 800000000 THEN @baseSalary * 0.80
        WHEN SUM(oi.Price * oi.Quantity) >= 800000000 THEN @baseSalary * 1.2
        ELSE 0
    END) AS [Tổng lương]
FROM sales.Staffs s
LEFT JOIN sales.Orders o ON s.StaffId = o.StaffId
LEFT JOIN sales.OrderItems oi ON o.OrderId = oi.OrderId
WHERE o.CreatedDate BETWEEN @startDate AND @endDate
GROUP BY 
    s.StaffId, s.FirstName, s.MidName, s.LastName, s.Email, s.PhoneNumber, s.ManagerId;

