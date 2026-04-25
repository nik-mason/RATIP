---
name: Luminous Glass
colors:
  surface: '#f9f9ff'
  surface-dim: '#cfdaf2'
  surface-bright: '#f9f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f0f3ff'
  surface-container: '#e7eeff'
  surface-container-high: '#dee8ff'
  surface-container-highest: '#d8e3fb'
  on-surface: '#111c2d'
  on-surface-variant: '#464555'
  inverse-surface: '#263143'
  inverse-on-surface: '#ecf1ff'
  outline: '#777587'
  outline-variant: '#c7c4d8'
  surface-tint: '#4d44e3'
  primary: '#3525cd'
  on-primary: '#ffffff'
  primary-container: '#4f46e5'
  on-primary-container: '#dad7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#4953bc'
  on-secondary: '#ffffff'
  secondary-container: '#8792fe'
  on-secondary-container: '#17228f'
  tertiary: '#46494b'
  on-tertiary: '#ffffff'
  tertiary-container: '#5e6163'
  on-tertiary-container: '#dadcde'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3323cc'
  secondary-fixed: '#e0e0ff'
  secondary-fixed-dim: '#bdc2ff'
  on-secondary-fixed: '#000767'
  on-secondary-fixed-variant: '#2f3aa3'
  tertiary-fixed: '#e0e3e5'
  tertiary-fixed-dim: '#c4c7c9'
  on-tertiary-fixed: '#191c1e'
  on-tertiary-fixed-variant: '#444749'
  background: '#f9f9ff'
  on-background: '#111c2d'
  surface-variant: '#d8e3fb'
typography:
  display-xl:
    fontFamily: Manrope
    fontSize: 48px
    fontWeight: '800'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '700'
    lineHeight: '1.3'
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.4'
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.5'
  label-sm:
    fontFamily: Inter
    fontSize: 14px
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
  base: 8px
  xs: 4px
  sm: 12px
  md: 24px
  lg: 40px
  xl: 64px
  gutter: 24px
  margin: 32px
---

## Brand & Style

This design system is anchored in a sophisticated **Glassmorphism** aesthetic, optimized for clarity and a premium feel. The brand personality is ethereal yet structured, evoking a sense of light, air, and high-end craftsmanship. It targets users who appreciate a focused, uncluttered environment where information feels layered rather than flat.

The visual direction uses multi-layered translucency and high-refraction blurs to create depth. By prioritizing "white glass"—translucent white surfaces over soft, colorful background gradients—the UI achieves a "frosted" effect that feels modern and lightweight. The emotional response should be one of calm, professional reliability and effortless elegance.

## Colors

The palette is dominated by "Pure White" and "Indigo." The primary Indigo (#4F46E5) is reserved for high-priority actions, active states, and brand signatures. 

- **Primary (Indigo):** Used for CTA buttons, progress indicators, and primary navigation links.
- **Surface (White/Glass):** Surfaces utilize varying opacities of white (from 40% to 80%) to achieve the glass effect.
- **Neutral:** A deep slate is used exclusively for typography and icons to ensure high contrast against the translucent backgrounds.
- **Backgrounds:** Use subtle, large-scale mesh gradients in extremely desaturated tones of indigo and violet to provide the "source" for the backdrop blurs.

## Typography

This design system utilizes a dual-font strategy to balance character with utility. **Manrope** provides a modern, geometric feel for headings, offering a premium "SaaS" aesthetic. **Inter** is utilized for all functional text, ensuring maximum legibility across different device resolutions and small-scale interface elements.

Headings should use tighter letter spacing and bold weights to ground the airy layout. Body text should maintain generous line heights to preserve the "light" feeling of the overall system.

## Layout & Spacing

The layout philosophy follows a **fixed-fluid hybrid grid**. Content is contained within a 12-column grid system with a maximum width of 1440px to ensure white space is preserved on ultra-wide monitors. 

Spacing follows a strict 8px linear scale. To emphasize the airy aesthetic, use "oversized" padding (the `lg` and `xl` tokens) for section containers. Elements should never feel cramped; when in doubt, increase the spacing. Components are separated by a 24px gutter to maintain clear distinction between frosted glass panels.

## Elevation & Depth

Depth is achieved through **Backdrop Blurs** and **Inner Glows** rather than traditional heavy drop shadows.

- **Surface Tiers:** Primary containers use a `backdrop-filter: blur(20px)` and a `background: rgba(255, 255, 255, 0.7)`. 
- **The "Glass" Stroke:** Every frosted card must have a 1px solid border with a low-opacity white (rgba(255, 255, 255, 0.4)) to simulate light catching the edge of the glass.
- **Shadows:** Use only one level of "Ambient Shadow"—a very soft, indigo-tinted shadow (Hex #4F46E5 at 5% opacity) with a large blur (40px) to make cards appear as if they are floating gently above the background.

## Shapes

The shape language is consistently **Rounded**. A 16px (1rem) corner radius is the standard for cards and primary containers, providing a friendly and approachable feel. Small interactive elements like buttons and chips utilize slightly smaller radii to maintain visual balance. Avoid sharp corners entirely to preserve the premium, soft-touch aesthetic.

## Components

- **Buttons:** Primary buttons are solid Indigo (#4F46E5) with white text and a subtle 4px inner-bottom shadow for a tactile feel. Secondary buttons use a glass background with an Indigo border.
- **Cards:** The core of this design system. Cards must include a `backdrop-filter`, a 1px semi-transparent white border, and the standard 16px corner radius.
- **Input Fields:** Fields are slightly recessed glass (lower opacity than cards) with a 1px border that turns solid Indigo on focus. Labels should be placed above the field in `label-sm` typography.
- **Chips/Tags:** Pill-shaped with a 40% opacity Indigo background for active states, or a light glass background for neutral states.
- **Glass Modals:** Use a higher blur (40px) and a darker background overlay (20% opacity) to pull focus.
- **Navigation:** Top navigation bars should be sticky with a `backdrop-filter` to allow content to scroll beautifully beneath the translucent header.