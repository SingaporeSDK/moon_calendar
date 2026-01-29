# Moon Calendar - Screenshot & Marketing Guide

## 📸 Screenshot Requirements for Google Play Store

### Dimensions & Format
- **Resolution**: 1440 x 2560 px (recommended)
- **Format**: PNG or JPEG
- **Required**: Minimum 2 screenshots, Maximum 8 screenshots
- **Language**: Can be in English (or localized)

---

## 🎯 Recommended Screenshots (5-6 Total)

### Screenshot 1: Home Screen - "Beautiful Moon Visualization"
**What to show:**
- Large moon emoji/circle in center
- Current moon phase name below
- Illumination percentage and progress bar
- Days until next Full/New Moon (below moon)
- Track Your Mood button visible
- App title "Moon Calendar" in header with location

**Focus**: Visual beauty and main features at a glance

---

### Screenshot 2: Mood Tracking - "Track Your Emotions"
**What to show:**
- "How Are You Feeling Today?" section
- Mood selection options (Excited, Calm, Sad, Angry, Anxious, Neutral)
- Selected mood highlighted
- Description about mood tracking benefits
- Navigation showing this is step 1 of X

**Focus**: Unique feature - mood tracking with moon correlation

---

### Screenshot 3: Energy & Productivity - "Monitor Your Energy"
**What to show:**
- Energy level selection (Energetic, Normal, Tired, Lethargic)
- Work productivity status (Focused, Procrastinating, etc.)
- Track button at bottom
- Show the correlation message about moon cycles

**Focus**: Comprehensive tracking capabilities

---

### Screenshot 4: Calendar View - "Explore Lunar Phases"
**What to show:**
- Full calendar view for a month
- Moon phases visible for each day (different emoji for each phase)
- Highlighted current date
- Navigation buttons to switch months
- Festival information if applicable

**Focus**: Easy navigation and comprehensive calendar

---

### Screenshot 5: Details Screen - "Deep Moon Insights"
**What to show:**
- Current moon phase name and emoji
- Illumination percentage (0-100%)
- Days until Full Moon
- Lunar cycle progress
- Day since New Moon
- Julian Day Number
- Festival information (if any)

**Focus**: Detailed astronomical information for enthusiasts

---

### Screenshot 6: Multi-Language - "Available in Your Language"
**What to show:**
- Language switcher open
- Multiple language options visible:
  - English
  - 日本語 (Japanese)
  - 한국어 (Korean)
  - 中文 (Chinese)
  - हिंदी (Hindi)
  - And others
- Current language highlighted

**Focus**: Accessibility and global appeal

---

## 🎨 Design Tips for Screenshots

1. **Consistency**: Use same background and theme throughout
2. **Readability**: All text should be clearly visible
3. **Feature Highlights**: Circle or point to important elements
4. **Color Coding**: Yellow moon, cyan illumination matches the app
5. **Typography**: Use clean, readable fonts
6. **White Space**: Don't overcrowd - give features breathing room
7. **Contrast**: Ensure text stands out against background
8. **Device Bezel**: Consider including device frame for professional look

---

## 📝 Screenshot Text Overlays (Optional but Recommended)

### Screenshot 1
**Text**: "Beautiful Moon Visualization"
**Subtext**: "See accurate moon phases with real-time calculations"

### Screenshot 2
**Text**: "Track Your Mood Daily"
**Subtext**: "Discover how lunar cycles affect your emotions"

### Screenshot 3
**Text**: "Monitor Energy Levels"
**Subtext**: "Understand your productivity patterns with the moon"

### Screenshot 4
**Text**: "Explore Lunar Calendar"
**Subtext**: "Navigate through moon phases for any date"

### Screenshot 5
**Text**: "Detailed Moon Data"
**Subtext**: "Comprehensive astronomical information included"

### Screenshot 6
**Text**: "Available in 6 Languages"
**Subtext**: "English, 日本語, 한국어, 中文, हिंदी and more"

---

## 🎬 How to Take Screenshots on Android

### Using ADB (Android Debug Bridge):
```bash
# Connect device/emulator
adb devices

# Take screenshot
adb shell screencap -p /sdcard/screenshot.png

# Pull to computer
adb pull /sdcard/screenshot.png ./screenshots/

# Delete from device
adb shell rm /sdcard/screenshot.png
```

### Using Device's Built-in Screenshot:
1. Open the app screen you want to capture
2. Press **Volume Down + Power Button** (simultaneously for 1 second)
3. Screenshot saved to Photos/Gallery

### Using Android Studio Emulator:
1. Run app on emulator: `flutter run --release`
2. Click the camera icon in the emulator controls
3. Screenshot saved automatically

---

## 📊 Optimizing Screenshots for Different Devices

