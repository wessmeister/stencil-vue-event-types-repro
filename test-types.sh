#!/bin/bash

echo "🔍 Testing if event types are properly inferred..."

cd demo-vue-app

# Run tsc with proper config
OUTPUT=$(npx tsc --noEmit --strict --noImplicitAny --lib es2020,dom --skipLibCheck src/main.ts 2>&1)

# Check if there's an error about 'event' parameter having implicit 'any' type
if echo "$OUTPUT" | grep -q "Parameter 'event' implicitly has an 'any' type"; then
  echo "❌ FAILED: Event parameter has implicit 'any' type"
  echo "The event type information is lost in the Vue component!"
  exit 1
elif [ -z "$OUTPUT" ]; then
  echo "✅ PASSED: Event types are properly preserved"
  exit 0
else
  echo "Other TypeScript issues found:"
  echo "$OUTPUT"
  exit 1
fi