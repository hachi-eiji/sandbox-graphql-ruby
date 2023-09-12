## setup

```shell
bin/setup
bin/rails db:seed
```

## get user

### N+1 Problem

get only book
```shell
curl -s "http://localhost:3000/graphql" \
--json '{"query": "query BooksQuery{ books0 { id name purchaseOn }}", "operationName": "BooksQuery"}'
```

get book and user
```shell
curl -s "http://localhost:3000/graphql" \
--json '{"query": "query BooksQuery{ books0 { id name purchaseOn user { id name purchaseBooks{ id name purchaseOn } }}}", "operationName": "BooksQuery"}'
```

### Graphql Ruby

```shell
curl -s "http://localhost:3000/graphql" \
--json '{"query": "query BooksQuery{ books1 { id name purchaseOn user { id name purchaseBooks{ id name purchaseOn } }}}", "operationName": "BooksQuery"}'
```

### Graphql Batch

```shell
curl -s "http://localhost:3000/graphql" \
--json '{"query": "query BooksQuery{ books2 { id name purchaseOn user { id name purchaseBooks{ id name purchaseOn } }}}", "operationName": "BooksQuery"}'
```
