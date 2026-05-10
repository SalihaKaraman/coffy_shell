---
name: Artisanal Cafe System
colors:
  surface: '#fff8f5'
  surface-dim: '#dfd9d6'
  surface-bright: '#fff8f5'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f9f2ef'
  surface-container: '#f3ecea'
  surface-container-high: '#eee7e4'
  surface-container-highest: '#e8e1de'
  on-surface: '#1e1b1a'
  on-surface-variant: '#4e453e'
  inverse-surface: '#33302e'
  inverse-on-surface: '#f6efec'
  outline: '#80756d'
  outline-variant: '#d2c4bb'
  surface-tint: '#705a49'
  primary: '#322214'
  on-primary: '#ffffff'
  primary-container: '#4a3728'
  on-primary-container: '#bba08c'
  inverse-primary: '#dec1ac'
  secondary: '#954824'
  on-secondary: '#ffffff'
  secondary-container: '#fd9a6f'
  on-secondary-container: '#75300d'
  tertiary: '#172a0e'
  on-tertiary: '#ffffff'
  tertiary-container: '#2d4022'
  on-tertiary-container: '#95ac85'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#fbddc7'
  primary-fixed-dim: '#dec1ac'
  on-primary-fixed: '#28180b'
  on-primary-fixed-variant: '#574333'
  secondary-fixed: '#ffdbcd'
  secondary-fixed-dim: '#ffb596'
  on-secondary-fixed: '#360f00'
  on-secondary-fixed-variant: '#77320e'
  tertiary-fixed: '#d2eac0'
  tertiary-fixed-dim: '#b6cea5'
  on-tertiary-fixed: '#0e2006'
  on-tertiary-fixed-variant: '#384c2d'
  background: '#fff8f5'
  on-background: '#1e1b1a'
  surface-variant: '#e8e1de'
typography:
  headline-xl:
    fontFamily: Playfair Display
    fontSize: 36px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Playfair Display
    fontSize: 28px
    fontWeight: '600'
    lineHeight: '1.3'
  headline-md:
    fontFamily: Playfair Display
    fontSize: 22px
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
    lineHeight: '1.6'
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.5'
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: 0.05em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: '1.2'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  container-margin: 20px
  gutter: 16px
---

## Brand & Style

The design system is centered on the concept of "Digital Hygge"—creating a digital space that feels as warm and welcoming as a physical neighborhood cafe. The target audience appreciates craft, slow mornings, and high-quality ingredients. 

The aesthetic blends **Modern Minimalism** with **Tactile Warmth**. It avoids the sterile coldness of typical tech apps by using organic color shifts and soft shadows that mimic natural light. High-quality imagery of steaming lattes, textured ceramics, and sun-drenched interiors is central to the experience, serving as the primary visual driver. The interface remains quiet and unobtrusive, allowing the "artisanal" quality of the products to shine.

## Colors

The palette is derived from the natural world of a roastery and garden.
- **Cream (#FDFCF0):** Acts as the canvas. It provides a softer, more "paper-like" warmth than pure white, reducing eye strain and feeling more organic.
- **Earthy Brown (#4A3728):** Used for primary typography and grounding elements. It provides deep contrast while maintaining a warm undertone.
- **Terracotta (#D67B52):** The accent color for action items, call-to-outs, and highlights. It evokes baked goods and clay pottery.
- **Sage Green (#8DA47E):** Used for "fresh" indicators, organic options, or subtle success states, reinforcing the natural, farm-to-table connection.

## Typography

This design system utilizes a sophisticated typographic pairing to balance editorial elegance with functional clarity. 
- **Playfair Display** is reserved for headings and display moments. It brings a "menu" feel to the app, evoking the editorial quality of a food magazine.
- **Inter** provides high legibility for menus, descriptions, and functional labels. 
- Large line heights are used across all body text to ensure a relaxed, breathable reading experience. Headlines should use "smart quotes" and proper ligatures to maintain the premium artisanal feel.

## Layout & Spacing

The layout follows a **Fluid Grid** model optimized for mobile-first interaction. 
- **Margins:** A generous 20px side margin ensures content doesn't feel cramped.
- **Rhythm:** An 8px base grid drives vertical rhythm.
- **Negative Space:** Intentionally use large `xl` spacing blocks between distinct sections (e.g., between "Recommended" and "Full Menu") to allow the user to "breathe" while scrolling.
- **Imagery:** Product images should often break the grid or bleed to one edge to create a dynamic, modern feel that mimics a physical scrapbook or high-end menu.

## Elevation & Depth

Depth in this design system is achieved through **Ambient Shadows** and **Tonal Layers**.
- **Shadows:** Avoid harsh, black shadows. Use a deep Brown (#4A3728) tint with very low opacity (5-8%) and high blur radii (15px+) to create the effect of objects sitting on a soft, sunlit surface.
- **Tiers:** 
  - **Level 0:** Cream background.
  - **Level 1:** White cards with soft shadows for product listings.
  - **Level 2:** Floating action buttons or modal sheets with slightly tighter, more defined shadows.
- **Glassmorphism:** Use subtle backdrop blurs (10px) on navigation bars and bottom sheets to maintain a sense of space while overlaying content.

## Shapes

The shape language is consistently **Rounded**, leaning towards a friendly and approachable feel.
- **Cards and Imagery:** Use a 1rem (16px) radius to soften the visual impact of photography.
- **Buttons:** Use a large 1.5rem (24px) radius or full pill-shape to make them feel "touchable" and friendly.
- **Small Elements:** Chips and tags should be fully pill-shaped (rounded-xl) to contrast against the more structured product cards.
- **Containers:** Bottom sheets should only have rounded corners on the top-left and top-right (2rem) to create a "cradle" effect for content.

## Components

- **Buttons:** 
  - *Primary:* Filled Terracotta with white text. Large rounded corners.
  - *Secondary:* Outlined Earthy Brown with a subtle 1px stroke.
- **Cards:** White surfaces with a 16px radius and ambient brown-tinted shadows. Images should be top-aligned with no padding to the top/left/right.
- **Chips/Filters:** Sage Green background with Earthy Brown text for "Active" states. Cream background with a thin Brown border for "Inactive" states.
- **Input Fields:** Minimalist style. No background fill; just a subtle bottom border in Earthy Brown. Floating labels using Inter (Label-sm).
- **Steppers:** Rounded buttons for +/- quantity selection, using a light Cream background to feel integrated into the interface.
- **Imagery Component:** A specialized component that adds a very subtle inner "glow" or overlay to food photos to ensure white text (if any) is legible.
- **Specialty Component - "The Aroma Loader":** A custom loading animation featuring a stylized steaming cup icon using the Terracotta accent.