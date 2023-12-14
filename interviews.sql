/*
Enter your query here.
15:22
*/

select 
t1.contest_id,t1.hacker_id,t1.name,
sum(sum_submission.sum_total_submissions) s1,
sum(sum_submission.sum_total_accepted_submissions) s2,
sum(sum_view.sum_total_views) s3,
sum(sum_view.sum_total_unique_views) s4

from contests t1
left join colleges t2 on t1.contest_id = t2.contest_id
left join challenges t3 on t2.college_id = t3.college_id

left join ( select challenge_id, sum(total_views) as sum_total_views,sum(total_unique_views) as sum_total_unique_views from view_stats group by challenge_id) as sum_view
on sum_view.challenge_id = t3.challenge_id

left join ( select challenge_id, sum(total_submissions) as sum_total_submissions,sum(total_accepted_submissions) as sum_total_accepted_submissions from submission_stats group by challenge_id) as sum_submission
on sum_submission.challenge_id = t3.challenge_id
group by 1,2,3
having 
sum(sum_submission.sum_total_submissions) <> 0
or sum(sum_submission.sum_total_accepted_submissions) <> 0
or sum(sum_view.sum_total_views) <> 0
or sum(sum_view.sum_total_unique_views) <> 0

order by t1.contest_id



