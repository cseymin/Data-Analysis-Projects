-- Check if there are any blanks in the timely_response column
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN timely_response IS NULL THEN 1 ELSE 0 END) AS timely_response_nulls
FROM consumer_complaints;

-- Check the number of complaints received and how many complaints are answered timely
-- by each company 
SELECT company, COUNT(*) AS no_of_complaints,
       AVG(timely_response = 'Yes') * 100 AS pct_of_timely_response
FROM consumer_complaints
GROUP BY company
ORDER BY no_of_complaints DESC, pct_of_timely_response ASC;


-- checking duplicates, if PostgreSQL was used, GROUP BY ALL would suffice
SELECT *, COUNT(*) AS occurrences
FROM consumer_complaints
GROUP BY product, sub_product, issue, sub_issue, consumer_complaint_narrative, company,
       state, tags, submitted_via, zipcode, consumer_consent_provided, date_sent_to_company,
       company_response_to_consumer, timely_response, "consumer_disputed?", complaint_id
HAVING COUNT(*) > 1;