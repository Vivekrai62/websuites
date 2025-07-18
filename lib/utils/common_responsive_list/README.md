# Responsive Grid Components

This package provides responsive grid components for Flutter applications that automatically adapt to different screen sizes.

## Components

### 1. CommonResponsiveGridView<T>

A generic responsive masonry grid view that automatically calculates the number of columns based on screen width.

#### Features:
- Automatic responsive column calculation
- Loading states
- Empty states
- Pull-to-refresh functionality
- Tap and long press callbacks
- Customizable spacing and padding

#### Usage:
```dart
CommonResponsiveGridView<String>(
  items: ['Item 1', 'Item 2', 'Item 3'],
  minItemWidth: 250.0,
  mainAxisSpacing: 12.0,
  crossAxisSpacing: 12.0,
  maxCrossAxisCount: 3,
  itemBuilder: (context, item, index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(item),
      ),
    );
  },
  onRefresh: () async {
    // Refresh logic
  },
  isLoading: false,
)
```

### 2. CardMasonryGrid<T>

A simplified version of CommonResponsiveGridView that automatically wraps items in cards.

#### Features:
- Automatic card wrapping
- Responsive layout
- Simplified API

#### Usage:
```dart
CardMasonryGrid<String>(
  items: ['Item 1', 'Item 2', 'Item 3'],
  minCardWidth: 200.0,
  spacing: 12.0,
  maxCrossAxisCount: 3,
  cardBuilder: (item, index) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(item),
    );
  },
)
```

### 3. ProfileStatsCard

A pre-built card component for displaying statistics with icons and values.

#### Usage:
```dart
ProfileStatsCard(
  title: 'Followers',
  value: '2.4K',
  icon: Icons.people,
  color: Colors.green,
  onTap: () {
    // Handle tap
  },
)
```

### 4. ProfileMenuItem

A pre-built menu item component with icons, titles, and optional badges.

#### Usage:
```dart
ProfileMenuItem(
  title: 'Settings',
  icon: Icons.settings,
  onTap: () {
    // Navigate to settings
  },
  showBadge: true,
  badgeText: 'New',
)
```

### 5. ResponsiveBreakpoints

Utility class for responsive breakpoints and cross-axis count calculation.

#### Usage:
```dart
final crossAxisCount = ResponsiveBreakpoints.getCrossAxisCount(
  context,
  mobile: 1,
  tablet: 2,
  desktop: 3,
  largeDesktop: 4,
);
```

## Parameters

### CommonResponsiveGridView
- `items`: List of items to display
- `itemBuilder`: Function to build each item widget
- `crossAxisCount`: Optional fixed number of columns
- `minItemWidth`: Minimum width for automatic column calculation
- `mainAxisSpacing`: Vertical spacing between items
- `crossAxisSpacing`: Horizontal spacing between items
- `padding`: Padding around the grid
- `maxCrossAxisCount`: Maximum number of columns allowed
- `isLoading`: Whether to show loading state
- `onRefresh`: Pull-to-refresh callback
- `onItemTap`: Item tap callback
- `onItemLongPress`: Item long press callback

### CardMasonryGrid
- `items`: List of items to display
- `cardBuilder`: Function to build each card content
- `minCardWidth`: Minimum card width for responsive calculation
- `spacing`: Spacing between cards
- `useCard`: Whether to wrap items in cards
- `maxCrossAxisCount`: Maximum number of columns

## Responsive Behavior

The components automatically adjust the number of columns based on:
- Screen width
- Minimum item width
- Maximum cross-axis count
- Padding and spacing

### Breakpoints:
- Mobile: ≤ 500px
- Tablet: 501px - 900px
- Desktop: 901px - 1000px
- Large Desktop: > 1000px

## Example Integration

See `example_usage.dart` for comprehensive examples of how to use these components in different scenarios.

## Dependencies

Make sure you have `flutter_staggered_grid_view` in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_staggered_grid_view: ^0.7.0
``` 