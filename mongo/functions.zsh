export MONGO_DB_PATH="$HOME/data/db"
mkdir -p $MONGO_DB_PATH

alias mongod="mongod --dbpath $MONGO_DB_PATH"

mongo_operator_docs() {
	open "https://docs.mongodb.org/manual/reference/operator/query/#query-selectors"
}