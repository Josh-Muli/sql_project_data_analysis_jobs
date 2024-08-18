/*
Question: What are the most optimal skills to learn (aka it's high demand and high paying skill)
- Identify skills in high demand and associate with high average salaries for Data Analyst roles
- Concentrate on the remote positions with specifies salaries.
Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data analysis
*/


WITH high_demand_skills AS (
    
    SELECT 
        skills_dim.skills,
        skills_dim.skill_id,
        COUNT (skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact

    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL 
        AND job_location = 'Anywhere'
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        
        skills_job_dim.skill_id,
        ROUND (AVG (salary_year_avg), 2) AS AVG_salaries
    FROM job_postings_fact

    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    high_demand_skills.skill_id,
    high_demand_skills.skills,
    average_salary,
    demand_count
FROM
    high_demand_skills
INNER JOIN average_salary ON high_demand_skills.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 30