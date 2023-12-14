/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
basesd on Thushara T. @th2797
*/
-- Helper CTE
WITH cte0(submission_date, hacker_id, row_num) AS (
    SELECT submission_date, hacker_id, ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY COUNT(submission_id) DESC, hacker_id ASC) AS row_num
    FROM submissions sub
    GROUP BY submission_date, hacker_id
),

-- Gives the hacker with the maximum number of submissions against every date
cte1(submission_date, hacker_id, name) AS (
    SELECT temp.submission_date, temp.hacker_id, h.name
    FROM cte0 temp
    LEFT JOIN hackers h ON temp.hacker_id = h.hacker_id
    WHERE temp.row_num = 1
),
    
-- Gives the current date, the hacker IDs, and the respective number of submissions that have been made before the current date
cte2(prev_date, hacker, total) AS (
    -- Since there are no dates/submissions prior to "2016-03-01"
    SELECT submission_date, hacker_id, 0 FROM cte0 WHERE submission_date = "2016-03-01"
    
    UNION ALL
    
    SELECT c.submission_date, q.hacker_id, COUNT(t.submission_date)
    FROM cte1 c, cte1 t, cte0 q
    WHERE c.submission_date > t.submission_date AND q.submission_date = t.submission_date AND q.hacker_id IN (SELECT hacker_id FROM cte0 WHERE submission_date = c.submission_date)
    GROUP BY c.submission_date, q.hacker_id
    HAVING COUNT(t.submission_date) = DAY(c.submission_date) - 1
)
 
-- The final results against every date combining the above 2 common table expressions
SELECT a.submission_date, COUNT(b.hacker), a.hacker_id, a.name
FROM cte1 a
LEFT JOIN cte2 b ON a.submission_date = b.prev_date
GROUP BY a.submission_date, a.hacker_id, a.name
ORDER BY a.submission_date;