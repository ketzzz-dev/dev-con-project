# Project README — Structure & Guidelines

**Purpose:**
This README describes the canonical project layout, naming conventions, and step-by-step guidelines for adding content or moving files. Follow this to keep the repo predictable, avoid broken references, and make designer/dev handoffs painless.

---

## Quick overview (what goes where)

```
res://
├─ assets/                 # art, audio, models, shaders, textures, animations
├─ scenes/                 # all scene files (.tscn) grouped by domain
│  ├─ core/                # global scenes & managers (GameRoot, persistent singletons)
│  ├─ ui/
│  │  ├─ screens/          # full-screen UI: main_menu, pause_menu
│  │  └─ components/       # reusable controls: option, keypad_ui, item_ui
│  └─ world/
│     ├─ levels/           # playable levels (level_00_name.tscn)
│     ├─ prefabs/          # reusable world prefabs (keypad.tscn, items)
│     └─ entities/         # entity scenes (player.tscn, npc prefabs)
├─ scripts/                # all GDScript organized by domain
│  ├─ core/                # autoloads + utilities (dialogue_manager, signal_bus)
│  ├─ entities/            # player, props, components
│  ├─ gameplay/            # dialogue resource types, interactables
│  └─ ui/                  # ui controllers
├─ resources/              # custom Resource files (DialogueGraph etc.)
├─ tools/                  # editor tools, exporters
└─ project.godot           # autoloads, settings
```

---

## Naming conventions

* **Scenes:** `prefix_<nn>_shortname.tscn` for ordered assets. Use `level_00_train.tscn`, `ui_main_menu.tscn`, `prefab_keypad.tscn` when appropriate.
* **Scripts:** `snake_case.gd` filenames, `PascalCase` `class_name` inside (e.g. `scripts/entities/player/player_movement.gd` with `class_name PlayerMovement`).
* **Resources:** Keep under `resources/<type>/` and name clearly — `dialogue_entrance.tres`.
* **Audio:** `assets/audio/music/` and `assets/audio/sfx/`.
* **Materials & Shaders:** `assets/materials/` and `assets/shaders/`.

---

## How to add new content (checklist)

### Add a new prefab (reusable object)

1. Create the scene under `scenes/world/prefabs/` and keep it modular (Collision + Mesh + Script). Expose configurable behaviour with exported variables.
2. Attach a script from `scripts/entities/props/` or `scripts/gameplay/` — use `class_name` for discoverability.
3. Test the prefab standalone in editor, then instance it in a level scene under `scenes/world/levels/`.
4. If the prefab needs global reactions, emit/use `SignalBus` (scripts/core/autoloads) — avoid direct singletons where possible.

### Add a new level

1. Create a new `level_<NN>_shortname.tscn` in `scenes/world/levels/`.
2. Instance prefabs and the shared `scenes/ui/components/ui.tscn` or `scenes/ui/screens/*` as needed.
3. Add a small `meta` block at top of scene in your team doc (or update `scenes/manifest.json` if used).
4. Playtest the level: input, interactions, audio, UI.

### Add UI components

1. Make component under `scenes/ui/components/` and keep them dumb: expose callbacks and signals to the screen-level controllers.
2. Logic goes under `scripts/ui/`.

### Add assets (models, audio, textures)

* Drop into `assets/...`. Use Godot import presets. Avoid manual edits of `.import` files.
* Reference assets from scenes using the in-editor `FileSystem` to avoid broken `ExtResource` paths.

---

## When moving files — safe process (use the Godot editor)

1. Prefer moving scenes and resources inside the Godot editor (FileSystem dock). Godot will update internal `ExtResource` references.
2. If you must move files on disk (git mv):

   * Run `git mv oldpath newpath`.
   * Open any scene that referenced the old path and fix broken `ExtResource` entries (search `.tscn` files for old path).
   * Run the project in editor and test the affected scenes.
3. Commit with message: `chore: move <what> to <where>` and include a one-line reason.

---

## Autoloads & singletons

* Keep autoload scripts under `scripts/core/autoloads/`.
* Register singletons in `project.godot` (already used for `DialogueManager`, `SignalBus`). Avoid putting heavy logic in `_ready()` of autoloads.

---

## Style & architecture guidelines

* Small components: prefer composition over inheritance. Split Player into movement, animator, interactor, inventory.
* Signals: use `SignalBus` for global events; local communications should be direct method calls when possible.
* Data-driven: use `Resource` objects (DialogueGraph, DialogueNode, ItemData) so non-programmers can author content.
* `class_name` for types you want visible in the editor.
* Avoid hard-coded `res://` paths in many places — use exported `PackedScene` or Resource references in inspector.

---

## Testing checklist (run these after changes)

* Open moved scenes and verify no broken `ExtResource` entries.
* Run the game main scene and verify player movement + interaction.
* Verify UI elements appear and audio plays (check audio bus names).
* Verify exported variables and inspector defaults are sane for designers.

---

## Common pitfalls & how to avoid them

* **Broken references after file moves** — move inside Godot editor or run quick `.tscn` search-replace.
* **Wrong audio paths** — keep `assets/audio/` canonical and update any leftover old `res://audio/...` references.
* **Auto-generated files `.import` / `.uid`** — don't commit these if you prefer a clean repo; ignore `.import/` and `.godot/imported/` via `.gitignore`.
* **Editor-only changes not committed** — remember to commit both `.tscn` and modified scripts/resource files.

---

## Recommended `.gitignore` snippet

```
.import/
.godot/
.export/
export.cfg
```

---

## Small team rules (please actually follow these)

* Move scenes only with the editor unless you *love* debugging `ExtResource` paths.
* When adding a global signal, document it in `scripts/core/autoloads/signal_bus.gd` and leave a one-line comment.
* Keep art designers in `assets/` and programmers in `scripts/` — collisions are the main source of merge pain.
