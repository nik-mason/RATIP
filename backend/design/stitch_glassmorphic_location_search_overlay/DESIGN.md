---
name: Lumina Luxe
colors:
  surface: '#f9f9f9'
  surface-dim: '#dadada'
  surface-bright: '#f9f9f9'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f4'
  surface-container: '#eeeeee'
  surface-container-high: '#e8e8e8'
  surface-container-highest: '#e2e2e2'
  on-surface: '#1a1c1c'
  on-surface-variant: '#444748'
  inverse-surface: '#2f3131'
  inverse-on-surface: '#f0f1f1'
  outline: '#747878'
  outline-variant: '#c4c7c7'
  surface-tint: '#5f5e5e'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#1c1b1b'
  on-primary-container: '#858383'
  inverse-primary: '#c8c6c5'
  secondary: '#5c5f60'
  on-secondary: '#ffffff'
  secondary-container: '#e1e3e4'
  on-secondary-container: '#626566'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#181c1e'
  on-tertiary-container: '#818487'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e5e2e1'
  primary-fixed-dim: '#c8c6c5'
  on-primary-fixed: '#1c1b1b'
  on-primary-fixed-variant: '#474746'
  secondary-fixed: '#e1e3e4'
  secondary-fixed-dim: '#c5c7c8'
  on-secondary-fixed: '#191c1d'
  on-secondary-fixed-variant: '#454748'
  tertiary-fixed: '#e0e3e6'
  tertiary-fixed-dim: '#c4c7ca'
  on-tertiary-fixed: '#181c1e'
  on-tertiary-fixed-variant: '#43474a'
  background: '#f9f9f9'
  on-background: '#1a1c1c'
  surface-variant: '#e2e2e2'
typography:
  headline-xl:
    fontFamily: Manrope
    fontSize: 48px
    fontWeight: '700'
    lineHeight: '1.1'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.3'
  body-lg:
    fontFamily: Manrope
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  label-md:
    fontFamily: Manrope
    fontSize: 14px
    fontWeight: '600'
    lineHeight: '1.0'
    letterSpacing: 0.05em
  caption:
    fontFamily: Manrope
    fontSize: 12px
    fontWeight: '500'
    lineHeight: '1.4'
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
  margin-mobile: 16px
  margin-desktop: 64px
  section-padding: 80px
---

## Brand & Style

This design system is defined by an ethereal, high-end aesthetic that prioritizes airiness, clarity, and physical depth. It is designed for premium SaaS, luxury fintech, or high-end lifestyle platforms where the user experience should feel effortless and prestigious. 

The style merges **Minimalism** with **Glassmorphism**. By using a palette of white-on-white and layered translucency, the UI evokes a sense of "digital crystal." The emotional response is one of calm, precision, and exclusivity. Background blurs are used not just for decoration, but to provide a clear spatial mental model, suggesting that the interface exists in a three-dimensional, light-filled environment.

## Colors

The palette is intentionally monochromatic to allow the shadows and blurs to define the form.
- **Primary:** Deep charcoal/black, used exclusively for high-contrast typography and critical action icons.
- **Neutral/Surface:** Pure white is the foundation. Very light grays provide subtle differentiation between structural elements.
- **Glass Base:** A semi-transparent white (Alpha 40-70%) used for elevated panels.
- **Accent:** Subtle metallic grays and muted silvers are used for iconography to maintain a sophisticated, non-distracting visual hierarchy.

## Typography

**Manrope** is selected for its geometric yet refined proportions. It bridges the gap between technical precision and organic warmth. 
- **Headlines:** Use tight tracking and bold weights to create a sense of authority against the soft UI.
- **Body:** Generous line-height is essential to maintain the "airy" feel of the system.
- **Labels:** Small caps or uppercase with increased tracking should be used for secondary navigation or category tags to ensure they don't compete with primary content.

## Layout & Spacing

The layout utilizes a **Fixed Grid** model for desktop to ensure content remains centered and prestigious, moving to a fluid model for tablet and mobile. 
- **Rhythm:** A strict 8px square grid governs all internal padding.
- **Whitespace:** Use aggressive margins between sections to reinforce the high-end, gallery-like feel.
- **Composition:** Elements should be grouped within large, soft-edged containers. Avoid dense information clusters; prioritize "one thought per section."

## Elevation & Depth

This design system relies on a "Stacked Glass" philosophy. Depth is created through three specific layers:
1.  **The Canvas (Level 0):** Pure white or a very subtle linear gradient (White to #FDFDFD).
2.  **The Floating Layer (Level 1):** Semi-transparent white containers with a `backdrop-filter: blur(20px)`. These use a 1px solid white border at 50% opacity to simulate a glass edge.
3.  **The Interaction Layer (Level 2):** Elements that are being hovered or active utilize "Ambient Shadows"—ultra-diffused (40px-60px blur), low-opacity (5-10%) shadows that use a slight cool-gray tint rather than pure black.

Avoid hard drop shadows or heavy inner glows. The goal is for elements to look like they are caught in soft, natural light.

## Shapes

The shape language is **Rounded**, favoring organic but controlled curves. 
- **Standard Radius:** 0.5rem (8px) for small components like inputs and buttons.
- **Container Radius:** 1.5rem (24px) for large glass cards and modals to emphasize the softness of the glassmorphism.
- **Consistency:** Never mix sharp corners with rounded corners. Even secondary elements like checkboxes should carry a subtle 4px radius.

## Components

- **Buttons:** Primary buttons are solid charcoal with white text. Secondary buttons utilize the glass effect: a blurred background with a subtle 1px border. No heavy gradients.
- **Glass Cards:** The hero component. Use `background: rgba(255, 255, 255, 0.6)` combined with `backdrop-filter: blur(12px)`. Add a subtle "inner glow" using a top-left 1px highlight.
- **Input Fields:** Minimalist. No background fill by default; only a soft bottom border or a very faint gray outline. Upon focus, the field transforms into a soft-glass container.
- **Chips/Badges:** Small, pill-shaped elements with a light gray background (#F1F3F5) and medium-weight typography.
- **Iconography:** Use "Thin" or "Light" stroke weights. Icons should never be filled; they should feel like wireframes to maintain the ethereal quality of the UI.
- **Modals:** Use a full-screen backdrop blur (`blur(8px)`) with a dark overlay at only 5% opacity to maintain the "white theme" feel while directing focus.