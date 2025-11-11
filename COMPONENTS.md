# Component Documentation

## Core Components

### Navbar (`components/navbar.tsx`)
The main navigation component displayed across all pages.

**Features:**
- Responsive mobile menu with smooth animations
- Active link highlighting with motion indicators
- User authentication state display
- Sticky positioning with backdrop blur

**Usage:**
```tsx
import { Navbar } from '@/components/navbar';

<Navbar />
```

### Footer (`components/footer.tsx`)
Site footer with links and information.

**Features:**
- Company information and links
- Social media icons
- Multi-column layout
- Responsive design

**Usage:**
```tsx
import { Footer } from '@/components/footer';

<Footer />
```

### PropertyCard (`components/property-card.tsx`)
Reusable card component for displaying property listings.

**Props:**
- `property`: Property object containing all property data

**Features:**
- Image carousel with indicators
- Favorite toggle button
- Rating display
- Price and details
- Hover animations
- Featured badge

**Usage:**
```tsx
import { PropertyCard } from '@/components/property-card';

<PropertyCard property={propertyData} />
```

### SearchBar (`components/search-bar.tsx`)
Search component with two variants.

**Props:**
- `variant`: 'hero' | 'compact' (default: 'compact')

**Features:**
- Location input with icon
- Date range picker
- Guest selector
- Responsive layout
- Hero variant for landing page

**Usage:**
```tsx
import { SearchBar } from '@/components/search-bar';

// Compact version
<SearchBar variant="compact" />

// Hero version
<SearchBar variant="hero" />
```

## Page Components

### Landing Page (`app/page.tsx`)
Main landing page with multiple sections.

**Sections:**
1. Hero with search
2. Featured properties
3. Popular destinations
4. Trust indicators
5. Testimonials
6. Call-to-action

**Features:**
- Scroll animations
- Data fetching from Supabase
- Loading states
- Responsive grid layouts

### Properties Listing (`app/properties/page.tsx`)
Property listing page with filtering.

**Features:**
- Advanced sidebar filters
- Mobile filter drawer
- Sort options
- Real-time filtering
- Empty states
- Loading skeletons

**Filter Options:**
- Price range slider
- Property type checkboxes
- Room count inputs
- Guest count
- Minimum rating
- Amenities selection

### Property Details (`app/properties/[id]/page.tsx`)
Individual property page with booking.

**Features:**
- Image carousel
- Property information
- Amenities grid
- Booking widget
- Similar properties
- Location display

**Booking Widget:**
- Date selection
- Guest count
- Price calculation
- Total display
- Book button

### Authentication Pages
**Login** (`app/login/page.tsx`)
**Signup** (`app/signup/page.tsx`)

**Features:**
- Form validation
- Error handling
- Password visibility toggle
- Social login UI
- Responsive design
- Loading states

### Profile Page (`app/profile/page.tsx`)
User profile management with tabs.

**Tabs:**
1. **Profile**: Edit user information
2. **Bookings**: View booking history
3. **Settings**: Account settings

**Features:**
- Avatar upload UI
- Form handling
- Booking list
- Settings toggles

### Favorites Page (`app/favorites/page.tsx`)
User's saved properties.

**Features:**
- Grid of favorite properties
- Empty state with CTA
- localStorage integration
- Remove functionality

### Booking Confirmation (`app/booking/confirm/page.tsx`)
Post-booking confirmation page.

**Features:**
- Confirmation details
- Booking summary
- Download/email buttons
- Next steps information
- Support contact

## Utility Components

### Loading Skeletons (`components/loading-skeleton.tsx`)
Skeleton screens for loading states.

**Components:**
- `PropertyCardSkeleton`
- `PropertyDetailsSkeleton`

**Usage:**
```tsx
import { PropertyCardSkeleton } from '@/components/loading-skeleton';

{loading ? <PropertyCardSkeleton /> : <PropertyCard {...props} />}
```

## UI Components (shadcn/ui)

Located in `components/ui/`, these are pre-built, accessible components:

- **Button**: Primary interaction element
- **Input**: Text input fields
- **Card**: Container component
- **Badge**: Status indicators
- **Separator**: Visual dividers
- **Tabs**: Tabbed interface
- **Avatar**: User profile pictures
- **Checkbox**: Selection inputs
- **Slider**: Range selection
- **Select**: Dropdown selection
- **Dialog**: Modal dialogs
- **Tooltip**: Hover information
- And many more...

## State Management

### Zustand Stores (`lib/store.ts`)

**useSearchStore**
- Manages search parameters
- Location, dates, guests

**useFavoritesStore**
- Manages favorite properties
- localStorage persistence
- Add/remove/check functions

**useUserStore**
- Manages user authentication state
- User object storage

**Usage:**
```tsx
import { useSearchStore } from '@/lib/store';

const { location, setLocation } = useSearchStore();
```

## Styling Patterns

### Responsive Design
```tsx
// Mobile-first approach
<div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
```

### Color System
```tsx
// Primary colors
className="bg-sky-600 text-white"
className="text-sky-600"

// Semantic colors
className="bg-red-50 text-red-600"  // Error
className="bg-green-100 text-green-800"  // Success
```

### Spacing System
```tsx
// 8px base unit
className="p-4 gap-6 mb-8"
// Translates to: 16px, 24px, 32px
```

### Animations
```tsx
import { motion } from 'framer-motion';

<motion.div
  initial={{ opacity: 0, y: 20 }}
  animate={{ opacity: 1, y: 0 }}
  whileHover={{ y: -4 }}
>
```

## Best Practices

### Component Structure
1. Import statements
2. Type definitions
3. Component function
4. Sub-components (if any)
5. Export

### Props Typing
Always use TypeScript interfaces:
```tsx
interface ComponentProps {
  property: Property;
  onAction?: () => void;
}
```

### Error Handling
```tsx
const [error, setError] = useState('');

try {
  // Operation
} catch (err: any) {
  setError(err.message);
}
```

### Loading States
Always provide loading states:
```tsx
{loading ? <Skeleton /> : <Content />}
```

### Empty States
Provide helpful empty states:
```tsx
{items.length === 0 && (
  <div className="text-center">
    <Icon />
    <h3>No items</h3>
    <Button>Add Item</Button>
  </div>
)}
```

## Performance Tips

1. **Image Optimization**: Use Next.js Image component
2. **Lazy Loading**: Implement for below-fold content
3. **Memoization**: Use React.memo for expensive components
4. **Code Splitting**: Leverage Next.js automatic splitting
5. **Debouncing**: For search and filter inputs

## Accessibility

All components follow accessibility best practices:
- Semantic HTML
- ARIA labels where needed
- Keyboard navigation
- Focus management
- Color contrast ratios

## Testing Recommendations

### Component Testing
Test key interactions:
- Form submissions
- Filter changes
- Favorite toggling
- Navigation

### Integration Testing
Test user flows:
- Search → Filter → View Property
- Signup → Login → Profile
- Browse → Favorite → View Favorites
- Select Property → Book → Confirm

---

For more details, refer to the component source code with inline documentation.
