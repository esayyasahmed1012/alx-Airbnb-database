# Index Performance

## Query

```sql
-- Before Indexing
EXPLAIN ANALYZE
SELECT * FROM users
WHERE email = 'alice.smith@email.com';

-- Create Index
CREATE INDEX idx_users_email ON users(email);

-- After Indexing
EXPLAIN ANALYZE
SELECT * FROM users
WHERE email = 'alice.smith@email.com';
```

## Performance Analysis

**Without Index**

![without index](before_indexing.PNG)

**With Index**

![with index](after_indexing.PNG)