WITH segment_stats as (
    SELECT NVL(seg_rows.query, seg_time.query) AS query
         , NVL(seg_rows.segment, seg_time.segment) AS segment
         , seg_rows
         , cpu_time
         , blocks_read
         , run_time
         , blocks_to_disk
         , query_scan_size
         , SUM(seg_rows.seg_rows) OVER( PARTITION BY NVL(seg_rows.query, seg_time.query) ) AS total_rows
         , SUM(CASE WHEN seg_rows.seg_rows IS NOT NULL THEN seg_time.cpu_time ELSE 0 END)
                                  OVER( PARTITION BY NVL(seg_rows.query, seg_time.query) ) AS total_cpu_time
      FROM ( SELECT query, segment, sum(rows) AS seg_rows
               FROM STV_QUERY_METRICS
              WHERE 1=1
                AND step_type <> -1
                AND segment <> -1
              GROUP BY query, segment
      ) AS seg_rows
      FULL OUTER JOIN ( SELECT query, segment, cpu_time, blocks_read, run_time,
                               blocks_to_disk, query_scan_size
                          FROM STV_QUERY_METRICS
                         WHERE 1=1
                           AND step_type = -1
                           AND segment <> -1
      ) AS seg_time
        ON seg_rows.query = seg_time.query
       AND seg_rows.segment = seg_time.segment
)
SELECT DISTINCT
       a.userid
     , a.service_class
     , a.query
     , CONVERT_TIMEZONE('gamt', 'utc', b.starttime) AS starttime
--     , CONVERT_TIMEZONE('gamt', 'utc', b.endtime) AS endtime
     , b.text
     , c.total_rows
     , a.cpu_time / 1000000 AS "cumulative_cpu_time(s)"
     , a.run_time / 1000000 AS "cumulative_run_time(s)"
     , ROUND(a.cpu_time::FLOAT / a.run_time::FLOAT * 100), 2) AS "cumulative cpu_time/run_time(%)"
     , a.blocks_read AS "read_blocks(mb)"
     , a.blocks_to_disk AS "temp_blocks(mb)"
     , c.total_cpu_time
     , a.query_queue_time AS "query_queue_time(s)"
--     , c.segment
--     , c.seg_rows
--     , c.cpu_time AS "seg_cumulative_cpu_time(s)"
--     , c.blocks_read AS "seg_read_blocks(mb)"
--     , c.run_time AS seg_run_time
--     , c.blocks_to_disk AS "seg_temp_blocks(mb)"
--     , c.query_scan_size
  FROM STV_QUERY_METRICS AS a
 INNER JOIN stv_inflight AS b
    ON a.query = b.query
 INNER JOIN segment_stats AS c
    ON c.query = a.query
 WHERE a.segment = -1
   AND a.step_type = -1
 ORDER BY 8 DESC;
