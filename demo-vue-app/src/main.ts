import { createApp } from 'vue';
import { DemoButton } from 'demo-vue-lib';

// Using template string - this is where type inference fails
const app = createApp({
  components: { DemoButton },
  template: `<demo-button value="test" @demo-click="handleClick" />`,
  methods: {
    handleClick(event) {
      // ❌ Bug: 'event' is inferred as 'any' instead of CustomEvent<ClickDetail>
      // Vue's template compiler can't infer the event type from the component
      console.log(event.detail);
    }
  }
});

app.mount('#app');