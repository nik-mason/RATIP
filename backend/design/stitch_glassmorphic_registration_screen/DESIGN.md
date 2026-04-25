---
name: Etheric Glass
colors:
  surface: '#f9f9fe'
  surface-dim: '#d9dade'
  surface-bright: '#f9f9fe'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f8'
  surface-container: '#ededf2'
  surface-container-high: '#e8e8ed'
  surface-container-highest: '#e2e2e7'
  on-surface: '#1a1c1f'
  on-surface-variant: '#464554'
  inverse-surface: '#2e3034'
  inverse-on-surface: '#f0f0f5'
  outline: '#777586'
  outline-variant: '#c7c4d7'
  surface-tint: '#4d4ad5'
  primary: '#4441cc'
  on-primary: '#ffffff'
  primary-container: '#5e5ce6'
  on-primary-container: '#f4f1ff'
  inverse-primary: '#c2c1ff'
  secondary: '#5655a7'
  on-secondary: '#ffffff'
  secondary-container: '#a6a5fe'
  on-secondary-container: '#383788'
  tertiary: '#894200'
  on-tertiary: '#ffffff'
  tertiary-container: '#ae5600'
  on-tertiary-container: '#ffefe7'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c2c1ff'
  on-primary-fixed: '#0c006b'
  on-primary-fixed-variant: '#332dbc'
  secondary-fixed: '#e2dfff'
  secondary-fixed-dim: '#c2c1ff'
  on-secondary-fixed: '#0f0662'
  on-secondary-fixed-variant: '#3e3c8e'
  tertiary-fixed: '#ffdcc6'
  tertiary-fixed-dim: '#ffb786'
  on-tertiary-fixed: '#311300'
  on-tertiary-fixed-variant: '#723600'
  background: '#f9f9fe'
  on-background: '#1a1c1f'
  surface-variant: '#e2e2e7'
typography:
  headline-lg:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Manrope
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-caps:
    fontFamily: Manrope
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.05em
  button-text:
    fontFamily: Manrope
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  margin-page: 24px
  gutter: 16px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 32px
---

## Brand & Style
The design system is centered on a "Glassmorphism" aesthetic, designed to evoke feelings of clarity, lightness, and modern sophistication. The target audience values premium digital experiences that feel airy and non-intrusive. By utilizing translucent layers and vibrant background blurs, the interface minimizes visual weight while maintaining a clear hierarchy. The personality is ethereal yet structured, ensuring the registration process feels like a seamless transition rather than a chore.

## Colors
The palette is dominated by soft indigo and translucent neutrals. The primary indigo serves as the high-impact signal for actions and progress, while the secondary indigo provides a softer touch for secondary states. Backgrounds are not solid; they are composed of white-tinted glass surfaces that allow hinted colors from the underlying background to bleed through. High-opacity white is used for hairline borders to simulate light catching the edge of the glass.

## Typography
This design system utilizes **Manrope** for its geometric yet warm characteristics. Headlines use tighter letter spacing and heavier weights to anchor the light, translucent UI. Body text prioritizes readability with generous line heights. Labels are often presented in uppercase with increased letter spacing to provide a structural contrast against the soft, rounded edges of the container elements.

## Layout & Spacing
The layout follows a fluid grid model optimized for mobile devices. It utilizes a 4px base unit to ensure consistent scaling. Content is primarily centered within glass cards that span the width of the screen minus the 24px side margins. Vertical spacing is intentional, using "stack" tokens to separate functional groups (e.g., input fields) from navigation elements (e.g., buttons).

## Elevation & Depth
Depth is achieved through backdrop blurs and multi-layered translucency rather than traditional heavy shadows. Surfaces use a `backdrop-filter: blur(20px)` to create the frosted effect. To separate the glass layers from the background, a very soft, low-opacity indigo-tinted shadow is applied (`box-shadow: 0 8px 32px 0 rgba(94, 92, 230, 0.1)`). A 1px translucent white border is required on all glass elements to define the shape and simulate a "specular highlight" on the edge.

## Shapes
The shape language is consistently rounded to reinforce the approachable and organic nature of the design system. Primary containers and cards use a 1rem (16px) radius, while smaller interactive elements like input fields use a 0.5rem (8px) radius. This nesting of radii creates a visual harmony where inner elements feel snug within their parent containers.

## Components
- **Glass Cards**: The main container for registration forms. Must have a semi-transparent white background, a 20px backdrop blur, and a 1px white inner stroke.
- **Buttons**: Primary buttons are solid Soft Indigo with white text. Secondary buttons are "ghost" style with a glass background and indigo text.
- **Input Fields**: Softly tinted translucent backgrounds (lighter than the card) with a 1px stroke that turns Indigo on focus.
- **Progress Indicators**: Thin, horizontal bars. The unfilled track is a low-opacity indigo, while the active segment is a solid, vibrant indigo.
- **Chips**: Used for selecting interests or tags; these should be pill-shaped with a light blur and subtle indigo borders when selected.
- **Checkboxes/Radios**: Indigo-filled when active, using a white checkmark or inner dot for high contrast against the primary brand color.