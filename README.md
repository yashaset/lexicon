# Lexicon

A beautifully designed, keyboard-first vocabulary manager built with Flutter.

Lexicon helps language learners capture, organize, and review vocabulary without the clutter of traditional flashcard applications. Inspired by the simplicity of Bear, Craft, and Things, it focuses on writing, organization, and a polished desktop experience.

> **Status:** 🚧 Active Development

---

## ✨ Features

### Current

* 📚 Book management
* 📝 Entry management
* 🎯 Entry selection
* ✏️ Live editor foundation
* ⚡ Riverpod state management
* 🖥️ Three-pane desktop layout

### Planned

* 🔍 Instant search
* ⌘ Keyboard shortcuts
* 💾 Isar local database
* 📤 Import / Export
* 🏷️ Tags
* ⭐ Favorites
* 📈 Review statistics
* ☁️ Cloud sync
* 🎨 Beautiful macOS-inspired interface

---

## Tech Stack

* **Flutter**
* **Riverpod**
* **Material 3**
* **Isar** (planned)

---

## Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── shortcuts/
│   └── theme/
│
├── features/
│   ├── books/
│   ├── editor/
│   ├── entries/
│   └── search/
│
└── shared/
```

---

## Current Workflow

```text
Books
   ↓
Select Book
   ↓
Entries
   ↓
Select Entry
   ↓
Editor
   ↓
Edit Meaning / Example / Notes
```

---

## Roadmap

### Phase 1 — Vocabulary Management

* [x] Books
* [x] Entries
* [x] Entry Selection
* [ ] Editor
* [ ] Create Entry
* [ ] Delete Entry

### Phase 2 — Productivity

* [ ] Search
* [ ] Keyboard Shortcuts
* [ ] Command Palette

### Phase 3 — Persistence

* [ ] Isar Integration
* [ ] Automatic Saving
* [ ] Import / Export

### Phase 4 — Polish

* [ ] Animations
* [ ] Settings
* [ ] Themes
* [ ] Performance Optimizations

---

## Running the Project

Clone the repository:

```bash
git clone https://github.com/yashaset/lexicon.git
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

## Vision

Lexicon is designed to feel like a native desktop application rather than a traditional CRUD tool. Every interaction is intended to be fast, keyboard-friendly, and distraction-free, allowing users to focus on learning vocabulary instead of managing software.

---

## License

This project is licensed under the MIT License.
