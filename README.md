## setup

```shell
bin/setup
bin/rails db:seed
```

## get user

### Graphql Ruby

```shell
curl "http://localhost:3000/graphql" \
--json '{"query": "query UserQuery($id: ID!){ user1(id: $id){ id name } }", "operationName": "UserQuery", "variables":"{\"id\": \"1\"}"}'
```
