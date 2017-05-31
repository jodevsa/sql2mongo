# sql2mongo
## transpile simple sql queries into mongo queries

### supported features:
### - query operation

| Operation | Implemented |
|-----------|:-----------:|
| SELECT    |     True    |
| INSERT    |    False    |
| UPDATE    |    False    |
| DELETE    |    False    |
### - conditions
| condition        | Implemented | Example (mysql)                                | Example (OUTPUT) (MONGO)                                                               |
|------------------|:-----------:|------------------------------------------------|----------------------------------------------------------------------------------------|
| Equal            |     True    | select id,name from objects where id=3               | {"collection": "objects","conditions": {"id": 3},"show": {id:1,name:1}}                           |
| Between          |     True    | select * from objects where id between 1 and 3 | {"collection": "objects","conditions": {"$and": [{"$lte": 3},{"$gte": 1}]},"show": {}} |
| Greater-or-equal |     True    | select * from object where id>=3;              | {"collection": "objects","conditions": {"id":{"$gte": 3}},"show": {}}                  |
| Lower-or-equal   |     True    | select * from object where id<=5               | {"collection": "objects","conditions": {"id":{"$lte": 5}},"show": {}}                  |
| Lower            |     True    | select* from objects where id<3                | {"collection": "objects","conditions": {"id":{"$lt": 5}},"show": {}}                   |
| Greater          |     True    | select * from objects where id>5;              | {"collection": "objects","conditions": {"id":{"$gt": 5}},"show": {}}                   |
| IN               |     True    | select * from objects where id in (1,2,3,4);   | {"collection": "objects","conditions": {"id":{"$in": [1,2,3,4]}},"show": {}}           |

- ### combinations of conditions are implemented but without "()"
    ##### example: select id from objects where id=3 and x between 0 and 5
- ### all JOIN operations are not implemented.
- ### all GROUP BY operations are not implemented.
- ### multiple sql queries are not implemented .
