$2b$10$2AUiP8wnBxvYjpnQbQnQFeAFdP5JiNV/wI66k0pqnFwC9a3XpNZt6

database app_db

table user 
id int,
username,
password,
role,
status

table topic
id int,
topic_name,
description,
sdate,
edate,
isActive

table indicator
id int,
topic_id,
type enum(1_4,yes_no),
weight decimal(3,1),
description text,
evidence_kind,
evidence_name,
evidence_path,
evidence_url
FK topic_id

table assignment
id int,
topic_id,
evaluator_id,
evaluatee_id,
committee_role enum('chair','member')
status enum('pending','committed'),
signature_path,
comment text
ีuq_assign(topic_id,evaluator_id,evaluatee_id)
FK topic_id
FK evaluator_id
FK evaluatee_id

table evidence
id int,
topic_id,
evaluatee_id,
indicator_id,
detail,
self_score decimal(3,1),
self_note,
URL
uq_evi(topic_id,evaluatee_id,indicator_id)
FK topic_id
FK evaluatee_id
FK indicator_id

table evidence_file
id int,
evidence_id,
file_name,
file_path,
file_mime,
file_size
FK evidence_id

table reviews
id int,
assignment_id,
indicator_id,
score decimal(3,1)
uq_reviews(assignment_id,indicator_id)
FK assignment_id
FK indicator_id

