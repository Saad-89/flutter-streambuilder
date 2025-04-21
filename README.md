# ⏳ Flutter Async Builders: FutureBuilder & StreamBuilder

This repository demonstrates how to work with two essential widgets in Flutter: `FutureBuilder` and `StreamBuilder`. These widgets allow developers to handle asynchronous data and build responsive, dynamic UIs with ease.

---

## 📘 What Are FutureBuilder & StreamBuilder?

Flutter provides two powerful builder widgets to work with asynchronous data:

### 🔮 `FutureBuilder`
- Used when you want to handle a **single asynchronous operation**.
- Typically used for API calls, database queries, or reading local files.
- Waits for a `Future` to complete and then builds the widget based on the result.

### 🔁 `StreamBuilder`
- Used when you need to handle a **continuous stream of data**.
- Commonly used with Firebase streams, WebSockets, or periodic updates.
- Listens to a `Stream` and rebuilds the widget every time a new value is emitted.

---
