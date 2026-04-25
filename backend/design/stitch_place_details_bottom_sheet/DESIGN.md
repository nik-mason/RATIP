---
name: Luminous Minimalist
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#444748'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#747878'
  outline-variant: '#c4c7c7'
  surface-tint: '#5f5e5e'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#1c1b1b'
  on-primary-container: '#858383'
  inverse-primary: '#c8c6c5'
  secondary: '#4648d4'
  on-secondary: '#ffffff'
  secondary-container: '#6063ee'
  on-secondary-container: '#fffbff'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#191c1e'
  on-tertiary-container: '#818486'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e5e2e1'
  primary-fixed-dim: '#c8c6c5'
  on-primary-fixed: '#1c1b1b'
  on-primary-fixed-variant: '#474746'
  secondary-fixed: '#e1e0ff'
  secondary-fixed-dim: '#c0c1ff'
  on-secondary-fixed: '#07006c'
  on-secondary-fixed-variant: '#2f2ebe'
  tertiary-fixed: '#e0e3e5'
  tertiary-fixed-dim: '#c4c7c9'
  on-tertiary-fixed: '#191c1e'
  on-tertiary-fixed-variant: '#444749'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  display:
    fontFamily: Manrope
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.02em
  h1:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  h2:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Manrope
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
    letterSpacing: '0'
  body-md:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: '0'
  label-caps:
    fontFamily: Manrope
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  margin-mobile: 24px
  gutter: 16px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 32px
---

## Brand & Style

This design system is anchored in a high-end, ethereal aesthetic that balances the technical precision of **Glassmorphism** with the quiet confidence of **Minimalism**. It targets a sophisticated audience that values clarity, tactile depth, and a premium feel. The interface should feel like a series of light-refracting surfaces floating in an airy, infinite space. 

The emotional response is one of calm, focus, and exclusivity. By utilizing high-quality backdrop blurs and subtle luminescence, the system creates a sense of physical layering without the heaviness of traditional skeuomorphism. Transitions are fluid and organic, mimicking the way light shifts across glass surfaces.

## Colors

The palette is intentionally restrained to maintain a "high-end" gallery feel. The primary canvas is not a flat white, but a soft, off-white gradient that provides a base for the glass effects to catch light. 

- **Primary:** A deep charcoal used strictly for high-contrast text and essential grounding elements.
- **Secondary (Action):** A sophisticated periwinkle/indigo used sparingly for active states, primary buttons, and notifications.
- **Surface & Glass:** Multiple opacities of white (10% to 70%) are used to create the frosted effect.
- **Border/Stroke:** Ultra-thin, low-opacity light strokes simulate the "edge" of a glass pane.

## Typography

**Manrope** is the sole typeface for this design system, chosen for its geometric yet modern proportions that bridge the gap between technical and organic. 

- **Headlines:** Set with tighter letter-spacing and heavier weights to command attention against the soft backgrounds.
- **Body Text:** Uses standard weights with generous line-height to ensure maximum readability over translucent layers.
- **Labels:** Small-scale text should often be set in uppercase with increased letter-spacing to maintain a refined, editorial feel.
- **Color Application:** Use high-contrast charcoal for headings and a medium-slate for secondary body text to establish a clear information hierarchy.

## Layout & Spacing

The layout philosophy follows a **Fluid Grid** model with generous safe-area margins. Because the design system relies on floating glass panels, whitespace (negative space) is treated as a functional element that allows the background blurs to "breathe."

- **Margins:** A standard 24px side margin ensures content does not feel cramped on mobile displays.
- **Vertical Rhythm:** Elements are stacked using a 4px base unit. Larger components (like glass cards) should be separated by at least 32px to maintain the floating appearance.
- **Padding:** Internal padding for containers should be generous (20px-24px) to prevent text from nearing the rounded edges of the glass panels.

## Elevation & Depth

Depth is the defining characteristic of this design system. It is achieved through a combination of backdrop filters and ambient shadows:

- **Backdrop Blur:** Primary glass containers must use a `blur(20px)` to `blur(40px)` effect.
- **Shadows:** Avoid harsh, black shadows. Use extremely diffused, large-radius shadows (e.g., `blur: 30px, offset-y: 10px`) with a very low opacity (5-8%) tinted with the primary or secondary color.
- **Layering:** When elements are stacked, the "higher" element should have a slightly higher opacity and a more pronounced shadow, while the "lower" element recedes with more transparency.
- **The "Inner Glow":** Apply a 1px semi-transparent white border to the top and left edges of cards to simulate a light source hitting the glass edge.

## Shapes

The design system uses a **Rounded** shape language to evoke a friendly, modern, and ergonomic feel. 

- **Cards & Panes:** Use `rounded-xl` (1.5rem / 24px) to create a soft, handheld feel.
- **Buttons & Inputs:** Use `rounded-lg` (1rem / 16px) for a consistent but slightly more precise look.
- **Icons:** Should feature rounded terminals and consistent stroke weights to match the softened edges of the UI.
- **Smoothness:** Always apply a slight "squircle" curvature where possible to ensure the corners feel more organic than a standard geometric radius.

## Components

- **Glass Cards:** The core container. Features a `rgba(255, 255, 255, 0.6)` background, a 1px white border at 20% opacity, and a heavy backdrop blur.
- **Primary Buttons:** High-contrast solid fills (using the Secondary color) with a subtle "lift" on press. No glass effect here to ensure clear call-to-action.
- **Ghost Buttons:** Transparent background with a 1px border. Used for secondary actions to keep the interface light.
- **Input Fields:** Semi-transparent glass wells with a subtle inset shadow to indicate "emptiness" or a place for data.
- **Chips/Badges:** Small, highly pill-shaped (`rounded-xl`) glass elements with a 10% opacity tint of the secondary color.
- **Segmented Controls:** A glass track with a solid, slightly elevated "slider" to indicate the active state.
- **Bottom Sheets:** Use high-radius top corners (32px) and a significant backdrop blur to overlay the main content without losing context.