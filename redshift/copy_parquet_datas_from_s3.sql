-- Standard
COPY schemaname.tablename
FROM 's3://<bucket-name>/<s3-key>/'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT AS PARQUET
;


-- Column explicit notation
COPY schemaname.tablename (
    col1,
    col2,
    col3,
    ...
    col15
)
FROM 's3://<bucket-name>/<s3-key>/'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT AS PARQUET
;


-- STATUPDATE : (Auto) Statistics Update
-- COMPUPDATE : (Auto) Compression Update
COPY schemaname.tablename
FROM 's3://<bucket-name>/<s3-key>/'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT AS PARQUET
STATUPDATE OFF COMPUPDATE OFF
;


-- ACCEPTINVCHARS : Accept Invalid Characters - Replace the invalid characters with '\007' (BELL)
COPY schemaname.tablename
FROM 's3://<bucket-name>/<s3-key>/'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT AS PARQUET
ACCEPTINVCHARS AS '\007'
;