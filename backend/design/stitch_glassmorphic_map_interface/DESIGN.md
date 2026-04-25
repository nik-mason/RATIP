---
name: Luminous Map Design System
colors:
  surface: '#0b1326'
  surface-dim: '#0b1326'
  surface-bright: '#31394d'
  surface-container-lowest: '#060e20'
  surface-container-low: '#131b2e'
  surface-container: '#171f33'
  surface-container-high: '#222a3d'
  surface-container-highest: '#2d3449'
  on-surface: '#dae2fd'
  on-surface-variant: '#c7c4d8'
  inverse-surface: '#dae2fd'
  inverse-on-surface: '#283044'
  outline: '#918fa1'
  outline-variant: '#464555'
  surface-tint: '#c3c0ff'
  primary: '#c3c0ff'
  on-primary: '#1d00a5'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#4d44e3'
  secondary: '#89ceff'
  on-secondary: '#00344d'
  secondary-container: '#00a2e6'
  on-secondary-container: '#00344e'
  tertiary: '#bdc2ff'
  on-tertiary: '#131e8c'
  tertiary-container: '#4a55be'
  on-tertiary-container: '#d7d8ff'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#c9e6ff'
  secondary-fixed-dim: '#89ceff'
  on-secondary-fixed: '#001e2f'
  on-secondary-fixed-variant: '#004c6e'
  tertiary-fixed: '#e0e0ff'
  tertiary-fixed-dim: '#bdc2ff'
  on-tertiary-fixed: '#000767'
  on-tertiary-fixed-variant: '#2f3aa3'
  background: '#0b1326'
  on-background: '#dae2fd'
  surface-variant: '#2d3449'
typography:
  headline-xl:
    fontFamily: Inter
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Inter
    fontSize: 10px
    fontWeight: '500'
    lineHeight: 12px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  container-margin: 24px
  glass-padding: 12px
---

## Brand & Style

This design system is engineered for high-end geospatial applications, urban mobility, and premium travel interfaces. The brand personality is sophisticated, futuristic, and technologically advanced, aiming to evoke a sense of clarity and depth. 

The design style is rooted in **Glassmorphism**, emphasizing spatial relationships through translucent layers and high-quality background blurs. By treating the map as the foundational "earth" layer, all UI elements act as floating crystalline "lenses" that provide information without obscuring the geographical context. The aesthetic is defined by its use of vibrant light-emissive accents against deep, frosted backgrounds, creating a professional yet evocative user experience.

## Colors

The palette is optimized for a dark-mode-first map experience to allow the Indigo accent to reach peak vibrance.

- **Primary (Indigo):** Used for critical actions, active states, and primary navigation paths. It features a "glow" property in its interactive state.
- **Secondary (Sky):** Utilized for secondary data visualizations, such as transit lines or weather overlays.
- **Tertiary (Violet):** Reserved for soft highlights and subtle differentiation in complex data sets.
- **Neutral:** A deep navy slate serves as the base for background blurs, ensuring legibility and contrast against the varying colors of the map tiles.
- **Glass Base:** A semi-transparent white (`rgba(255, 255, 255, 0.08)`) is used for the frosted glass surfaces to maintain a lightweight feel.

## Typography

This design system utilizes **Inter** exclusively to ensure maximum legibility at small sizes—a critical requirement for map labels and data-heavy sidebars. 

The typographic hierarchy relies on weight and letter spacing rather than excessive size shifts. Headlines use a tighter tracking to feel more "engineered," while labels utilize increased tracking and uppercase styling for better scannability against complex map backgrounds. Color-wise, primary text uses a high-contrast white, while secondary text uses a muted silver to maintain hierarchy.

## Layout & Spacing

The layout philosophy follows a **Fluid Grid** approach with safe-area floating containers. UI elements are not pinned to the edges but float 24px from the viewport margins to reinforce the "floating glass" aesthetic.

Spacing follows a 4px base unit. Sidebars use a standard width of 360px or 400px, while floating action buttons (FABs) and search bars are centered or corner-anchored based on device type. Elements within glass containers should use a consistent 12px or 16px internal padding to ensure the frosted edges remain visible and create a distinct frame for content.

## Elevation & Depth

Depth is the core differentiator of this design system. It is achieved through a combination of three techniques:

1.  **Backdrop Blur:** All UI panels must apply a `backdrop-filter: blur(12px)` to the background. This separates the content from the map noise while maintaining a sense of location.
2.  **Inner Glow:** Glass surfaces feature a 1px white inner stroke at 15% opacity to simulate light catching the edge of a glass pane.
3.  **Soft Shadows:** Shadows are large and highly diffused (`box-shadow: 0 20px 50px rgba(0,0,0,0.3)`). For active elements like primary buttons or selected map markers, a secondary shadow using the Indigo primary color (`rgba(79, 70, 229, 0.4)`) is applied to create a "bloom" or glowing effect.

## Shapes

The shape language is consistently **Rounded**, using 0.5rem (8px) for standard components and 1rem (16px) for larger containers like cards and side panels. 

This roundedness softens the technical nature of the map, making the interface feel modern and approachable. Search bars and pill-style chips should utilize the `rounded-xl` or full pill-shaped radius to distinguish them from structural layout containers.

## Components

- **Glass Containers:** The foundational component. Requires a semi-transparent dark background, 1px border (white at 10% opacity), and backdrop blur.
- **Buttons:** Primary buttons are solid Indigo with a soft glow shadow. Secondary buttons are glass-morphic with a 1px border.
- **Search Bar:** A floating pill-shaped glass container with high blur. Use a subtle Indigo outer glow when focused.
- **Map Markers:** Circular markers with a white border and Indigo center. Selected markers should expand slightly and emit a primary-colored pulse animation.
- **Chips/Filters:** Small, pill-shaped elements with a translucent background. When active, they transition to solid Indigo.
- **Side Panels:** Vertically oriented glass containers with a slightly higher opacity (20%) to ensure text readability over dense map areas.
- **Inputs:** Underlined or fully boxed glass fields. The "focus" state should illuminate the border in Indigo and add a subtle inner glow.