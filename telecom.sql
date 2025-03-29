-- Selecting the `telecom_churn` database to ensure all subsequent queries are executed within the correct database context.
USE telecom_churn


-- Selecting all records from the `telecom` table to analyze customer-specific details, including Customer_ID, Gender, Age, City, etc
SELECT * FROM telecom



-- Q1. Find the number of consumers
SELECT DISTINCT 
    COUNT(Customer_ID) AS total_count 
FROM 
    telecom


-- Q2. Find duplicate rows
SELECT 
    Customer_ID, 
        COUNT(*) AS Total_duplicates 
FROM 
    telecom
GROUP BY 
    Customer_ID
HAVING 
    COUNT(*)>1


-- Q3. What is the number and proportion of customers who have churned?
SELECT
    COUNT
        (CASE WHEN Customer_Status = 'Churned' THEN 1 END) AS Total_churned,
    ROUND(COUNT
        (CASE WHEN Customer_Status = 'Churned' THEN 1 END)*100, 2) / COUNT(*)  AS Churned_proportion
FROM 
    telecom


-- Q4. What is the average age of the consumers that joined, stayed and churned?
SELECT 
        ROUND(AVG(CASE WHEN Customer_Status = 'Joined' THEN Age END),2) AS Avg_age_joined,
        ROUND(AVG(CASE WHEN Customer_Status = 'Stayed' THEN Age END),2) AS Avg_age_Stayed,
        ROUND(AVG(CASE WHEN Customer_Status = 'Churned' THEN Age END),2) AS Avg_age_Churned
FROM 
    telecom


-- Q5. What is the gender's proportion churn?
SELECT 
    Gender, 
        COUNT(Gender)AS Total,
            ROUND((COUNT(Gender) *100) / (SELECT COUNT(*) FROM telecom WHERE Customer_Status = 'Churned'),2) AS Proportion_churned
FROM 
    telecom
WHERE 
    Customer_Status= 'Churned'
GROUP BY
    Gender


-- Q6. The state civil of customers has correlation with churned?
SELECT Married, COUNT(Married) AS Total_Count,
ROUND((COUNT(Married)*100) / (SELECT COUNT(*) FROM telecom WHERE Customer_Status = 'Churned'),2) AS  Proportion_Churned
FROM telecom
WHERE Customer_Status = 'Churned'
GROUP BY Married


-- Q7 Average of referrals by customer's status
SELECT 
    Customer_Status,  
        AVG(Number_of_Referrals) AS Average_referrals
FROM 
    telecom
GROUP BY 
    Customer_Status
ORDER BY 
    Average_referrals DESC


-- Q8. The better offer for each customer's status
SELECT 
    Customer_Status,Offer, 
        COUNT(*) AS Better_offer
FROM 
    telecom
GROUP BY 
    Customer_Status, 
    Offer
ORDER BY 
    Customer_Status, 
    Better_offer DESC


-- Q9. Average of tenure in months by customer's status
SELECT 
    Customer_Status, 
        AVG(Tenure_in_Months) AS Average_tenure
FROM 
    telecom
GROUP BY 
    Customer_Status
ORDER BY 
    Average_tenure DESC


-- Q10. Average monthly long distance charge for each customer's status
SELECT 
    Customer_Status, 
        ROUND(AVG(Avg_Monthly_Long_Distance_Charges),2) AS Avg_Monthly_long_Distance_charges
FROM 
    telecom
GROUP BY 
    Customer_Status
ORDER BY 
    Avg_Monthly_long_Distance_charges DESC


-- Q11. Total of phone service for each customer's status
SELECT 
    Customer_Status,Phone_Service,  
        COUNT(Phone_Service) AS Total_phone_service
FROM 
    telecom
GROUP BY 
    Phone_Service, 
    Customer_Status
ORDER BY 
    Customer_Status, 
    Total_phone_service DESC


-- Q12. Total of multiple lines for each customer's status
SELECT 
    Customer_Status, 
    Multiple_Lines,  
        COUNT(Multiple_Lines) AS Total_multiple_lines
FROM 
    telecom
GROUP BY 
    Customer_Status, 
    Multiple_Lines
ORDER BY 
    Total_multiple_lines DESC


