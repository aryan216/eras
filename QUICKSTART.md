# QuickStart Guide

Get StayHaven running in 5 minutes!

## Step 1: Install Dependencies (1 min)

```bash
npm install
```

## Step 2: Set Up Supabase (2 min)

1. Go to [supabase.com](https://supabase.com) and create a free account
2. Create a new project
3. Copy your project URL and anon key from Settings > API
4. Create `.env.local` file:

```env
NEXT_PUBLIC_SUPABASE_URL=your-url-here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-key-here
```

**Database is already set up!** Tables and sample data were created via migration.

## Step 3: Run the App (1 min)

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

## Step 4: Explore! (1 min)

### Try These Features:
1. **Browse Properties**: View 12 pre-loaded properties
2. **Search**: Use the search bar to filter by location
3. **Filter**: Apply price, type, and amenity filters
4. **Sign Up**: Create a test account
5. **Add Favorites**: Click hearts on property cards
6. **Book**: Select dates and book a property

## What You Get

### 7 Complete Pages
- ✅ Landing page with hero and sections
- ✅ Properties listing with filters
- ✅ Property details with booking
- ✅ Login/Signup pages
- ✅ User profile with tabs
- ✅ Favorites collection
- ✅ Booking confirmation

### Key Features
- 🎨 Beautiful sea-blue design
- 📱 Fully responsive
- ✨ Smooth animations
- 🔐 Authentication ready
- 💾 Database integrated
- ❤️ Favorites system
- 📅 Booking flow

### Tech Stack
- Next.js 13 + TypeScript
- Tailwind CSS
- Framer Motion
- Supabase
- Zustand
- shadcn/ui

## Common Issues

**Build fails?**
```bash
rm -rf .next node_modules
npm install
```

**Supabase not connecting?**
- Check `.env.local` exists
- Verify URL and key are correct
- Restart dev server

**Images not loading?**
- Images use Pexels CDN
- Check your internet connection

## Next Steps

1. **Customize Colors**: Edit `tailwind.config.ts`
2. **Add Your Images**: Update property images in database
3. **Configure Auth**: Set up email templates in Supabase
4. **Deploy**: Push to Vercel with one click

## Need Help?

- 📖 Read `README.md` for full documentation
- 🔧 Check `SETUP.md` for detailed setup
- 📦 See `COMPONENTS.md` for component docs

---

**Enjoy building with StayHaven!** 🏖️
