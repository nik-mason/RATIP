---
name: Crimson Frost
colors:
  surface: '#fff8f7'
  surface-dim: '#e0d8d8'
  surface-bright: '#fff8f7'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#faf2f1'
  surface-container: '#f4ecec'
  surface-container-high: '#eee6e6'
  surface-container-highest: '#e8e1e0'
  on-surface: '#1e1b1b'
  on-surface-variant: '#574140'
  inverse-surface: '#33302f'
  inverse-on-surface: '#f7efee'
  outline: '#8b7170'
  outline-variant: '#debfbe'
  surface-tint: '#a83639'
  primary: '#a83639'
  on-primary: '#ffffff'
  primary-container: '#f87171'
  on-primary-container: '#6c0513'
  inverse-primary: '#ffb3b0'
  secondary: '#645c5d'
  on-secondary: '#ffffff'
  secondary-container: '#e8dddd'
  on-secondary-container: '#696161'
  tertiary: '#006c47'
  on-tertiary: '#ffffff'
  tertiary-container: '#00b177'
  on-tertiary-container: '#003b25'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdad8'
  primary-fixed-dim: '#ffb3b0'
  on-primary-fixed: '#410006'
  on-primary-fixed-variant: '#881d24'
  secondary-fixed: '#ebe0e0'
  secondary-fixed-dim: '#cfc4c4'
  on-secondary-fixed: '#201a1b'
  on-secondary-fixed-variant: '#4c4545'
  tertiary-fixed: '#72fbba'
  tertiary-fixed-dim: '#52dea0'
  on-tertiary-fixed: '#002113'
  on-tertiary-fixed-variant: '#005235'
  background: '#fff8f7'
  on-background: '#1e1b1b'
  surface-variant: '#e8e1e0'
typography:
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 40px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
    letterSpacing: '0'
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
    letterSpacing: '0'
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 13px
    fontWeight: '600'
    lineHeight: '1'
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  container-padding: 2rem
  gutter: 1.5rem
  component-gap: 1rem
---

## Brand & Style

This design system is built on the concept of "Urgency with Empathy." It utilizes a glassmorphic aesthetic to create a sense of depth and modern sophistication, while centering the entire visual identity around a soft red palette usually reserved for warnings. By reclaiming these tones, the system feels alert yet calm, protective rather than alarming.

The brand personality is transparent, responsive, and precision-oriented. It targets high-stakes environments—such as security monitoring, health diagnostics, or financial risk management—where clarity is paramount and every detail matters. The emotional response is one of focused awareness, achieved through high-quality frosted surfaces and light-refracting borders.

## Colors

The color strategy for this design system revolves around monochromatic red layers with varying levels of opacity. 

*   **Primary:** A soft, desaturated coral-red (#F87171) used for interactive elements and critical focus states.
*   **Secondary/Surface:** An ultra-light pinkish-white (#FEF2F2) used as the base tint for glass surfaces to ensure legibility.
*   **Warning Accent:** A deep, muted crimson for high-contrast text or severe alerts.
*   **Neutrals:** Warm grays with a slight red undertone to maintain harmony across the interface.

Backgrounds should utilize soft radial gradients of pale red to deep white to provide the necessary "under-glass" depth for the glassmorphic components.

## Typography

This design system employs **Plus Jakarta Sans** for its entire type scale. The typeface's soft, rounded apertures and modern geometric structure balance the inherent tension of the red palette, making the interface feel approachable and friendly.

Headlines use a tighter letter-spacing and heavier weights to command attention, while body text remains spacious and clear. All type should be rendered in a very dark charcoal with a hint of red to ensure it doesn't feel disconnected from the glass surfaces beneath it.

## Layout & Spacing

The layout philosophy follows a **fluid grid** model that prioritizes breathing room around glass containers. Because glassmorphism relies on the visibility of the background, white space (or "negative glass space") is treated as a primary structural element.

A 12-column grid is used for desktop layouts, with generous 24px gutters. Elements are encouraged to float with significant internal padding (minimum 32px for cards) to prevent the translucent layers from feeling cluttered.

## Elevation & Depth

Depth in this design system is achieved through **Backdrop Blurs** and **Multi-layered Outlines** rather than traditional shadows.

1.  **Surfaces:** Cards use a 60-80% opacity white/red tint with a `backdrop-filter: blur(20px)`.
2.  **Borders:** Every glass element features a dual-border system: a 1px solid inner border (white, 40% opacity) and a 1px outer border (soft red, 20% opacity). This mimics the way light catches the edge of a physical glass pane.
3.  **Shadows:** When necessary, use a very large, soft "Ambient Red" shadow (e.g., `0 20px 40px rgba(248, 113, 113, 0.1)`) to suggest the element is hovering high above the background.

## Shapes

The design system utilizes **Rounded** (0.5rem base) corner radii. This level of roundedness is critical for the glassmorphic effect, as sharp corners feel too aggressive when paired with a red palette. 

Larger containers like cards or modals should use the `rounded-xl` (1.5rem) setting to emphasize their "floating" nature and create a friendly, organic feel. Interactive elements like buttons and input fields should strictly adhere to the base `rounded` (0.5rem) to maintain a sense of precision.

## Components

*   **Glass Cards:** The foundational component. Must include the backdrop blur, the dual-tinted border, and a slight top-to-bottom linear gradient (from white-tinted to red-tinted glass).
*   **Buttons:** Primary buttons are solid "Soft Red" (#F87171) with white text. Secondary buttons are "Ghost Glass" with a visible red border and red text.
*   **Input Fields:** Translucent surfaces with a 1px red bottom-border. On focus, the border opacity increases, and the background blur intensifies.
*   **Chips/Tags:** Small, pill-shaped glass elements with high-contrast red labels. Use these for categorizing status or severity.
*   **Lists:** Separated by thin, 10% opacity red lines. Each list item should have a subtle hover state that increases the glass "shine" (opacity).
*   **Indicator Dots:** Used frequently in this system to denote "live" status or warnings. These should have a subtle "pulse" animation utilizing a soft red glow.