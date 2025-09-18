#!/bin/bash

# Usage: ./build.sh [test]
# - ./build.sh      : Clean and build everything
# - ./build.sh test : Build and run type tests

echo "🔧 Starting build workflow..."

# Clean all ignored/generated files except .claude directory
echo "🧹 Cleaning build artifacts and dependencies..."
git clean -xdf -e .claude/

# Install dependencies if needed (for fresh clones)
echo "📦 Installing dependencies..."
[ ! -d "forked-vue-output-target/node_modules" ] && (cd forked-vue-output-target && npm i)
[ ! -d "demo-stencil-lib/node_modules" ] && (cd demo-stencil-lib && npm i)
[ ! -d "demo-vue-lib/node_modules" ] && (cd demo-vue-lib && npm i)
[ ! -d "demo-vue-app/node_modules" ] && (cd demo-vue-app && npm i)

# 1. Build vue output target
echo "📦 Building @stencil/vue-output-target..."
cd forked-vue-output-target
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Failed to build vue output target"
    exit 1
fi

# 2. Build demo-stencil-lib
echo "📦 Building demo-stencil-lib..."
cd ../demo-stencil-lib
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Failed to build demo-stencil-lib"
    exit 1
fi

# 3. Build demo-vue-lib
echo "📦 Building demo-vue-lib..."
cd ../demo-vue-lib
npm run build
if [ $? -ne 0 ]; then
    echo "❌ Failed to build demo-vue-lib"
    exit 1
fi

echo "✅ Build complete!"
echo ""

# Run type test if requested
if [ "$1" = "test" ]; then
    echo "Running type test..."
    cd ..
    ./test-types.sh
else
    echo "To test types: ./build.sh test"
    echo "To start dev server: cd demo-vue-app && npm run dev"
fi