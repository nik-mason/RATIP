---
name: Luminous Glass
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
  on-surface-variant: '#464554'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#767586'
  outline-variant: '#c7c4d7'
  surface-tint: '#494bd6'
  primary: '#4648d4'
  on-primary: '#ffffff'
  primary-container: '#6063ee'
  on-primary-container: '#fffbff'
  inverse-primary: '#c0c1ff'
  secondary: '#4b5a9c'
  on-secondary: '#ffffff'
  secondary-container: '#a6b5fd'
  on-secondary-container: '#354585'
  tertiary: '#595c5e'
  on-tertiary: '#ffffff'
  tertiary-container: '#727577'
  on-tertiary-container: '#fbfdff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e1e0ff'
  primary-fixed-dim: '#c0c1ff'
  on-primary-fixed: '#07006c'
  on-primary-fixed-variant: '#2f2ebe'
  secondary-fixed: '#dde1ff'
  secondary-fixed-dim: '#b8c4ff'
  on-secondary-fixed: '#001354'
  on-secondary-fixed-variant: '#334282'
  tertiary-fixed: '#e0e3e5'
  tertiary-fixed-dim: '#c4c7c9'
  on-tertiary-fixed: '#191c1e'
  on-tertiary-fixed-variant: '#444749'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 60px
    fontWeight: '800'
    lineHeight: 72px
    letterSpacing: -0.02em
  headline-xl:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.01em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
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
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 14px
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
  container-max: 1280px
  gutter: 24px
  margin-page: 48px
  stack-xs: 4px
  stack-sm: 12px
  stack-md: 24px
  stack-lg: 48px
  stack-xl: 80px
---

## Brand & Style

The design system centers on a philosophy of "Airy Sophistication." It targets high-end professional platforms where clarity and prestige are paramount. The aesthetic is rooted in **Glassmorphism**, utilizing translucent layers and multi-dimensional depth to create a sense of digital tangibility.

The brand personality is visionary yet grounded. By combining a minimalist structural framework with vibrant background blurs and frosted surfaces, the UI evokes an emotional response of calm, intelligence, and modern luxury. Every element is designed to feel light, as if floating in a curated, luminous space.

## Colors

The palette is anchored by **Indigo (#6366F1)**, used strategically for primary actions and brand identifiers. To maintain the high-end feel, the system relies heavily on a "White Glass" foundation—varying opacities of pure white layered over soft, organic background gradients.

Neutrals are shifted toward cool slates to complement the Indigo, ensuring that even the most functional text elements feel integrated into the aesthetic. Backgrounds should utilize subtle mesh gradients (Indigo to Lavender to White) at low saturation to provide the necessary "matter" for the glass refraction to be visible.

## Typography

This design system utilizes **Inter** for its systematic precision and modern neutrality. The typographic hierarchy is characterized by bold, heavy-weight headlines that provide a structural anchor against the ethereal, translucent UI components.

Display and Headline levels use tight letter spacing and high weights (700-800) to command attention. Body text remains spacious and legible, utilizing a medium-to-light scale. Labels are occasionally set in uppercase with slight tracking increases to denote secondary metadata or category headers.

## Layout & Spacing

The layout philosophy is built on a **12-column fluid grid** that emphasizes generous white space. To achieve an "airy" feel, the system avoids dense clustering, preferring wide margins and significant vertical breathing room between sections.

Elements should align to an 8px base grid. Content is housed within centered containers with a maximum width of 1280px for desktop, ensuring layouts never feel overly stretched. Negative space is treated as a first-class citizen, used to separate logical groupings rather than relying on heavy dividers.

## Elevation & Depth

Depth is the defining characteristic of this design system. It is achieved through three distinct layers:

1.  **The Canvas:** A soft, multi-color mesh gradient background that remains static or moves subtly.
2.  **The Glass Surface:** Semi-transparent white containers (`rgba(255, 255, 255, 0.45)`) with a `backdrop-filter: blur(20px)`. These surfaces feature a 1px solid white border at 50% opacity to act as a "rim light," defining the edge of the glass.
3.  **The Floating Layer:** Interactive elements like primary buttons and active states use soft, diffused shadows (`box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15)`) to lift them above the glass surfaces.

Avoid using black shadows; instead, use tinted shadows that pull color from the Indigo primary or the background gradients.

## Shapes

The shape language is smooth and approachable. The system uses a **Rounded** (0.5rem base) setting to ensure that the glass surfaces feel like polished objects. 

Large containers and cards utilize `rounded-xl` (1.5rem) to emphasize the organic, premium nature of the glass panels. Buttons and input fields use `rounded-lg` (1rem) to maintain a consistent geometry that is distinct from the sharper edges of legacy corporate software.

## Components

### Buttons
Primary buttons are solid Indigo (#6366F1) with white text, featuring a subtle glow effect on hover. Secondary buttons use the white glass effect with an Indigo border or text. All buttons should have a high-tap target and 1rem corner radius.

### Cards
Cards are the primary expression of the glass aesthetic. They must include:
- `backdrop-filter: blur(24px)`
- `background: rgba(255, 255, 255, 0.4)`
- `border: 1px solid rgba(255, 255, 255, 0.5)`
- `padding: 24px or 32px`

### Input Fields
Inputs should be semi-transparent with a 1px border. On focus, the border transitions to Indigo and the background opacity increases slightly to provide visual feedback.

### Chips & Tags
Small, pill-shaped elements with `rgba(99, 102, 241, 0.1)` backgrounds and Indigo text. These act as subtle accents that don't compete with the primary call-to-action.

### Lists & Navigation
Navigation items use a "blob" indicator or a soft background highlight on hover. List items are separated by subtle white-transparency lines rather than dark dividers to maintain the airy, light-filled aesthetic.