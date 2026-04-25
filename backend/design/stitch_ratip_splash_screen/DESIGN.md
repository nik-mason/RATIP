---
name: Luminous Clarity
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
  on-surface-variant: '#47464f'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#787680'
  outline-variant: '#c8c5d0'
  surface-tint: '#5b598c'
  primary: '#070235'
  on-primary: '#ffffff'
  primary-container: '#1e1b4b'
  on-primary-container: '#8683ba'
  inverse-primary: '#c4c1fb'
  secondary: '#006a61'
  on-secondary: '#ffffff'
  secondary-container: '#86f2e4'
  on-secondary-container: '#006f66'
  tertiary: '#080c0d'
  on-tertiary: '#ffffff'
  tertiary-container: '#1f2224'
  on-tertiary-container: '#86898b'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e3dfff'
  primary-fixed-dim: '#c4c1fb'
  on-primary-fixed: '#181445'
  on-primary-fixed-variant: '#444173'
  secondary-fixed: '#89f5e7'
  secondary-fixed-dim: '#6bd8cb'
  on-secondary-fixed: '#00201d'
  on-secondary-fixed-variant: '#005049'
  tertiary-fixed: '#e0e3e5'
  tertiary-fixed-dim: '#c4c7c9'
  on-tertiary-fixed: '#191c1e'
  on-tertiary-fixed-variant: '#444749'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  headline-xl:
    fontFamily: Inter
    fontSize: 40px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '600'
    lineHeight: '1.3'
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: '1.4'
    letterSpacing: '0'
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
    letterSpacing: '0'
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.5'
    letterSpacing: '0'
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1'
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: '1'
    letterSpacing: 0.02em
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
  lg: 48px
  xl: 64px
  margin-mobile: 20px
  margin-desktop: 40px
  gutter: 16px
---

## Brand & Style

The brand personality of this design system is defined by "Quiet Precision." It is designed to feel like a high-end concierge service—unobtrusive, intelligent, and impeccably organized. The target audience consists of discerning travelers and urban professionals who value efficiency and aesthetic calm over visual noise.

The design style is a sophisticated blend of **Minimalism** and **Glassmorphism**. By prioritizing a primary white canvas and generous whitespace, the system creates an atmosphere of luxury and clarity. Glassmorphic elements are used sparingly for map overlays to maintain context of the underlying geography while providing a distinct, tactile layer for user interaction. The emotional response should be one of serenity and confidence, ensuring the user feels in control of their journey without being overwhelmed by data.

## Colors

The palette is anchored in a pristine white background to maximize the sense of space and cleanliness. The primary color is a **Deep Indigo**, used for critical path actions and branding elements to convey authority and modern elegance. A **Sophisticated Teal** serves as the secondary accent, specifically reserved for "active" states, navigation paths, and success indicators, providing a subtle but clear visual distinction.

Neutral tones are strictly limited to cool-tinted light greys to maintain a cohesive, premium feel. To achieve the requested "soft glow," specific components utilize a very low-opacity indigo tint instead of traditional grey shadows, creating an ethereal, luminous quality that differentiates the product from standard utility apps.

## Typography

This design system utilizes **Inter** exclusively to achieve a systematic, utilitarian, yet modern look. The typographic hierarchy is built on a high-contrast ratio between headlines and body text. Headlines use tighter letter-spacing and heavier weights to anchor the page, while body copy is set with generous line heights to ensure maximum legibility during movement.

To maintain the premium feel, labels for metadata (like distances or ETA) use a slightly increased letter-spacing and uppercase styling, creating a clean, architectural rhythm. Pure black text is avoided; instead, the Deep Indigo or a dark Slate is used for text to keep the palette soft and refined.

## Layout & Spacing

The layout philosophy follows a **Fluid Grid** model for the underlying map layer, while UI controls are treated as "floating modules." This design system employs a strict 8px spacing rhythm to ensure mathematical harmony across all components.

Vertical rhythm is prioritized to create "breathing rooms" within the interface. Ample margins (20px on mobile) ensure that interactive elements are never crowded against the screen edges. Content cards and search bars should appear to float over the map with significant padding (md/24px) from the viewport top and bottom, reinforcing the minimalist and high-end aesthetic.

## Elevation & Depth

Elevation in this design system is communicated through **Ambient Shadows** and **Backdrop Blurs**. Rather than using harsh, dark shadows, this system employs extra-diffused, multi-layered shadows tinted with the primary Indigo. This creates a "glow" effect rather than a traditional drop shadow, making elements appear as if they are resting on a bed of light.

To maintain context while navigating the map, all floating panels utilize a high-quality backdrop blur (20px-30px radius) with a 70% opacity white fill. This creates a frosted-glass effect that feels premium and prevents the UI from feeling "pasted" onto the map. Tonal layering is used for inner cards (e.g., a location detail card inside a search results list) using subtle shifts in white-to-light-grey backgrounds instead of additional shadows.

## Shapes

The shape language is defined by "Organic Geometry." This design system uses a **Rounded (Level 2)** approach to evoke friendliness and modern comfort. 

Standard components like buttons and small cards use a 0.5rem (8px) radius. Larger containers, such as bottom sheets or main search modules, utilize a `rounded-xl` (1.5rem / 24px) radius to create a soft, inviting frame for content. Pill-shaped geometry is reserved exclusively for high-frequency interactive elements like map chips (filters) and the primary search bar, signaling their "tappability" at a glance.

## Components

- **Buttons:** Primary buttons feature a solid Deep Indigo background with white text and a soft indigo glow. Secondary buttons use a transparent background with a thin Slate border.
- **Search Bar:** A prominent pill-shaped component with a soft-glow shadow. It remains fixed at the top of the viewport with a high backdrop blur.
- **Chips/Filters:** Small, pill-shaped elements used for map categories. Active chips transition from a white background to the Sophisticated Teal accent.
- **Location Cards:** Pure white backgrounds with `rounded-lg` corners. Information is separated by whitespace rather than dividers wherever possible.
- **Bottom Sheets:** Use `rounded-xl` top corners and a subtle "handle" bar. These contain the primary map details and transitions.
- **Inputs:** Minimalist design with a focus on the active state; when focused, the input border disappears and is replaced by a soft teal outer glow.
- **Map Markers:** Custom iconography featuring the primary Deep Indigo with a soft-white halo to ensure visibility against varied map textures.