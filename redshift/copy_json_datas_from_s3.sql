-- Standard
COPY schemaname.tablename
FROM 's3://<bucket-name>/<s3-key>/'
IAM_ROLE 'arn:aws:iam::<aws-account-id>:role/<role-name>'
FORMAT AS JSON 'auto'
;