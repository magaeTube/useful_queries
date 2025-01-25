SELECT a.txn_owner
     , a.txn_db
     , a.xid
     , a.pid
     , a.txn_start
     , a.lock_mode
     , a.relation AS table_id
     , NVL(TRIM(c."name"), d.relname) AS tablename
     , a.granted
     , b.pid AS blocking_pid
     , DATEDIFF(s, a.txn_start, getdate()) / 86400 || ' days ' || DATEDIFF(s, a.txn_start, getdate()) % 86400 / 3600 || ' hrs ' || DATEDIFF(s, a.txn_start, getdate()) % 3600 / 60 || ' mins ' || DATEDIFF(s, a.txn_start, getdate()) % 60 || ' secs ' AS txn_duration
  FROM svv_transactions AS a
  LEFT JOIN ( SELECT pid, relation, granted
                FROM pg_locks
               GROUP BY 1, 2, 3
  ) AS b
    ON a.relation = b.relation
   AND a.granted = 'f'
   AND b.granted = 't'
  LEFT JOIN ( SELECT *
                FROM stv_tbl_perm
               WHERE slice = 0
  ) AS c
    ON a.relation = c.id
  LEFT JOIN pg_class AS d
    ON a.relation = d.oid
 WHERE a.relation IS NOT NULL
;