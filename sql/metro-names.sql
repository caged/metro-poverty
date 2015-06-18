select
  distinct on(cbsa_title) lower(cbsa_title),
  regexp_replace(split_part(split_part(lower(cbsa_title), ',', 1), '-', 1), '\.|\s|\/', '_') as name,
  cbsa_num
from
  tract_data
order by cbsa_title
