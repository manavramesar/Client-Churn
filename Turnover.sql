-- No of clients in each country -- 

SELECT Geography, COUNT(*) AS "Number Of Clients In Each Country"
FROM customer_churn_records 
GROUP BY Geography;

-- Which country has the highest AVG credit score --

SELECT Geography, ROUND(AVG(credit_score),2) AS "Average Credit Score"
FROM customer_churn_records
GROUP BY Geography; 

-- Do men or women have higher AVG credit scores? --

SELECT Gender, ROUND(AVG(credit_score),2) AS "Average Credit Score"
FROM customer_churn_records
GROUP BY Gender; 

-- Which card type is the most popular? --

SELECT card_type, COUNT(*) AS "Number Of Cards Issued"
FROM customer_churn_records
GROUP BY card_type; 

-- Customers Retained VS No Customers Lost --

SELECT COUNT(no_longer_a_customer) AS customers
FROM customer_churn_records
WHERE no_longer_a_customer = "no";

SELECT COUNT(no_longer_a_customer) AS sum_of_Customers
FROM customer_churn_records;


-- Age Groups And Card Type --

-- Table For This Data--

CREATE TABLE ages (
count_age INT, 
age_group VARCHAR(25)
) ;

INSERT INTO ages (age_group, count_age) VALUES 
('18-40','6419'),
('41-60','3117'),
('61-100','526'); 

SELECT DISTINCT count_age, age_group
FROM ages;

-- Query--

SELECT card_type, 
       CASE 
         WHEN Age BETWEEN 18 AND 40 THEN '18-40'
         WHEN Age BETWEEN 41 AND 60 THEN '41-60'
         WHEN Age BETWEEN 61 AND 100 THEN '61-100'
       END AS age_group,
       COUNT(*) AS count
FROM customer_churn_records
WHERE card_type IN ("Diamond", "Gold", "Silver", "Platinum")
 AND Age BETWEEN 18 AND 100
GROUP BY card_type, age_group;

-- Which Country Has A Higher Churn Rate? --

SELECT ccr.Geography, ccr_churned.churn_count, ccr.total_count, (ccr_churned.churn_count / ccr.total_count)* 100 AS churn_rate
FROM (
    SELECT Geography, COUNT(*) AS total_count
    FROM customer_churn_records
    GROUP BY Geography
) AS ccr
JOIN (
    SELECT Geography, COUNT(*) AS churn_count
    FROM customer_churn_records
    WHERE active_member = 'No'
    GROUP BY Geography
) AS ccr_churned
ON ccr.Geography = ccr_churned.Geography;

-- Do More People Drop Off When They Have Less Products? --

SELECT no_of_products, 	COUNT(no_longer_a_customer) AS "Number Of People That Have Left"
FROM customer_churn_records
GROUP BY no_of_products, no_longer_a_customer
HAVING no_longer_a_customer = "Yes"
ORDER BY COUNT(no_longer_a_customer); 

-- Which Card Type Sees The Most Drop Off? --

SELECT card_type, COUNT(no_longer_a_customer) AS "clients_leaving"
FROM customer_churn_records
GROUP BY card_type, no_longer_a_customer
HAVING no_longer_a_customer = "Yes"
ORDER BY COUNT(no_longer_a_customer);

-- How Many People Have Lodged Complaints For Each Card Type?--

SELECT card_type, COUNT(Complain) AS "complaints"
FROM customer_churn_records
GROUP BY card_type;

-- Which Gender Has  A Higher Average Salary? --

SELECT Gender, ROUND(AVG(estimated_salary),2) AS "Average Estimated Salary"
FROM customer_churn_records
GROUP BY Gender;

-- Do people with a lower satisfaction score leave? --

SELECT satisfaction_score, COUNT(no_longer_a_customer) AS count
FROM customer_churn_records
WHERE no_longer_a_customer = 'Yes'
GROUP BY satisfaction_score;

-- Does  A Longer Tenure Result In Lower Drop Off?

SELECT Tenure, COUNT(no_longer_a_customer)
FROM customer_churn_records
WHERE no_longer_a_customer = "Yes"
GROUP BY Tenure
ORDER BY Tenure;

-- Average Estiamted Salary In Each Age Group --

SELECT ROUND(AVG(estimated_salary),2) AS "estimated salary", 
       CASE 
         WHEN Age BETWEEN 18 AND 40 THEN '18-40'
         WHEN Age BETWEEN 41 AND 60 THEN '41-60'
         WHEN Age BETWEEN 61 AND 100 THEN '61-100'
       END AS age_group
FROM customer_churn_records
WHERE Age BETWEEN 18 AND 100
GROUP BY age_group;

-- No of Male And Female Customers --

SELECT Gender, COUNT(*)
FROM customer_churn_records
GROUP BY Gender;



