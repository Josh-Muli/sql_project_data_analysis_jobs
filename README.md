
# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top paying jobs,in-demand skills and where high demand meets high salary in data analystics.

SQL queries? check them out here: [project_sql folder](/D:\MySQL\SQL\sql_project_data_analysis_jobs\project_sql/)


# Background

Driven by a quest to nevigate the data analyst job market more effectively,this project was born from a desire to pinpoint top-tier and in-demand skills, streamlining other work to find optimal jobs.

Data is outsourced. It's packed with insights on job titles, salaries, location, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top paying data analyst jobs?
2. What skills are most required for these top-paying jobs?
3. What skills are most in demand for data analytics?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to querry the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaborations and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspect of the data analyst job market.
Here's how I approached each question.

### 1. Top Paying Data Analysts Jobs
To identify the highest-paying roles I filtered data analysts positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND
    job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT
    10;

```
Here's the breakdown of the top data analyst jobs 2023:
- **Wide Salary Range:** Top 10 paying data analysts roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like Smartl=Asset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to director of Analystics, reflecting varied roles and specializations within data analystics.

 ![Top Paying Roles](project_sql\Asset\top_paying_jobs_graph.png)
 
 *Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGTP generated this graph from my SQL query results*


### 2. Skills for Top Paying Jobs
To understand what skills are required for the top_paying jobs, I joined the jobs postings with the skills data, providing insights into what employers value for high-compesation roles.

``` sql
WITH top_paying_jobs AS(

    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT
        10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    salary_year_avg DESC;

```
Here are the breakdown of the most demanded skills forthe top 10 highest paying data analyst jobs in 2023:
- **SQL** is the leading with a bold count of 8.
- **Python** follows closely with a bold count of 7.
- **Tableau** is also highly sought after, with a bold count of 6. Other skills like **R, Snowflakes, Pandas** and **Excel** show varying degrees of demand.

![Top Skills Graph](project_sql\Asset\top_paying_skills_graph.png)

*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; Excel generated this graph from my SQL query*

### 3. Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

``` sql
SELECT 
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

```
Here's the breakdown of the most demanded skills for data analysts in 2023

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundation skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python, Tableau,** and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skill      | Demand Count |
|------------|--------------|
| SQL        | 7,291        |
| Excel      | 4,611        |
| Python     | 4,330        |
| Tableau    | 3,745        |
| Power BI   | 2,609        |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring ther average salaries associated with different skills revealed which skills are the highest  paying.

```sql
SELECT 
    skills,
    ROUND (AVG (salary_year_avg), 2) AS AVG_salaries
FROM job_postings_fact

INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
GROUP BY
    skills
ORDER BY
    avg_salaries DESC
LIMIT 30;

```
Here's a breakdown of the results for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (Datarobot, Jupyter), and Python libraries (Pandas, Numpy), refleccting the industry high vauation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitHub,Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium onskills that facilitate automation and effecient data pipeline management.
- **Cloud Computing Expertise:** Farmiliarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analystics environments, suggesting that cloud profiency significantly boosts earning potential in data analystics.

### Top Paying Skills for Data Analysts

| Skill          | Average Salary (USD) |
|----------------|----------------------|
| PySpark        | $208,172.25           |
| Bitbucket      | $189,154.50           |
| Watson         | $160,515.00           |
| Couchbase      | $160,515.00           |
| DataRobot      | $155,485.50           |
| GitLab         | $154,500.00           |
| Swift          | $153,750.00           |
| Jupyter        | $152,776.50           |
| Pandas         | $151,821.33           |
| Golang         | $145,000.00           |
| Elasticsearch  | $145,000.00           |
| Numpy          | $143,512.50           |
| Databricks     | $141,906.60           |
| Linux          | $136,507.50           |
| Kubernetes     | $132,500.00           |
| Atlassian      | $131,161.80           |
| Twilio         | $127,000.00           |
| Airflow        | $126,103.00           |
| Scikit-learn   | $125,781.25           |

*Table of the average salary for the top 20 paying skills for Data Analysts*

### 5. Most Optimal Skills to Learn

Combining insights fromdemand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

``` sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND (AVG(job_postings_fact.salary_year_avg), 2) AS average_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT
    25;

```
| Skill ID | Skill         | Demand Count | Average Salary (USD) |
|----------|---------------|--------------|-----------------------|
| 8        | Go            | 27           | 115,319.89             |
| 234      | Confluence    | 11           | 114,209.91             |
| 97       | Hadoop        | 22           | 113,192.57             |
| 80       | Snowflake     | 37           | 112,947.97             |
| 74       | Azure         | 34           | 111,225.10             |
| 77       | BigQuery      | 13           | 109,653.85             |
| 76       | AWS           | 32           | 108,317.30             |
| 4        | Java          | 17           | 106,906.44             |
| 194      | SSIS          | 12           | 106,683.33             |
| 233      | Jira          | 20           | 104,917.90             |
| 79       | Oracle        | 37           | 104,533.70             |
| 185      | Looker        | 49           | 103,795.30             |
| 2        | NoSQL         | 13           | 101,413.73             |
| 1        | Python        | 236          | 101,397.22             |
| 5        | R             | 148          | 100,498.77             |
| 78       | Redshift      | 16           | 99,936.44              |
| 187      | Qlik          | 13           | 99,630.81              |
| 182      | Tableau       | 230          | 99,287.65              |
| 197      | SSRS          | 14           | 99,171.43              |
| 92       | Spark         | 13           | 99,076.92              |
| 13       | C++           | 11           | 98,958.23              |
| 186      | SAS           | 63           | 98,902.37              |
| 7        | SAS           | 63           | 98,902.37              |
| 61       | SQL Server    | 35           | 97,785.73              |
| 9        | JavaScript    | 20           | 97,587.00              |

*Table of the most optimal skills for data analyst sorted by salary*

Here's the breakdown of the most optimal skills for a Data Analyst in 2023:

- **Go Programming Language Commands the Highest Average Salary:** The skill **"Go" (Golang)** tops the list with an average salary of *$115,319.89.* This indicates a strong demand for Go developers, particularly in roles that require efficient, concurrent programming for scalable applications.

- **Specialized Tools and Platforms Offer Competitive Salaries:** Skills like **"Confluence" and "Hadoop"** offer average salaries exceeding *$113,000.* This suggests that expertise in specific tools and platforms, especially those related to collaboration **(Confluence) and big data (Hadoop)**, are highly valued in the market.

- **Cloud and Data Warehouse Technologies Are In Demand:** Skills like **"Snowflake", "Azure", "BigQuery", and "AWS"** are prominently featured with average salaries around *$110,000.* This highlights the growing importance of cloud computing and data warehousing technologies as organizations increasingly migrate to the cloud and seek efficient data storage and processing solutions.

- **Traditional Programming Languages Still Hold Strong Value:** Languages like **"Python", "R", and "Java"** are in high demand, with Python having the highest demand count at *236*. Despite their longstanding presence in the industry, these languages continue to offer competitive salaries around *$100,000*, underscoring their enduring relevance in data analysis and development.


# What I learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:
- **Complex Query Crafting:** Mastered the art of afvanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **Data Aggregation:** Got cozy with GROUP BY, and turned aggregated functions mlike COUNT() and AVG() into mmy data-summerizing sidekicks.
- **Analytical Wizardty:** Leveled upmy real-world puzzle-solving, skills, turningquestions into actionable, insightful SQL queries.


# Conclusions

## Insights
1. **High Salary Potential and Diverse Job Opportunities:** Data analyst roles offer a wide salary range, from $184,000 to $650,000, with companies across various industries, such as SmartAsset, Meta, and AT&T, showing strong interest in hiring top talent.

2. **Demand for Programming and Data Tools:** SQL and Python are the leading skills, with SQL appearing 8 times and Python 7 times in top-paying roles. Additionally, tools like Tableau, R, and Snowflake are also in high demand, reflecting the importance of both foundational and specialized data skills.

3. **Emphasis on Big Data, Machine Learning, and Cloud Computing:** Skills in big data technologies (e.g., PySpark, Hadoop), machine learning tools (e.g., Datarobot, Jupyter), and cloud platforms (e.g., Snowflake, Azure, AWS) command high salaries, underscoring the industry’s focus on advanced data processing and predictive analytics.

4. **Intersection of Data Analysis and Software Engineering:** Proficiency in software development and deployment tools (e.g., Go, Kubernetes, Airflow) is highly valued, highlighting the lucrative crossover between data analysis and engineering, particularly in roles that require automation and efficient data pipeline management.

5. **Strong Value in Traditional Programming Languages:** Despite the rise of new technologies, traditional programming languages like Python, R, and Java continue to hold strong value in the market, with Python being particularly prominent due to its versatility in data analysis and development.

### Closing thoughts
This value enhanced my SQL skills and provided valuables insights into the data analysts into the data analyst job market. The findings from the analysis serve as a guide to prioririzing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high demand, high-salary skills. This exploration highlight the importance of continous learning an adoptation to emerging trends in the field of data analystics.