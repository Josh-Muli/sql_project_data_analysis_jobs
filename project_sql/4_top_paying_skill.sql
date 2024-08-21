/* 
Question: What are the  top paying skills based on salary?
- Look at the average salary associated with each skill for Data Analyst.
- Focus on roles with specific salalaries, regardless of location
- Why? It reveils how different skills impact salary levels for Data Analysts
    and helps identify the most financially rewarding skills to  acquire or improve
    
*/


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


/*

Big Data, Machine Learning, and Cloud Skills
DevOps and Automation Integration
Cross-Disciplinary Programming and Database Management

[
  {
    "skills": "pyspark",
    "avg_salaries": "208172.25"
  },
  {
    "skills": "bitbucket",
    "avg_salaries": "189154.50"
  },
  {
    "skills": "watson",
    "avg_salaries": "160515.00"
  },
  {
    "skills": "couchbase",
    "avg_salaries": "160515.00"
  },
  {
    "skills": "datarobot",
    "avg_salaries": "155485.50"
  },
  {
    "skills": "gitlab",
    "avg_salaries": "154500.00"
  },
  {
    "skills": "swift",
    "avg_salaries": "153750.00"
  },
  {
    "skills": "jupyter",
    "avg_salaries": "152776.50"
  },
  {
    "skills": "pandas",
    "avg_salaries": "151821.33"
  },
  {
    "skills": "golang",
    "avg_salaries": "145000.00"
  },
  {
    "skills": "elasticsearch",
    "avg_salaries": "145000.00"
  },
  {
    "skills": "numpy",
    "avg_salaries": "143512.50"
  },
  {
    "skills": "databricks",
    "avg_salaries": "141906.60"
  },
  {
    "skills": "linux",
    "avg_salaries": "136507.50"
  },
  {
    "skills": "kubernetes",
    "avg_salaries": "132500.00"
  },
  {
    "skills": "atlassian",
    "avg_salaries": "131161.80"
  },
  {
    "skills": "twilio",
    "avg_salaries": "127000.00"
  },
  {
    "skills": "airflow",
    "avg_salaries": "126103.00"
  },
  {
    "skills": "scikit-learn",
    "avg_salaries": "125781.25"
  },
  {
    "skills": "jenkins",
    "avg_salaries": "125436.33"
  },
  {
    "skills": "notion",
    "avg_salaries": "125000.00"
  },
  {
    "skills": "scala",
    "avg_salaries": "124903.00"
  },
  {
    "skills": "postgresql",
    "avg_salaries": "123878.75"
  },
  {
    "skills": "gcp",
    "avg_salaries": "122500.00"
  },
  {
    "skills": "microstrategy",
    "avg_salaries": "121619.25"
  },
  {
    "skills": "crystal",
    "avg_salaries": "120100.00"
  },
  {
    "skills": "go",
    "avg_salaries": "115319.89"
  },
  {
    "skills": "confluence",
    "avg_salaries": "114209.91"
  },
  {
    "skills": "db2",
    "avg_salaries": "114072.13"
  },
  {
    "skills": "hadoop",
    "avg_salaries": "113192.57"
  }
]
*/
