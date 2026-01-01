# EWWII Cheatsheet

A quick reference for **EWWII widgets, properties, and Rhai scripting**.

---

## Widget Types

### Primitive Widgets (no children)
_File: `ast.rs:11–33`_

- **label** — Display text  
- **button** — Clickable button  
- **image** — Display images (including GIFs)  
- **icon** — Display icons  
- **input** — Text input field  
- **progress** — Progress bar  
- **combo_box_text** — Dropdown menu  
- **scale (slider)** — Range slider  
- **checkbox** — Checkbox button  
- **calendar** — Calendar widget  
- **color_button** — Color picker button  
- **color_chooser** — Full color chooser widget  
- **circular_progress** — Circular progress indicator  
- **graph** — Graph widget  
- **transform** — Transform widget  

---

### Container Widgets (with children)
_File: `ast.rs:12–34`_

- **box** — Layout container  
- **flowbox** — Flow layout container  
- **expander** — Expandable container  
- **revealer** — Animated reveal container  
- **scroll** — Scrollable container  
- **overlay** — Overlay container  
- **stack** — Stack of widgets (one visible at a time)  
- **eventbox** — Container with event handling  
- **tooltip** — Tooltip wrapper  

---

### Special Widgets
_File: `ast.rs:37–39`_

- **localbind** — Bind local signals to widget properties  
- **widget_action** — Trigger actions on widgets  
- **gtk_ui** — Load GTK UI file  

---

### Top-Level Macros
_File: `ast.rs:42–47`_

- **defwindow** — Define a window  
- **poll** — Poll a command at intervals  
- **listen** — Listen to signals  
- **enter** — Entry point for widgets  

---

## Common Widget Properties
_Available on **all widgets** — `widget_definitions.rs:2618–2717`_

| Property | Type | Default | Description |
|--------|------|---------|-------------|
| `visible` | bool | `true` | Show / hide widget |
| `class` | string | — | CSS classes (space-separated) |
| `style` | string | — | Inline SCSS styles |
| `css` | string | — | Inline CSS |
| `valign` | enum | — | Vertical alignment |
| `halign` | enum | — | Horizontal alignment |
| `vexpand` | bool | `false` | Expand vertically |
| `hexpand` | bool | `false` | Expand horizontally |
| `width` | i32 | — | Width in pixels |
| `height` | i32 | — | Height in pixels |
| `active` | bool | `true` | Enable / disable widget |
| `tooltip` | string | — | Tooltip text |
| `can_target` | bool | — | Can be targeted |
| `focusable` | bool | `true` | Can receive focus |
| `widget_name` | string | — | Widget identifier |

---

## Widget-Specific Properties

### Box
_File: `widget_definitions.rs:285–347`_

- `orientation` — `"h" | "horizontal" | "v" | "vertical"` *(default: horizontal)*  
- `spacing` — `i32` *(default: 0)*  
- `space_evenly` — `bool` *(default: true)*  

---

### Label
_File: `widget_definitions.rs:1819–1936`_

- `text` — Plain text  
- `markup` — Pango markup  
- `truncate` — bool  
- `limit_width` — i32  
- `truncate_left` — bool  
- `show_truncated` — bool  
- `unindent` — bool  
- `wrap` — bool  
- `gravity` — `"north" | "south" | "east" | "west" | "auto"`  
- `xalign` — f64 *(0.0–1.0)*  
- `yalign` — f64 *(0.0–1.0)*  
- `justify` — `"left" | "right" | "center" | "fill"`  
- `wrap_mode` — `"word" | "char" | "wordchar"`  
- `lines` — i32  

---

### Button
_File: `widget_definitions.rs:1696–1817`_

- `label` — Button text  
- `onclick` — Command on left click  
- `onmiddleclick` — Command on middle click  
- `onrightclick` — Command on right click  
- `timeout` — duration *(default: 200ms)*  

---

### Image
_File: `widget_definitions.rs:1484–1584`_

- `path` — **required**, image path  
- `image_width` — i32  
- `image_height` — i32  
- `preserve_aspect_ratio` — bool  
- `fill_svg` — string  

---

### Icon
_File: `widget_definitions.rs:1586–1683`_

- `path` — Image path  
- `icon` — Icon name  
- `image_width` — i32  
- `image_height` — i32  
- `preserve_aspect_ratio` — bool  
- `fill_svg` — string  

---

### Input
_File: `widget_definitions.rs:1938–2002`_

- `value` — string  
- `placeholder` — string  
- `onchange` — Command on change  
- `onaccept` — Command on Enter  
- `password` — bool  
- `timeout` — duration  

