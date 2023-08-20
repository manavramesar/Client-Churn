-- Demographics --

-- No of clients in each country -- 

SELECT Geography, COUNT(*) AS "Number Of Clients In Each Country"
FROM customer_churn_records 
GROUP BY 1;

-- Age Group Count--

SELECT COUNT(Age), 
       CASE 
         WHEN Age BETWEEN 18 AND 40 THEN '18-40'
         WHEN Age BETWEEN 41 AND 60 THEN '41-60'
         WHEN Age BETWEEN 61 AND 100 THEN '61-100'
       END AS age_group
FROM customer_churn_records
GROUP BY 2;

-- Average Estiamted Salary In Each Age Group --

SELECT ROUND(AVG(estimated_salary),2) AS estimated_salary, 
       CASE 
         WHEN Age BETWEEN 18 AND 40 THEN '18-40'
         WHEN Age BETWEEN 41 AND 60 THEN '41-60'
         WHEN Age BETWEEN 61 AND 100 THEN '61-100'
       END AS age_group
FROM customer_churn_records
GROUP BY 2;

-- No of Male And Female Customers --

SELECT Gender, COUNT(*)
FROM customer_churn_records
GROUP BY 1;

-- Churn --

-- Customers Retained VS No Customers Lost --

SELECT COUNT(no_longer_a_customer) AS customers
FROM customer_churn_records
WHERE no_longer_a_customer = "no";

SELECT COUNT(no_longer_a_customer) AS sum_of_Customers
FROM customer_churn_records;

-- Do More People Drop Off When They Have More Products? --

SELECT no_of_products, 	COUNT(no_longer_a_customer) AS "Number Of People That Have Left"
FROM customer_churn_records
GROUP BY 1, no_longer_a_customer
HAVING no_longer_a_customer = "Yes"
ORDER BY 2 DESC; 

-- Which Country Has A Higher Churn Rate? --

SELECT a.Geography, b.churn_count, a.total_count, (b.churn_count / a.total_count)* 100 AS churn_rate
FROM (
    SELECT Geography, COUNT(*) AS total_count
    FROM customer_churn_records 
    GROUP BY 1
) AS a
JOIN (
    SELECT Geography, COUNT(*) AS churn_count
    FROM customer_churn_records 
    WHERE active_member = 'No'
    GROUP BY 1
) AS b
ON a.Geography = b.Geography;

-- Which Card Type Sees The Most Drop Off? --

SELECT card_type, COUNT(no_longer_a_customer) AS "clients_leaving"
FROM customer_churn_records
GROUP BY 1, no_longer_a_customer
HAVING no_longer_a_customer = "Yes"
ORDER BY 2 DESC;

-- How Many People Have Lodged Complaints For Each Card Type?--

SELECT card_type, COUNT(Complain) AS "complaints"
FROM customer_churn_records
GROUP BY 1;


