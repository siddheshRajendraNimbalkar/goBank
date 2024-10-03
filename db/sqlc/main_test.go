package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

var testQueries *Queries

const (
	DBDriver = "postgres"
	DBSource = "postgresql://root:goBankdb@localhost:5432/goRunBank?sslmode=disable"
)

func TestMain(m *testing.M) {
	conn, err := sql.Open(DBDriver, DBSource)

	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	defer conn.Close()

	testQueries = New(conn)

	os.Exit(m.Run())
}
