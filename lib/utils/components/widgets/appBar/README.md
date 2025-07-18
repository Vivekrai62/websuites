# Responsive App Bar Components

This directory contains responsive app bar components that automatically adapt to different device sizes and screen dimensions.

## Components

### 1. CustomAppBar
A base responsive app bar component that calculates height based on screen size and device type.

**Features:**
- Responsive height calculation based on screen dimensions
- Device-specific styling (phone, tablet, desktop)
- Automatic shadow and decoration handling

**Usage:**
```dart
CustomAppBar(
  child: YourAppBarContent(),
)
```

### 2. ResponsiveCustomerAppBar
A specialized responsive app bar for customer-related screens with built-in responsive sizing for all elements.

**Features:**
- Responsive font sizes for title, filter text, and add button text
- Responsive icon sizes for menu, filter, and add icons
- Responsive button dimensions and spacing
- Responsive padding based on screen height
- Device-specific layout (menu button only on phones)

**Usage:**
```dart
ResponsiveCustomerAppBar(
  scaffoldKey: scaffoldKey,
  onAddPressed: () {
    // Handle add button press
  },
  onFilterPressed: () {
    // Handle filter button press
  },
)
```

## Responsive Breakpoints

The components use the following breakpoints to determine device type:

- **Phone**: `width < 600px`
- **Tablet**: `600px ≤ width < 1200px`
- **Desktop**: `width ≥ 1200px`

## Responsive Calculations

### App Bar Height
- **Phone**: 12-15% of screen height (min: 90px, max: 120px)
- **Tablet**: 10-12% of screen height (min: 100px, max: 140px)
- **Desktop**: 8-10% of screen height (min: 110px, max: 160px)

### Font Sizes
- **Title**: Phone (18px), Tablet (22px), Desktop (26px)
- **Filter Text**: Phone (12px), Tablet (14px), Desktop (16px)
- **Add Button Text**: Phone (12px), Tablet (14px), Desktop (16px)

### Icon Sizes
- **Menu Icon**: Phone (24px), Tablet (28px), Desktop (32px)
- **Filter Icon**: Phone (12px), Tablet (14px), Desktop (16px)
- **Add Icon**: Phone (18px), Tablet (20px), Desktop (22px)

### Button Dimensions
- **Add Button Width**: Phone (70px), Tablet (85px), Desktop (100px)
- **Add Button Height**: Phone (32px), Tablet (36px), Desktop (40px)

### Spacing
- **Horizontal Spacing**: Phone (10px), Tablet (15px), Desktop (20px)
- **Filter Spacing**: Phone (5px), Tablet (6px), Desktop (8px)
- **Add Button Spacing**: Phone (5px), Tablet (6px), Desktop (8px)

## Implementation in CustomerListScreen

The `CustomerListScreen` has been updated to use the new `ResponsiveCustomerAppBar`:

```dart
// Before (fixed sizing)
CustomAppBar(
  child: Padding(
    padding: isTablet
        ? const EdgeInsets.only(top: 35, right: 15, left: 5)
        : const EdgeInsets.only(top: 56, right: 15, left: 5),
    child: Row(
      // ... complex row with fixed sizes
    ),
  ),
)

// After (responsive sizing)
ResponsiveCustomerAppBar(
  scaffoldKey: widget.scaffoldKey,
  onAddPressed: () {
    // Handle add button press
  },
  onFilterPressed: () => openCustomerFilterBottomSheet(context),
)
```

## Benefits

1. **Automatic Adaptation**: Components automatically adjust to different screen sizes
2. **Consistent UX**: Maintains visual hierarchy across devices
3. **Reduced Code**: Eliminates manual responsive calculations
4. **Maintainable**: Centralized responsive logic
5. **Scalable**: Easy to extend for other app bar types

## Example

See `responsive_appbar_example.dart` for a complete example of how to use the responsive app bar components.

## Future Enhancements

- Add support for landscape/portrait orientation changes
- Implement theme-aware responsive sizing
- Add animation support for size transitions
- Create more specialized app bar variants for different use cases 