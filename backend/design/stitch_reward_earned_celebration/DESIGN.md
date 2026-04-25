---
name: Vibrant Reward System
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
  on-surface-variant: '#464553'
  inverse-surface: '#263143'
  inverse-on-surface: '#ecf1ff'
  outline: '#777584'
  outline-variant: '#c8c4d5'
  surface-tint: '#544fc0'
  primary: '#1f108e'
  on-primary: '#ffffff'
  primary-container: '#3730a3'
  on-primary-container: '#a9a7ff'
  inverse-primary: '#c3c0ff'
  secondary: '#855300'
  on-secondary: '#ffffff'
  secondary-container: '#fea619'
  on-secondary-container: '#684000'
  tertiary: '#5d0035'
  on-tertiary: '#ffffff'
  tertiary-container: '#85004e'
  on-tertiary-container: '#ff8abb'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e2dfff'
  primary-fixed-dim: '#c3c0ff'
  on-primary-fixed: '#0f0069'
  on-primary-fixed-variant: '#3b35a7'
  secondary-fixed: '#ffddb8'
  secondary-fixed-dim: '#ffb95f'
  on-secondary-fixed: '#2a1700'
  on-secondary-fixed-variant: '#653e00'
  tertiary-fixed: '#ffd9e4'
  tertiary-fixed-dim: '#ffb0cd'
  on-tertiary-fixed: '#3e0022'
  on-tertiary-fixed-variant: '#8c0053'
  background: '#f9f9ff'
  on-background: '#111c2d'
  surface-variant: '#d8e3fb'
typography:
  headline-xl:
    fontFamily: Epilogue
    fontSize: 40px
    fontWeight: '800'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Epilogue
    fontSize: 30px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Epilogue
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  body-lg:
    fontFamily: Be Vietnam Pro
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Be Vietnam Pro
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-bold:
    fontFamily: Be Vietnam Pro
    fontSize: 14px
    fontWeight: '700'
    lineHeight: 20px
  label-sm:
    fontFamily: Be Vietnam Pro
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
  unit: 4px
  margin-mobile: 20px
  gutter: 16px
  container-padding: 24px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 32px
---

## Brand & Style

The design system is engineered to evoke a sense of achievement, momentum, and joy. It targets a mobile-first audience that values tactile feedback and visual "dopamine hits" upon completing tasks or receiving rewards. 

The aesthetic is a sophisticated blend of **Modern Minimalism** and **Glassmorphism**. It utilizes heavy whitespace to allow bold typography and indigo accents to command attention, while floating cards and translucent layers provide a sense of physical depth. The emotional response is intended to be celebratory—transforming routine interactions into rewarding experiences through high-energy visual cues and a premium, polished finish.

## Colors

The color palette is anchored by a deep, authoritative **Indigo** used for primary actions, headings, and key structural elements. To support the "celebratory" nature of the design system, a high-energy secondary palette of **Amber** and **Vibrant Pink** is used for success states, badges, and notification "pings."

- **Primary (Indigo):** Used for the heaviest brand weight and primary button states.
- **Secondary (Amber):** Reserved for rewards, streaks, and "level up" moments.
- **Tertiary (Pink):** Used for secondary highlights and high-energy notifications.
- **Neutral (Slate):** Provides a grounded contrast for body text and subtle borders.
- **Background:** A very light cool-grey (#F8FAFC) is used to make floating white cards pop.

## Typography

This design system uses a dual-font strategy to balance character with readability. **Epilogue** is the choice for headlines, providing a geometric, editorial weight that feels modern and assertive. Its heavy weights (700-800) are essential for "celebratory" messaging.

**Be Vietnam Pro** is used for body copy and interface labels. It offers a friendly, contemporary rhythm that remains highly legible at smaller sizes on mobile screens. We use tight letter spacing on headlines to increase visual impact and standard spacing for body copy to ensure comfort during longer reading sessions.

## Layout & Spacing

The layout utilizes a **fluid grid** optimized for mobile viewports, relying on a 4px baseline shift. A standard 20px outer margin ensures content does not feel cramped against the bezel. 

Information is organized into distinct vertical stacks. Large "stack-lg" spacing is used to separate major sections (like a reward header from a task list), while "stack-sm" is used to group related text elements. Padding within interactive cards should be generous (24px) to emphasize the "floating" and premium nature of the container.

## Elevation & Depth

Depth is the primary driver of hierarchy in this design system. We use **Ambient Shadows** that are extremely diffused and slightly tinted with the Primary Indigo color to avoid a "muddy" look.

- **Level 1 (Surface):** The main background. Flat and neutral.
- **Level 2 (Floating Cards):** A white surface with a 15% opacity Indigo shadow, 20px blur, and 4px vertical offset. These should appear to hover 4dp above the surface.
- **Level 3 (Interactive Elements/Modals):** Elements like "Claim Reward" buttons or popup modals use a more aggressive shadow (25% opacity) to signify they are the topmost layer.
- **Glassmorphism:** Bottom navigation bars and top headers should use a 12px backdrop blur with a 70% white tint to maintain context of the content scrolling beneath them.

## Shapes

The shape language is consistently **Rounded**, avoiding sharp corners to maintain a friendly and safe atmosphere. 

- **Cards & Containers:** Use a 1rem (16px) corner radius to create a soft, modern container.
- **Buttons:** Utilize a 1.5rem (24px) "extra-large" radius to create a pill-like appearance that invites tapping.
- **Selection States:** Small indicators like checkboxes or radio buttons use a 0.5rem (8px) radius to maintain the rounded theme without becoming fully circular.

## Components

### Buttons
Primary buttons are Indigo with white bold text, using a subtle vertical gradient (Indigo-600 to Indigo-700) to suggest tactility. Success buttons for "Claiming" rewards should use the Amber palette with a slight "glow" shadow effect.

### Floating Cards
The signature component. Cards must have a white background, generous internal padding, and the Level 2 shadow. They should never touch the edge of the screen; they always float within the 20px margin.

### Interactive Elements
- **Chips:** Small, pill-shaped labels used for categories. Use low-opacity Indigo backgrounds with dark Indigo text.
- **Progress Bars:** Thick (8px) tracks with rounded ends. The progress fill should use a gradient from Indigo to Pink to signify movement and energy.
- **Notifications:** High-energy banners that slide from the top, utilizing the Tertiary Pink for immediate visual urgency.

### Feedback Loops
When an action is successful, the component should briefly scale up (1.05x) and display a haptic-centered animation, reinforcing the rewarding nature of the design system.