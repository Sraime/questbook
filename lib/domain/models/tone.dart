/// Domain-level semantic tone for a resource/status (HP, Sanity, Magic…).
/// Kept separate from the design system's `QBTone` so the domain layer has
/// no dependency on UI code — the UI maps this 1:1 when rendering.
enum Tone { neutral, danger, success, warning, info }
