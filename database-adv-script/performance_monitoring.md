# this is perforamnce monitoring
Seq Scan on bookings  (cost=0.00..10.00 rows=2 width=36) (actual time=0.050..0.070 rows=1 loops=1)
  Filter: (user_id = '550e8400-e29b-41d4-a716-446655440000'::uuid)
  Rows Removed by Filter: 3
Planning Time: 0.040 ms
Execution Time: 0.080 ms

Hash Left Join  (cost=0.25..20.50 rows=3 width=52) (actual time=0.100..0.120 rows=3 loops=1)
  Hash Cond: (b.property_id = p.property_id)
  -> Seq Scan on bookings  (cost=0.00..10.00 rows=4 width=36) (actual time=0.030..0.040 rows=4 loops=1)
  -> Hash  (cost=0.15..0.15 rows=3 width=16) (actual time=0.050..0.050 rows=3 loops=1)
        -> Seq Scan on properties  (cost=0.00..0.15 rows=3 width=16) (actual time=0.020..0.030 rows=3 loops=1)
              Filter: (host_id = '550e8400-e29b-41d4-a716-446655440003'::uuid)
              Rows Removed by Filter: 0
Planning Time: 0.070 ms
Execution Time: 0.130 ms