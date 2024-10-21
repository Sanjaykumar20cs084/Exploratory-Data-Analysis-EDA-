# Exploratory-Data-Analysis-EDA

**Exploratory Data Analysis (EDA) of Layoff Data using SQL**

Project Overview:
This project focuses on performing Exploratory Data Analysis (EDA) on a layoff dataset using SQL. The goal of this analysis is to uncover meaningful insights and trends in global layoffs, including identifying the companies, industries, and countries most affected by layoffs. The dataset has already undergone a comprehensive cleaning process to ensure its accuracy and consistency.

The following SQL queries explore the dataset to reveal insights related to company layoffs, industry trends, and more. This EDA project highlights the power of SQL in extracting actionable insights from structured data.

Dataset :

The dataset contains information about layoffs, including:

`company`: Name of the company.
 `location`: The company's location.
`industry`: Industry sector.
`total_laid_off`: Total employees laid off.
`percentage_laid_off`: Percentage of the company’s workforce laid off.
 `date`: Date of layoffs.
 `stage`: Stage of the company (e.g., Seed, Series A).
 `country`: Country where the layoffs occurred.
`funds_raised_millions`: Funds raised by the company in millions.

Steps / Processes in Exploratory Data Analysis (EDA):

1. Exploring the Dataset:
A general overview of the cleaned data is performed by selecting all records from the dataset.
```sql
SELECT * FROM layoff_stage_dup;
```

2.Companies with Complete Workforce Layoffs (100%):
This query identifies companies that laid off 100% of their workforce.
```sql
SELECT * FROM layoff_stage_dup WHERE percentage_laid_off = 1;
```

3. Companies with the Highest Number of Layoffs:
Sorting companies that laid off the highest number of employees, starting from the top.
```sql
SELECT * FROM layoff_stage_dup WHERE percentage_laid_off = 1 ORDER BY total_laid_off DESC;
```

4. Total Layoffs by Company:
Summing up the total number of layoffs by each company.
```sql
SELECT company, SUM(total_laid_off) AS laid_off FROM layoff_stage_dup GROUP BY company ORDER BY laid_off DESC;
```

5. Layoff Time Period:
Identifying the first and last dates of layoffs in the dataset to understand the time period covered.
```sql
SELECT MIN(`date`) AS starting_date, MAX(`date`) AS ending_date FROM layoff_stage_dup;
```

6. Industries with the Highest Layoffs:
Identifying which industries experienced the most layoffs.
```sql
SELECT industry, SUM(total_laid_off) AS layoff_industry FROM layoff_stage_dup GROUP BY industry ORDER BY layoff_industry DESC;
```

7. Countries with the Highest Layoffs :
Identifying which countries experienced the most layoffs.
```sql
SELECT country, SUM(total_laid_off) AS layoff_country FROM layoff_stage_dup GROUP BY country ORDER BY layoff_country DESC;
```

8. Layoffs by Date:
Finding out how layoffs were distributed over individual dates.
```sql
SELECT `date`, SUM(total_laid_off) AS date_layoff FROM layoff_stage_dup GROUP BY `date` ORDER BY date_layoff DESC;
```

9. Layoffs by Year :
Breaking down layoffs by year to identify trends over time.
```sql
SELECT YEAR(`date`) AS YEARS, SUM(total_laid_off) AS year_layoff FROM layoff_stage_dup GROUP BY YEARS ORDER BY year_layoff DESC;
```

10. Companies with the Most Layoffs by Year:
This query identifies the top 5 companies with the most layoffs in each year.
```sql
WITH companies_rank AS (
    SELECT company, YEAR(`date`) AS YEARS, SUM(total_laid_off) AS laid_off 
    FROM layoff_stage_dup GROUP BY company, YEARS
)
SELECT company, YEARS, laid_off, DENSE_RANK() OVER (PARTITION BY YEARS ORDER BY laid_off DESC) AS rank
FROM companies_rank WHERE rank <= 5;
```

11. Industries with the Most Layoffs by Year:
Similarly, this query finds the top 5 industries with the highest layoffs in each year.
```sql
WITH industries_rank AS (
    SELECT industry, YEAR(`date`) AS YEARS, SUM(total_laid_off) AS laid_off 
    FROM layoff_stage_dup GROUP BY industry, YEARS
)
SELECT industry, YEARS, laid_off, DENSE_RANK() OVER (PARTITION BY YEARS ORDER BY laid_off DESC) AS rank
FROM industries_rank WHERE rank <= 5;
```

12. Rolling Sum of Layoffs by Month :
This query calculates the rolling sum of layoffs by month to observe the progression of layoffs over time.
```sql
WITH rolling_sum AS (
    SELECT SUBSTRING(`date`, 1, 7) AS monthly, SUM(total_laid_off) AS monthly_layoff 
    FROM layoff_stage_dup GROUP BY monthly ORDER BY monthly ASC
)
SELECT monthly, SUM(monthly_layoff) OVER (ORDER BY monthly) AS roll_sum FROM rolling_sum;
```

Conclusion :

The EDA process allowed for a deeper understanding of global layoff trends. Insights such as the industries and companies most affected, countries experiencing the highest layoffs, and the progression of layoffs over time were revealed using SQL.

Technologies Used
SQL (Database:MySQL)

How to Use This Project :
1. Clone the repository to your local machine.
2. Load the dataset and use the provided SQL queries to perform your own analysis and explore further trends.

Contact :
For any questions or further insights, feel free to reach out:

[LinkedIn](https://www.linkedin.com/in/sanjayk58979a251/)
[GitHub](https://github.com/Sanjaykumar20cs084)
Email: sanjaykumar2372003@gmail.com