---

### Progress
_File: `widget_definitions.rs:1432–1482`_

- `orientation` — horizontal / vertical  
- `flipped` — bool  
- `value` — f64 *(0–100)*  

---

### Slider (Scale)
_File: `widget_definitions.rs:2449–2549`_

- `value` — f64  
- `min` — f64  
- `max` — f64  
- `onchange` — Command  
- `flipped` — bool  
- `marks` — string  
- `draw_value` — bool  
- `value_pos` — left / right / top / bottom  
- `round_digits` — i32  
- `timeout` — duration  

---

### Checkbox
_File: `widget_definitions.rs:2283–2334`_

- `checked` — bool  
- `onchecked` — Command  
- `onunchecked` — Command  
- `timeout` — duration  

---

### Calendar
_File: `widget_definitions.rs:2004–2092`_

- `day` — f64 *(1–31)*  
- `month` — f64 *(1–12)*  
- `year` — f64  
- `show_heading` — bool  
- `show_day_names` — bool  
- `show_week_numbers` — bool  
- `onclick` — Command (`{0}=day {1}=month {2}=year`)  
- `timeout` — duration  

---

### Combo Box Text
_File: `widget_definitions.rs:2094–2148`_

- `items` — array of strings  
- `onchange` — Command  
- `timeout` — duration  

---

### Color Button / Color Chooser
_File: `widget_definitions.rs:2336–2440`_

- `use_alpha` — bool  
- `onchange` — Command  
- `timeout` — duration  

---

### Circular Progress
_File: `widget_definitions.rs:1283–1342`_

- `value` — f64 *(0–100)*  
- `start_at` — f64  
- `thickness` — f64  
- `clockwise` — f64  
- `fg_color` — string  
- `bg_color` — string  

---

### EventBox
_File: `widget_definitions.rs:665–1045`_

- Mouse, keyboard, drag-and-drop, and scroll event handlers  
- Cursor customization  
- Orientation & spacing options  

---

### FlowBox
_File: `widget_definitions.rs:1052–1148`_

- `orientation` — horizontal / vertical  
- `space_evenly` — bool  
- `selection_model` — none / single / browse / multiple  
- `onaccept` — Command  
- `default_select` — i32  

---

### Stack
_File: `widget_definitions.rs:1150–1213`_

- `selected` — i32  
- `transition` — slide / crossfade / none  
- `transition_duration` — i32  

---

### Revealer
_File: `widget_definitions.rs:2224–2281`_

- `transition` — animation type  
- `reveal` — bool  
- `duration` — duration  

---

### Scroll
_File: `widget_definitions.rs:2551–2611`_

- `hscroll` — bool  
- `vscroll` — bool  
- `propagate_natural_height` — bool  

---

### Expander
_File: `widget_definitions.rs:2167–2222`_

- `name` — string  
- `expanded` — bool  

---

### Overlay
_File: `widget_definitions.rs:349–394`_

- First child = base  
- Remaining children = overlays  

---

### Tooltip
_File: `widget_definitions.rs:396–451`_

- First child = tooltip content  
- Second child = target widget  

---

### LocalBind
_File: `widget_definitions.rs:453–535`_

- Properties bind local signals to child widget properties  

---

### Widget Action
_File: `widget_definitions.rs:537–636`_

- `trigger` — LocalSignal  
- `actions` — `"add-class" | "remove-class" | "set-property"`  

---

### GTK UI
_File: `widget_definitions.rs:2150–2165`_

- `file` — Path to `.ui` file  
- `id` — Widget ID  

---

## Rhai Scripting Language

### Data Types
_File: `extract_props.rs:1–138`_

- `String` — `"hello"`  
- `bool` — `true`, `false`  
- `i64` — `42`  
- `f64` — `3.14`  
- `Array` — `[1, 2, 3]`  
- `Map` — `#{ key: "value" }`  
- `Duration` — `"200ms"`, `"1s"`, `"2min"`, `"1h"`  

---

### Operators

**Arithmetic:** `+ - * / %`  
**Comparison:** `== != < > <= >=`  
**Logical:** `&& || !`  
**Assignment:** `= += -= *= /=`  
**Other:** `. ?. [] ??`

---

### Variables

```rhai
let variable = value;
const CONSTANT = value
```

### Built-in Stuff

```rhai
label(#{ ... })

button(#{ ... })

box(#{ ... }, [children])

localsignal(#{ ... })

defwindow("name", #{ ... }, widget)

poll("var", #{ ... })

listen("var", #{ ... })

enter([widgets])```

