-- Standard
UNLOAD ('
    SELECT col1
         , col2
         , col3
         , col4
      FROM schemaname.tablename
')
TO 's3://<bucket-name>/<s3-key>/'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT PARQUET
CLEANPATH
;