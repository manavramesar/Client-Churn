-- Demographics --

-- no_of_clients_in_each_country --

CREATE VIEW no_of_clients_in_each_country AS
SELECT Geography, COUNT(*) AS Number_Of_Clients_In_Each_Country
FROM customer_churn_records 
GROUP BY 1;

-- Age Group --

CREATE VIEW age_group AS
SELECT COUNT(Age), 
       CASE 
         WHEN Age BETWEEN 18 AND 40 THEN '18-40'
         WHEN Age BETWEEN 41 AND 60 THEN '41-60'
         WHEN Age BETWEEN 61 AND 100 THEN '61-100'
       END AS age_group
FROM customer_churn_records
GROUP BY 2;

-- Average Estimated Salary In Each Age Group --

CREATE VIEW avg_estimated_salary_per_age_group AS
SELECT ROUND(AVG(estimated_salary),2) AS estimated_salary, 
       CASE 
         WHEN Age BETWEEN 18 AND 40 THEN '18-40'
         WHEN Age BETWEEN 41 AND 60 THEN '41-60'
         WHEN Age BETWEEN 61 AND 100 THEN '61-100'
       END AS age_group
FROM customer_churn_records
GROUP BY 2;

-- No of Male And Female Customers --

CREATE VIEW gender_breakdown_of_customer_base AS
SELECT Gender, COUNT(*)
FROM customer_churn_records
GROUP BY 1;


-- Churn --

-- Customers Total VS No Longer Customers --

CREATE VIEW churn AS
SELECT a.still_a_customer, b.total_customers
FROM (
    SELECT COUNT(*) AS still_a_customer
    FROM customer_churn_records
    WHERE no_longer_a_customer = "no"
) AS a
CROSS JOIN (
    SELECT COUNT(*) AS total_customers
    FROM customer_churn_records
) AS b;

-- Do More People Drop Off When They Have More Products? --

CREATE VIEW no_of_products_vs_drop_off AS
SELECT no_of_products, 	COUNT(no_longer_a_customer) AS Number_Of_People_That_Have_Left
FROM customer_churn_records
GROUP BY 1, no_longer_a_customer
HAVING no_longer_a_customer = "Yes"
ORDER BY 2 DESC; ; 

-- Which Country Has A Higher Churn Rate? --

CREATE VIEW churn_rate_per_country AS
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

CREATE VIEW card_vs_lost_customers AS
SELECT card_type, COUNT(no_longer_a_customer) AS clients_leaving
FROM customer_churn_records
GROUP BY 1, no_longer_a_customer
HAVING no_longer_a_customer = "Yes"
ORDER BY 2 DESC;


-- How Many People Have Lodged Complaints For Each Card Type?--

SELECT card_type, COUNT(Complain) AS complaints
FROM customer_churn_records
GROUP BY 1;
