CREATE EXTERNAL TABLE IF NOT EXISTS `test`.`real_estate_apt_trade` (
    `sggcd` STRING,
    `umdnm` STRING,
    `aptnm` STRING,
    `jibun` STRING,
    `excluusear` STRING,
    `dealyear` STRING,
    `dealmonth` STRING,
    `dealday` STRING,
    `dealamount` STRING,
    `floor` STRING,
    `buildyear` STRING,
    `cdealtype` STRING,
    `cdealday` STRING,
    `dealinggbn` STRING,
    `estateagentsggnm` STRING,
    `rgstdate` STRING,
    `aptdong` STRING,
    `slergbn` STRING,
    `buyergbn` STRING,
    `landleaseholdgbn` STRING
)
PARTITIONED BY (
    `deal_ymd` INT,
    `lawd_cd` INT
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
    'ignore.malformed.json' = 'FALSE',  -- TRUE로 설정하면 잘못된 JSON 구문은 패스 (기본값 : FALSE)
    'dots.in.keys' = 'FALSE',           -- TRUE로 설정하면 Key의 '.'을 '_'로 변환함 (기본값 : FALSE)
    'case.insensitive' = 'TRUE',        -- TRUE로 설정하면 모든 대문자열을 소문자로 변환함 (기본값 : TRUE)
    'mapping' = 'TRUE'                  -- TRUE로 설정하면 열 이름을 JSON 키와 매핑합니다.
)
STORED AS INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://<bucket-name>/<s3-key>/'
TBLPROPERTIES ('classification' = 'json')
;