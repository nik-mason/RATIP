---
name: Ratip Visual Identity
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
  outline-variant: '#c6c5d7'
  surface-tint: '#484bd6'
  primary: '#2c2abc'
  on-primary: '#ffffff'
  primary-container: '#4648d4'
  on-primary-container: '#d1d1ff'
  inverse-primary: '#c0c1ff'
  secondary: '#855300'
  on-secondary: '#ffffff'
  secondary-container: '#fea619'
  on-secondary-container: '#684000'
  tertiary: '#00496b'
  on-tertiary: '#ffffff'
  tertiary-container: '#00628d'
  on-tertiary-container: '#abdaff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e1e0ff'
  primary-fixed-dim: '#c0c1ff'
  on-primary-fixed: '#06006c'
  on-primary-fixed-variant: '#2e2ebe'
  secondary-fixed: '#ffddb8'
  secondary-fixed-dim: '#ffb95f'
  on-secondary-fixed: '#2a1700'
  on-secondary-fixed-variant: '#653e00'
  tertiary-fixed: '#c9e6ff'
  tertiary-fixed-dim: '#89cefe'
  on-tertiary-fixed: '#001e2f'
  on-tertiary-fixed-variant: '#004c6e'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  display-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 60px
    fontWeight: '800'
    lineHeight: '1.1'
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.01em
  title-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: '1.4'
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  label-caps:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '700'
    lineHeight: '1'
    letterSpacing: 0.08em
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  container-max: 1440px
  page-margin: 32px
  gutter: 24px
  section-padding: 96px
  stack-lg: 48px
  stack-md: 24px
  stack-sm: 12px
  unit: 8px
---

## Brand & Style
The Ratip brand is defined by a "Premium Discovery" aesthetic, targeting sophisticated users who value data integrity and personal privacy. The UI evokes a sense of crystalline clarity and technological precision through a hybrid of **Modern Minimalism** and **Glassmorphism**. 

The emotional response should be one of "trust through transparency"—achieved via airy layouts, high-end 3D imagery, and a color palette that feels both calm and technologically advanced. Visual elements utilize soft gradients and background blurs (backdrop-filters) to create a sense of depth and lightness, avoiding heavy shadows in favor of light-refractive properties.

## Colors
The palette is rooted in a "Fidelity" color logic, where the primary indigo (#4648D4) drives the core interaction points and brand identity. 

- **Primary & Tints:** Indigo is used for primary actions and brand flourishes. It is often paired with a 5-8% opacity radial gradient to create ambient environmental lighting.
- **Surface Strategy:** The background uses a very cool white-blue (#F8F9FF). Surfaces are rarely solid; they transition into semi-transparent "glass" layers that allow background gradients to bleed through.
- **Secondary Accents:** A warm amber/gold (#F59E0B) is used sparingly for status indicators and high-visibility "New" badges, providing a necessary temperature contrast to the cool-toned UI.
- **Semantic Neutrality:** Text uses a deep navy-slate (#0B1C30) rather than pure black to maintain the premium, soft-contrast feel.

## Typography
The system relies exclusively on **Plus Jakarta Sans** to maintain a modern, geometric, yet approachable feel. 

- **Scale & Hierarchy:** There is a dramatic contrast between "Display" sizes (used for hero statements) and "Body" text. 
- **Character:** Headlines use heavy weights (700-800) with tight letter-spacing to feel impactful and "branded." 
- **Utility:** Labels and small metadata use uppercase styling with increased letter spacing (tracking) to ensure legibility and a professional, architectural tone.

## Layout & Spacing
The layout follows a **Fixed-Width Centered** model for desktop, constrained to a 1440px max-width container. 

- **Grid:** A standard 12-column logic is implied, but the layout frequently utilizes "Bento Grid" arrangements for feature showcases, mixing spanned columns (e.g., 2/3 vs 1/3) to create visual interest.
- **Rhythm:** A vertical rhythm of 96px (12 units) is used to separate major sections, giving the content significant "breathable" space. 
- **Internal Padding:** Cards and containers use generous internal padding (32px to 48px) to reinforce the airy, premium feel.

## Elevation & Depth
Depth is achieved through **Optical Translucency** rather than traditional physical shadows.

- **Glassmorphism:** Key containers (Glass Cards) use a 20px backdrop-blur combined with a semi-transparent white fill and a thin, high-contrast border (1px white at 40-60% opacity). This simulates a sheet of glass floating over the background.
- **Ambient Glows:** Instead of drop shadows, "Ambient Glows" are used—large, blurred radial gradients (indigo or violet) positioned behind primary imagery or cards to suggest a light source.
- **Subtle Inner Shadows:** Small utility elements (like icon containers) may use a very light inner shadow to create a "pressed" or "carved" look into the glass surface.

## Shapes
The shape language is **Ultra-Rounded (Pill-shaped)**, emphasizing safety, approachability, and modern tech aesthetics.

- **Large Containers:** Section-level cards and CTA blocks use aggressive rounding (3rem or 48px).
- **Interactive Elements:** Buttons and badges are consistently "full" or pill-shaped.
- **Micro-elements:** Even icons and small decorative pips use rounded terminators. 
- **Consistency:** Avoid sharp corners entirely; even "rectangular" images should carry at least a 1.5rem (24px) radius.

## Components
- **Buttons:** Primary buttons are pill-shaped with a solid primary fill and high-contrast text. They should feature a hover state that includes a soft indigo glow (shadow-glow) and a subtle scale-down on click (active:scale-95).
- **Glass Cards:** The signature component. Must have `backdrop-filter: blur(20px)`, a thin semi-transparent white border, and a subtle white-to-transparent linear gradient fill.
- **Badges/Chips:** Use a light version of the category color (e.g., secondary-container at 10% opacity) with a 1px border. Often paired with a "Shimmer" animation or a small pulsing dot to indicate live status.
- **Bento Cells:** Individual grid units within a feature section. They should vary in size but maintain identical corner radii and border treatments.
- **Top App Bar:** A "Sticky" glass header that remains at the top of the viewport. It should use a thinner blur and a bottom border to separate it from the main content during scroll.