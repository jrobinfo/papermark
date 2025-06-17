#!/bin/bash
set -e

echo "=== Starting Papermark Debug Script ==="
echo "Environment check:"
echo "NODE_ENV: $NODE_ENV"
echo "NEXTAUTH_URL: $NEXTAUTH_URL"
echo "DOMAIN: $DOMAIN"
echo "Database URL exists: $(if [ -n "$POSTGRES_PRISMA_URL" ]; then echo "YES"; else echo "NO"; fi)"

echo ""
echo "=== Running Prisma Migrate ==="
npx prisma migrate deploy --schema=./prisma/schema/schema.prisma || {
    echo "ERROR: Prisma migrate failed!"
    echo "Trying to generate Prisma client..."
    npx prisma generate --schema=./prisma/schema/schema.prisma
    exit 1
}

echo ""
echo "=== Starting Next.js Server ==="
npm run start 