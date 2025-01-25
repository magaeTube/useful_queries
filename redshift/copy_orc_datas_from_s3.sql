-- Standard
COPY schemaname.tablename
FROM 'S3 Location'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT AS ORC
;

-- Column explicit notation
COPY schemaname.tablename (
    col1,
    col2,
    col3,
    ...
    col15
)
FROM 'S3 Location'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT AS ORC
;

-- STATUPDATE : (Auto) Statistics Update
-- COMPUPDATE : (Auto) Compression Update
COPY schemaname.tablename
FROM 'S3 Location'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT AS ORC
STATUPDATE OFF COMPUPDATE OFF
;