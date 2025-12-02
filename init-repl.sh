#!/bin/bash
set -e

echo "⏳ Waiting 15s before starting initialization..."
sleep 15

echo "⏳ Waiting for MongoDB (mongo) to be ready..."
until mongosh "mongodb://${MONGO_INITDB_ROOT_USERNAME:-mongo}:${MONGO_INITDB_ROOT_PASSWORD:-mongo}@mongo:27017/admin?authSource=admin" --quiet --eval "db.runCommand({ ping: 1 }).ok" &>/dev/null; do
  sleep 2
done

echo "✅ MongoDB is ready, initializing replica set..."
mongosh "mongodb://${MONGO_INITDB_ROOT_USERNAME:-mongo}:${MONGO_INITDB_ROOT_PASSWORD:-mongo}@mongo:27017/admin?authSource=admin" <<'EOF'
try {
  rs.initiate({
    _id: "rs0",
    members: [{ _id: 0, host: "mongo:27017" }]
  });
  print("✅ Replica set initialized with mongo:27017");
} catch(e) {
  print("⚠️ Replica set already exists or failed to initialize: " + e);
}
EOF

echo "✅ Replica set setup completed."
