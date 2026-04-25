---
name: Reviewer Pro
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
  on-surface-variant: '#464554'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eff1f3'
  outline: '#767586'
  outline-variant: '#c7c4d7'
  surface-tint: '#494bd6'
  primary: '#4648d4'
  on-primary: '#ffffff'
  primary-container: '#6063ee'
  on-primary-container: '#fffbff'
  inverse-primary: '#c0c1ff'
  secondary: '#565e74'
  on-secondary: '#ffffff'
  secondary-container: '#dae2fd'
  on-secondary-container: '#5c647a'
  tertiary: '#904900'
  on-tertiary: '#ffffff'
  tertiary-container: '#b55d00'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e1e0ff'
  primary-fixed-dim: '#c0c1ff'
  on-primary-fixed: '#07006c'
  on-primary-fixed-variant: '#2f2ebe'
  secondary-fixed: '#dae2fd'
  secondary-fixed-dim: '#bec6e0'
  on-secondary-fixed: '#131b2e'
  on-secondary-fixed-variant: '#3f465c'
  tertiary-fixed: '#ffdcc5'
  tertiary-fixed-dim: '#ffb783'
  on-tertiary-fixed: '#301400'
  on-tertiary-fixed-variant: '#703700'
  background: '#f7f9fb'
  on-background: '#191c1e'
  surface-variant: '#e0e3e5'
typography:
  headline-xl:
    fontFamily: Manrope
    fontSize: 40px
    fontWeight: '800'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Manrope
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
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  container-max: 1200px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 48px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 32px
---

## Brand & Style

The design system focuses on a high-end, editorial feel that treats review writing as a thoughtful, premium activity. The brand personality is sophisticated and articulate, moving away from cluttered, "noisy" rating platforms toward a focused, intentional writing environment.

The aesthetic blends **Minimalism** with **Glassmorphism**. It utilizes heavy whitespace and a reduced color palette to minimize cognitive load, while translucent, frosted-glass layers provide a sense of depth and modernity. This approach ensures the user's content remains the focal point, supported by a UI that feels light, airy, and contemporary.

## Colors

The palette is anchored by a range of **Soft Grays** that define the structural surfaces without creating harsh boundaries. The **Primary Color** is a vibrant Indigo, reserved strictly for high-value actions like "Publish," "Submit," or primary navigation cues.

- **Primary (#6366F1):** A digital-first violet-blue that commands attention.
- **Secondary (#0F172A):** A deep charcoal for high-contrast text and grounding elements.
- **Neutrals:** A spectrum from Slate-50 to Slate-400 used for backgrounds, borders, and secondary text to maintain a soft, "cloud-like" appearance.
- **Glass Tint:** Semi-transparent white (rgba(255, 255, 255, 0.7)) used for frosted overlays.

## Typography

This design system uses a dual-font strategy to balance character with utility. **Manrope** is used for headlines to provide a modern, geometric, and slightly friendly personality. Its tight apertures and high x-height make it feel contemporary and premium.

**Inter** is utilized for body text and labels. It is highly legible at small sizes and provides a neutral, systematic feel that doesn't distract from the user's input. For long-form review writing, body-lg is preferred to ensure a comfortable, eye-stretching reading experience.

## Layout & Spacing

The layout philosophy follows a **Fixed Grid** on desktop to maintain an editorial, magazine-like feel, and a fluid model on mobile devices. A 12-column grid is standard for dashboard views, while a centered, single-column "focus mode" is used for the actual review writing interface.

The spacing rhythm is based on an **8px base unit**. Generous internal padding (32px+) is encouraged within cards and frosted containers to reinforce the minimalist aesthetic. Margins between distinct sections should be large to allow the glassmorphic layers to "breathe" over the background.

## Elevation & Depth

Depth is primarily communicated through **Glassmorphism** and subtle backdrop filters rather than traditional heavy shadows.

- **Level 1 (Base):** Solid white or very light gray (#F8FAFC) background.
- **Level 2 (Glass Containers):** A white fill at 70% opacity with a `backdrop-filter: blur(12px)`. These elements should have a 1px solid white border at 40% opacity to simulate light hitting the edge of the glass.
- **Level 3 (Overlays):** Used for modals or floating action buttons. These use a slightly more opaque glass effect (85%) and a very soft, diffused ambient shadow (Color: Primary-900, Opacity: 5%, Blur: 20px, Y-Offset: 10px) to indicate high elevation.

## Shapes

The design system employs a **Rounded** shape language to soften the modern aesthetic and make the app feel more approachable. 

- **Standard Elements:** 0.5rem (8px) radius for buttons and input fields.
- **Large Elements:** 1rem (16px) radius for cards, glass panels, and feature blocks.
- **Dynamic Elements:** 1.5rem (24px) for search bars or floating "Write Review" buttons to create a pill-like, distinct silhouette.

## Components

### Buttons
Primary buttons use the Indigo hex with white text and no shadow, relying on a subtle scale-down (98%) transform on click. Secondary buttons are frosted glass panels with medium-gray text.

### Input Fields
Writing areas should be borderless or use very light 1px borders (#E2E8F0). When focused, the background should shift to a subtle translucent tint of the primary color (5% opacity).

### Cards & Chips
Review cards must utilize the glassmorphic treatment. They should feel like physical slides sitting on a workspace. Chips for categories (e.g., "Food," "Service") use a solid Soft Gray background with semi-bold Inter text.

### Review-Specific Components
- **Rating Stars:** Use a customized, geometric star shape in the Primary color rather than standard yellow to maintain the sophisticated palette.
- **Progress Steppers:** For multi-part reviews, use thin lines and small dots, keeping the interface as quiet as possible.
- **Floating Writing Toolbar:** A glassmorphic pill that hovers over the text area, containing formatting tools (Bold, Italic, Lists).