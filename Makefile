.PHONY: postgres createdb dropdb migrateUp migrateDown sqlc

postgres:
	docker run --name goPostGDB -e POSTGRES_USER=root -e POSTGRES_PASSWORD=goBankdb -p 5432:5432 -d postgres

createdb:
	docker exec -it goPostGDB createdb --username=root --owner=root goRunBank

dropdb:
	docker exec -it goPostGDB dropdb goRunBank

migrateUp:
	migrate -path db/migrations -database "postgresql://root:goBankdb@localhost:5432/goRunBank?sslmode=disable" -verbose up

migrateDown:
	migrate -path db/migrations -database "postgresql://root:goBankdb@localhost:5432/goRunBank?sslmode=disable" -verbose down

sqlc:
	sqlc generate