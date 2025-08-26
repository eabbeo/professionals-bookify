## ** DESIGN.md **

```markdown

## Part 1: UI/UX & Architecture Brief

### Assumptions
- Target devices: Modern smartphones (4.7" - 6.7" screens)
- Minimum SDK: Flutter 3.35.1
- Theme: Light mode only
- Data: Local JSON file simulation

### Architecture & State Management: Riverpod
**Why Riverpod?**
- Excellent testability with provider overriding
- Compile-time safety (no runtime exceptions)
- Flexible dependency injection
- Modern replacement for Provider package

### Navigation Structure
- `/` - Profesioanls Screen (professional list with filters)
- `/professional/:index` - ProfessionalDetailsScreen
- `/bookings` - BookingScreen (modal bottom sheet)

### Offline & Error UX
- Shimmer loading states
- Error screens with retry buttons
- Empty state illustrations with text


### Performance & Testing
- `ListView.sepated` for efficient scrolling
- `const` constructors where possible
- Memoized filtered lists with Riverpod providers
- Priority: Unit tests for filter logic, widget tests for UI flows

---

## Part 3: Short Questions

### 1. State choice: Why Riverpod? Feature boundaries?
**Why Riverpod**: Testability, compile-time safety, and modern architecture patterns.

**Feature Boundaries**: Providers organized by feature:
- `professionalsProvider` - Data repository
- `timeSlotListProvider` - - Data repository
- `filterStateProvider` - Filter management
- `professionalsListProvider` - Async data handling
- `filteredProfessionalsProvider` - Computed state

### 2. Performance: Two quick optimizations for growing lists
1. **`ListView.builder`** with `itemExtent` for predictable scrolling performance
2. **`const` widgets** and memoized selectors to prevent unnecessary rebuilds

### 3. Offline/Latency: Optimistic updates without over-engineering
- **Simple approach**: `shared_preferences` for caching professional data
- **Optimistic UI**: Immediately show booking confirmation, then sync with backend
- **Error handling**: Queue failed requests for retry when online

### 4. Error UX: User communication vs silent logging
**Must communicate**:
- Booking error (time slot not selected)

### 5. Scalability: Adding authentication & real APIs
**Changes needed**:
- **DTOs/Mappers**: Separate API models from domain models
- **Error types**: Specific error classes for different failure modes
- **Layers**: Add API client layer with interceptors for auth
- **State management**: Auth provider for user session state

### 6. Offline/Latency: Optimistic updates without over-engineering
- **Simple approach**: `shared_preferences` for caching professional data

### 7. Todos 
- Write widgets test