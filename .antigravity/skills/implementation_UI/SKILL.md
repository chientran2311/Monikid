---
name: implementation-ui
description: Refactor Flutter screen UI by separating complex, overlapping code into standalone Widget classes. Use when users ask to "refactor UI", "clean UI code", "split widgets", or "clean up screens". This skill handles the workflow of extracting local widgets into `features/.../widgets/` and reusable widgets into `shared/widgets/`.
---

# UI Implementation & Refactoring Skill

This skill guides you through refactoring and cleaning up Flutter UI code by extracting complex or overlapping widgets into standalone, reusable components.

## When to Use

Use this skill when:
- User wants to refactor or clean up a Flutter screen's UI.
- User asks to split large screen files into smaller widgets.
- The UI code of a screen is too long (e.g., > 300 lines) and needs better organization.

## Core Objective

The main goal of this plan is to clean up code of screens in each feature by separating complex, overlapping widgets into standalone Widget classes.

## Refactoring Strategy

### 1. Local Widgets (`features/[feature_name]/[screen_name]/widgets/`)
- Any UI section that is specific to a single screen (e.g., a "Header" with an illustration for a Login screen, or a "SegmentedControl" for an Add Transaction screen) should be extracted into separate files and placed in a `widgets` folder at the same level as the screen.
- Convert `_buildWidgetName()` functions that are inside a `ScreenState` class into standalone `StatelessWidget` (or `StatefulWidget` if they need local state) in their own independent files.
- Pass required state via constructor (or use Riverpod `ref.watch`/`ref.read` depending on complexity).
- When passing callbacks, use named arguments like `required VoidCallback onPressed` or `required ValueChanged<String> onChanged`.

### 2. Shared Reusable Widgets (`shared/widgets/`)
- If during extraction you notice a widget being used across multiple different screens or it has a general UI purpose (like a common Form Field layout, a unified Bottom Sheet, or a shared Card display), move it into `shared/widgets/`.
- Ensure shared widgets are decoupled from specific feature logic.

## Step-by-Step Workflow

1. **Analyze the HTML source first**(if user request or there is exactly HTML code for the screen in project):
   - Before implementing a screen, read the corresponding HTML file in the `html_code/` folder that matches the screen you're about to build.
   - Ask yourself: "Have I analyzed every component in this HTML carefully? Are these widgets small enough and reusable enough?"
   - If a widget appears reusable, break it down into smaller sub-widgets.

2. **Analyze the Screen code**:
   - Read the target screen's code. Identify distinct visual sections (e.g., Header, Form, Footer, RoleSelector).
   - Check if the screen is unnecessarily long.

3. **Extract Widgets**:
   - Create a `widgets` directory inside the screen's directory if it doesn't exist.
   - For each section, create a new `.dart` file (e.g., `login_header.dart`).
   - Move the UI code into a `StatelessWidget`.
   - Ensure you import required themes, colors, and types in the new widget file.

4. **Update the Main Screen**:
   - Import the newly created widgets.
   - Replace the large chunks of code or `_buildX()` methods with the extracted widget class.
   - Pass necessary callbacks to handle interactions.

5. **Verify**:
   - Run `flutter analyze` to ensure no syntax errors.
   - Ensure the app builds properly without import errors.

## Widget Placement Rules

| Widget type | Where to put it |
|---|---|
| Used only by one screen | `features/.../[screen]/widgets/` |
| Used by multiple screens or features | `shared/widgets/` |

## Layout Widgets to Know Before Implementing

Before converting HTML to Flutter UI, understand and use the following layout widgets appropriately:

### `SafeArea`
- Use when a `Scaffold` has **no AppBar or BottomBar**, especially for full-screen layouts.
- Protects the UI from being obscured by device notches, camera cutouts, and system UI intrusions.
- Example: splash screens, onboarding screens, login screens without an AppBar.

### `MediaQuery`
- Use when you need to get the **screen's dimensions** to adjust layout proportions.
- Ideal when a widget's size should be a **percentage of the screen** (e.g., `MediaQuery.of(context).size.width * 0.8`).

### `LayoutBuilder`
- Use when you need the **parent widget's constraints** to determine the size of a child widget.
- More suitable for **child widgets** that need to adapt to their parent's available size.
- Example: A card that adapts to fit inside a grid or a custom panel.

## Checklist Before Finishing

- [ ] All `_buildX()` private methods in the main screen are replaced by extracted widgets.
- [ ] Local widgets are in `features/.../[screen]/widgets/`.
- [ ] Shared widgets are in `shared/widgets/`.
- [ ] You are actually **using** the widgets you created (imported and placed in the widget tree).
- [ ] `SafeArea`, `MediaQuery`, or `LayoutBuilder` applied where needed.
- [ ] `dart format` and `flutter analyze` run with no new errors.
