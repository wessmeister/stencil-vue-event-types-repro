import { Component, Event, EventEmitter, Prop, h } from '@stencil/core';

export interface ClickDetail {
  value: string;
  timestamp: number;
}

@Component({
  tag: 'demo-button',
  shadow: true,
})
export class DemoButton {
  @Prop() value: string = '';

  @Event() demoClick: EventEmitter<ClickDetail>;

  private handleClick = () => {
    this.demoClick.emit({
      value: this.value,
      timestamp: Date.now()
    });
  };

  render() {
    return <button onClick={this.handleClick}>{this.value}</button>;
  }
}