**Google Play Store accepts:**
- Phones (most common): 9:16 aspect ratio (1440 x 2560)
- 7-inch tablets: 1600 x 2560
- 10-inch tablets: 2560 x 1600

**Focus on phones** as they're the primary viewing device.

---

## ✍️ Sample Feature Graphics (1024 x 500 px)

**Recommended content:**
- Center: Moon emoji or phase visualization
- Left/Right: Features listed
- Background: Dark space/night theme matching app
- Text: Bold, easy to read at thumbnail size

**Example Layout:**
```
┌─────────────────────────────────────┐
│  Moon Calendar                      │
│                                     │
│  🌙  Track Lunar Phases            │
│  😊  Monitor Your Mood             │
│  📊  Understand Patterns           │
│  🌍  6 Languages                   │
│                                     │
│  Available on Google Play          │
└─────────────────────────────────────┘
```

---

## 🎯 App Icon Verification

**Current Icon Location**: `android/app/src/main/res/mipmap-*/ic_launcher.png`

**Sizes created:**
- hdpi: 72 x 72 px
- mdpi: 48 x 48 px
- xhdpi: 96 x 96 px
- xxhdpi: 144 x 144 px
- xxxhdpi: 192 x 192 px

**Checklist:**
- ✅ Icon is visible and recognizable
- ✅ Works on light and dark backgrounds
- ✅ Matches app branding (moon theme)
- ✅ Safe margins around logo
- ✅ No transparency issues

---

## 📋 Complete Submission Checklist

### Before Taking Screenshots:
- [ ] App tested on multiple Android versions (6.0+)
- [ ] All features working correctly
- [ ] Location permissions tested
- [ ] Mood tracking functional
- [ ] Calendar navigation smooth
- [ ] Language switching works
- [ ] No crashes or bugs

### Screenshots Preparation:
- [ ] High-quality screenshots taken
- [ ] Screenshots cropped to exact dimensions
- [ ] Text is clearly visible and readable
- [ ] Consistent styling across all screenshots
- [ ] Screenshots in correct order (feature flow)
- [ ] Saved as PNG or JPEG format
- [ ] Filenames descriptive (screenshot_1.png, etc.)

### Asset Preparation:
- [ ] App Icon: 512 x 512 px PNG
- [ ] Feature Graphic: 1024 x 500 px PNG
- [ ] Screenshots: 1440 x 2560 px (minimum 2, maximum 8)
- [ ] Store Listing completed with descriptions
- [ ] Privacy Policy URL prepared
- [ ] Support Email configured

---

## 🚀 Upload Process

1. **Prepare Release Build**
   ```bash
   flutter build appbundle --release
   ```

2. **Access Google Play Console**
   - Visit: https://play.google.com/console
   - Sign in with dr.lalit@gmail.com

3. **Create New App**
   - App name: Moon Calendar
   - Default language: English
   - Category: Lifestyle

4. **Add Screenshots**
   - Go to: Store Listing → Screenshots
   - Upload 5-6 optimized screenshots
   - Add feature descriptions below each

5. **Add Icon & Graphics**
   - Store Listing → Graphic Assets
   - Upload 512x512 icon
   - Upload 1024x500 feature graphic

6. **Complete Store Listing**
   - Add short description (80 chars)
   - Add full description (4000 chars)
   - Add privacy policy link
   - Add contact email

7. **Content Rating**
   - Complete IARC questionnaire
   - Usually takes 5-10 minutes

8. **Pricing & Distribution**
   - Set as Free
   - Select countries/regions
   - Accept agreements

9. **Upload Build**
   - Go to: Internal Testing
   - Upload APK or AAB file
   - Add release notes

10. **Final Review**
    - Review all details one more time
    - Submit for review
    - Wait 24-48 hours for approval

---

## 📈 Post-Launch Strategy

**After Launch:**
1. Monitor user reviews and ratings
2. Respond to user feedback promptly
3. Fix reported bugs quickly
4. Plan feature updates:
   - Additional calendar features
   - Notification reminders for moon phases
   - Sharing mood tracking data
   - Dark mode improvements

5. Promote on:
   - Social media (Twitter, Instagram, Reddit)
   - Moon/astronomy forums
   - Wellness app communities
   - Product Hunt (if eligible)

---

## 🎁 Promotional Ideas

**Social Media Posts:**
- Before/After mood tracking results
- Moon phase memes and facts
- "Did you know?" moon science facts
- User testimonials
- Feature previews

**Content Ideas:**
- Blog: "How Lunar Cycles Affect Your Mood"
- Video: "Track Your Mood with Moon Calendar"
- Infographic: "Moon Phases Explained"
- Guide: "Understanding Lunar Energy"

---

**Prepared By**: AI Assistant
**Date**: January 29, 2026
**App Version**: 1.0.0
**Status**: Ready for Google Play Store
