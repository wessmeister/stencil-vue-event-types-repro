# Stencil Vue Output Target - Event Type Inference Bug

Vue templates cannot infer event parameter types from Stencil components.

## Steps to Reproduce

```bash
git clone <repo>
cd stencil-vue-event-types-repro
./build.sh
./test-types.sh
```

## Expected Behavior

Event parameters in Vue templates should have inferred types from the Stencil component definition.

## Actual Behavior

```
❌ FAILED: Event parameter has implicit 'any' type
```

TypeScript error at `demo-vue-app/src/main.ts:9`:
```typescript
methods: {
  handleClick(event) {
    //        ^^^^^ Parameter 'event' implicitly has an 'any' type
  }
}
```

## Additional Context

The generated Vue wrapper (`demo-vue-lib/src/components.ts`) passes events as a string array to `defineContainer`, preventing Vue's template compiler from inferring event types:

```typescript
export const DemoButton = defineContainer('demo-button', undefined, [
  'value',
  'demoClick'
], [
  'demoClick'  // ← String array, no type information
]);
```

**Note:** Type inference works correctly when using Vue's `h()` function directly. The issue only affects template syntax.