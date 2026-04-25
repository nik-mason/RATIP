---
name: Luminous System
colors:
  surface: '#f7f9fb'
  surface-dim: '#d8dadc'
  surface-bright: '#f7f9fb'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f4f6'
  surface-container: '#eceef0'
  surface-container-high: '#e6e8ea'
  surface-container-highest: '#e0e3e5'
  on-surface: '#191c1e'
  on-surface-variant: '#464555'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eff1f3'
  outline: '#777587'
  outline-variant: '#c7c4d8'
  surface-tint: '#4d44e3'
  primary: '#3525cd'
  on-primary: '#ffffff'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#006591'
  on-secondary: '#ffffff'
  secondary-container: '#39b8fd'
  on-secondary-container: '#004666'
  tertiary: '#7e3000'
  on-tertiary: '#ffffff'
  tertiary-container: '#a44100'
  on-tertiary-container: '#ffd2be'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#c9e6ff'
  secondary-fixed-dim: '#89ceff'
  on-secondary-fixed: '#001e2f'
  on-secondary-fixed-variant: '#004c6e'
  tertiary-fixed: '#ffdbcc'
  tertiary-fixed-dim: '#ffb695'
  on-tertiary-fixed: '#351000'
  on-tertiary-fixed-variant: '#7b2f00'
  background: '#f7f9fb'
  on-background: '#191c1e'
  surface-variant: '#e0e3e5'
typography:
  display-xl:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
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
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
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
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  2xl: 64px
  gutter: 24px
  margin: 32px
---

## Brand & Style
This design system is built on the principles of clarity, depth, and precision. It leverages **Glassmorphism** to create a sense of light and air, using semi-transparent surfaces to imply a multi-layered digital environment. The personality is sophisticated and technical, yet approachable, making it ideal for high-end SaaS, creative tools, or premium utility applications. 

The aesthetic focuses on "optical physics"—how light passes through glass, how shadows settle on blurred backgrounds, and how micro-borders define edges in a translucent space. The goal is a high-fidelity interface that feels expensive and polished.

## Colors
The palette is anchored by **Indigo (#4F46E5)**, used strategically for primary actions and brand emphasis. To complement the glass effect, the system utilizes a spectrum of whites and ultra-light grays that serve as the base for translucent layers.

- **Primary:** Indigo (#4F46E5) for high-priority interaction.
- **Secondary:** Sky Blue (#0EA5E9) for accents and supportive information.
- **Surface:** White with varying opacities (70% for cards, 40% for background elements).
- **Stroke:** Low-opacity white (40-60%) for the "inner glow" border effect characteristic of glassmorphism.

## Typography
The typography utilizes **Inter**, a typeface designed for screens, to ensure maximum legibility against blurred backgrounds. 

The type hierarchy is systematic: Headlines use tighter letter-spacing and heavier weights to maintain authority, while body text remains neutral. Label styles are used for navigation and metadata, often utilizing medium or semi-bold weights to ensure they stand out against semi-transparent surfaces.

## Layout & Spacing
The design system employs a **12-column fluid grid** for desktop and a **4-column grid** for mobile. A base unit of 4px governs all padding and margin decisions, creating a rhythmic 8px/16px/24px progression. 

Large internal padding (usually 24px or 32px) is required for glass containers to allow the background blur to be appreciated without crowding the content. Elements are spaced generously to prevent the UI from feeling cluttered, maintaining the "light and airy" brand promise.

## Elevation & Depth
Depth is not achieved through heavy drop shadows, but through **Backdrop Blur** and **Tonal Stacking**. 

- **Level 1 (Base):** The canvas background, often a soft gradient.
- **Level 2 (Panels):** `backdrop-filter: blur(12px)` with a 70% white opacity. Subtlest shadow: `0 4px 12px rgba(0,0,0,0.03)`.
- **Level 3 (Modals/Popovers):** `backdrop-filter: blur(20px)` with an increased shadow: `0 20px 40px rgba(0,0,0,0.08)`.

Every glass element must feature a **1px solid border** with a white opacity of 40-50% to simulate a light-catching edge.

## Shapes
The shape language is consistently **Rounded**. This softness offsets the technical nature of the glass effect. Standard components use a 0.5rem (8px) radius. Larger containers like cards use 1rem (16px), and modal overlays use 1.5rem (24px). Buttons and input fields should remain consistent with the 8px radius to feel precise and clickable.

## Components

### Buttons
- **Primary:** Solid Indigo (#4F46E5) with white text. No transparency.
- **Secondary:** Glass-style (White 20% opacity) with a 1px white border and Indigo text.
- **States:** Hover effects should increase the background opacity or add a subtle white glow.

### Cards
Cards are the hero of this design system. They must use `backdrop-filter: blur(16px)`, a background of `rgba(255, 255, 255, 0.6)`, and a 1px white border. Corners are `rounded-lg`.

### Input Fields
Inputs are semi-transparent with a 1px border that turns Indigo (#4F46E5) on focus. The background is a slightly darker white (`rgba(255, 255, 255, 0.3)`) to indicate interactivity.

### Chips & Tags
Small, highly rounded (pill-shaped) elements. Use primary Indigo with 10% opacity for the background and 100% opacity for the text to create a "tinted glass" look.

### Navigation
Sidebars and Topbars should use the same glass treatment but with a higher blur value (24px) to ensure they sit clearly above the scrolling content. Active states are indicated by a 2px Indigo vertical or horizontal line.