-- Q13.  Main internet type for each customer's status
SELECT 
    Customer_Status, 
    Internet_Type,
        COUNT(Internet_Type) AS Total_count
FROM 
    telecom
GROUP BY 
    Customer_Status, 
    Internet_Type
ORDER BY 
    Total_count DESC


-- Q14. Average monthly of gb download for each customer's status
SELECT 
    Customer_Status,
        AVG(Avg_Monthly_GB_Download) AS Avg_GB_downloads
FROM 
    telecom
WHERE 
    Avg_Monthly_GB_Download IS NOT NULL
GROUP BY 
    Customer_Status
ORDER BY 
    Avg_GB_downloads DESC


-- Q15. Proportion of user that has online security for each customer's status
WITH Total_security AS (
    SELECT 
        Customer_Status, 
            COUNT(*) AS Total_per_status
    FROM 
        telecom
    WHERE 
        Online_Security IS NOT NULL
    GROUP BY 
        Customer_Status
)
SELECT 
    a.Customer_Status, 
    a.Online_Security, 
        COUNT(a.Online_Security) AS Total,
            ROUND(COUNT(a.Online_Security) * 100.0 / b.Total_per_status, 2) AS Percentage
FROM 
    telecom AS a
JOIN Total_security AS b ON a.Customer_Status = b.Customer_Status
WHERE 
    a.Online_Security IS NOT NULL
GROUP BY 
    a.Customer_Status, a.Online_Security, b.Total_per_status
ORDER BY 
    Percentage DESC;


-- Q16. Proportion of user that has online backup for each customer's status
WITH TotalStatus AS(
    SELECT 
        Customer_Status, 
            COUNT(*) AS TotalPerStatus
    FROM 
        telecom
    WHERE 
        Online_Backup IS NOT NULL
    GROUP BY 
        Customer_Status
)
SELECT 
    a.Customer_Status, 
    a.Online_Backup, 
        COUNT(a.Online_Backup) AS Total, 
            ROUND(COUNT(a.Online_Backup) * 100.0 / b.TotalPerStatus,2) AS Percentage 
FROM 
    telecom AS a 
JOIN TotalStatus AS b ON a.Customer_Status = b.Customer_Status
WHERE 
    a.Online_Backup IS NOT NULL
GROUP BY 
    a.Customer_Status, 
    a.Online_Backup, 
    b.TotalPerStatus
ORDER BY a.Customer_Status, Total DESC


-- Q17. Analysing the more common payment method for each customer's status
SELECT 
    Customer_Status, 
    Payment_Method,  
        COUNT(Payment_Method) AS Common_payment_method
FROM 
    telecom
GROUP BY 
    Customer_Status, 
    Payment_Method
ORDER BY 
    Common_payment_method DESC


-- Q18. Average of monthly charge for each customer's status
SELECT 
    Customer_Status,  
        ROUND(AVG(Monthly_Charge),2) AS Average_montly_charges
FROM 
    telecom
GROUP BY   
        Customer_Status
ORDER BY  
    Average_montly_charges DESC


-- Q19. Average of total charge for each customer's status
SELECT 
    Customer_Status, 
        ROUND(AVG(Total_Charges),2) AS Average_total_charges
FROM telecom
GROUP BY Customer_Status


-- Q20. Average of total refunds for each customer's status
SELECT 
    Customer_Status, 
        ROUND(AVG(Total_Refunds),2) AS Average_total_refunds
FROM telecom
GROUP BY Customer_Status


-- Q21. Average of total extra data charges for each customer's status
SELECT 
    Customer_Status, 
        ROUND(AVG(Total_Extra_Data_Charges),2) AS Average_total_extra_data_charges
FROM telecom
GROUP BY Customer_Status


-- Q22. Average of total long distance charges for each customer's status
SELECT 
    Customer_Status, 
        ROUND(AVG(Total_Long_Distance_Charges),2) AS Average_total_long_distance_charges
FROM telecom
GROUP BY Customer_Status


-- Q23. Average of total revenue for each customer's status
SELECT 
    Customer_Status, 
        ROUND(AVG(Total_Revenue),2) AS Average_total_revenue
FROM telecom
GROUP BY Customer_Status

