// // view_model/event_bus.ets
//
// type EventHandler<T = void> = (payload: T) => void;
//
// class EventBus {
//   private listeners: Map<string, Set<EventHandler<any>>> = new Map();
//
//   on<T>(event: string, handler: EventHandler<T>): void {
//     if (!this.listeners.has(event)) {
//       this.listeners.set(event, new Set());
//     }
//     this.listeners.get(event)?.add(handler as EventHandler<any>);
//   }
//
//   off<T>(event: string, handler: EventHandler<T>): void {
//     const handlers = this.listeners.get(event);
//     if (handlers) {
//       handlers.delete(handler as EventHandler<any>);
//     }
//   }
//
//   emit<T>(event: string, payload: T): void {
//     const handlers = this.listeners.get(event);
//     if (handlers) {
//       for (const handler of handlers) {
//         handler(payload);
//       }
//     }
//   }
// }
//
// export default new EventBus();