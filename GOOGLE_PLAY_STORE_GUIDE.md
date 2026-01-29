# Moon Calendar - Google Play Store Release Preparation Guide

## ✅ Completed Steps

### 1. **App Build Configuration**
- **App Name**: Moon Calendar
- **Package ID**: com.mooncalendar.moon_calendar
- **Version**: 1.0.0 (Build 1)
- **Min SDK**: As configured by Flutter (currently ~21)
- **Target SDK**: As configured by Flutter (currently ~35)

### 2. **App Icons & Branding**
- ✅ App icons are configured for Android
- ✅ Located at: `android/app/src/main/res/mipmap-*/ic_launcher.png`

### 3. **Signing Configuration**
- ✅ Created signing configuration in `android/app/build.gradle.kts`
- ✅ Key properties file created: `android/key.properties`
- **Current Status**: Using debug signing for testing

### 4. **Build Artifacts Generated**
- ✅ **APK (Debug Signed)**: `build/app/outputs/flutter-apk/app-release.apk` (47.1 MB)
- **AAB (Android App Bundle)**: Generate with: `flutter build appbundle --release`

---

## 📋 Next Steps for Google Play Store Upload

### Step 1: Generate Keystore (If not done)
```bash
keytool -genkey -v -keystore android/app/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10957 -alias upload
```
When prompted, use these details:
- **Keystore Password**: moonCalendar2026
- **Key Password**: moonCalendar2026
- **Alias**: upload
- **Your Name**: Lalit
- **Organization**: Moon Calendar
- **City**: Singapore
- **State/Province**: Singapore
- **Country**: SG

### Step 2: Update key.properties (Already done)
File: `android/key.properties`
```properties
storePassword=moonCalendar2026
keyPassword=moonCalendar2026
keyAlias=upload
storeFile=app/upload-keystore.jks
```

### Step 3: Update build.gradle.kts for Release Signing
Change the buildTypes release block to:
```kotlin
buildTypes {
    release {
        signingConfig = signingConfigs.getByName("release")
    }
}
```

### Step 4: Build Signed Release APK
```bash
flutter build apk --release
```

### Step 5: Build Android App Bundle (Recommended for Play Store)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### Step 6: Create Google Play Console Account
1. Go to https://play.google.com/console
2. Sign in with your Google account (dr.lalit@gmail.com)
3. Create a new app
4. Fill in app details:
   - **App Name**: Moon Calendar
   - **Default Language**: English
   - **App or Game**: App
   - **Category**: Lifestyle
   - **Target Audience**: General audience

### Step 7: Prepare Store Listing
Create these assets:
- **Short Description** (80 characters max)
- **Full Description** (4000 characters max)
- **Screenshots** (2-8 required, 1440 x 2560 px recommended)
- **Feature Graphic** (1024 x 500 px)
- **Icon** (512 x 512 px)
- **Video** (optional)

**Sample Descriptions:**

**Short Description:**
"Track lunar phases and how the moon affects your mood and energy. Beautiful moon calendar with mood tracking."

**Full Description:**
"Moon Calendar is your personal lunar companion. Track moon phases and understand how lunar cycles influence your emotions, energy levels, and productivity.

✨ Features:
• Beautiful moon phase visualization
• Accurate lunar phase calculations
• Track your mood and energy daily
• See upcoming Full & New Moons
• Support for 6 languages
• Real-time location-based features
• Festival calendar integration
• Detailed moon phase information

📊 Track Your Connection:
Discover patterns between lunar cycles and your emotional well-being. Studies show the moon influences our moods - now you can measure yours!

🌍 Multi-Language Support:
Available in English, 日本語, 한국어, 中文, हिंदी, and more.

🔐 Privacy First:
Your mood data stays on your device. No tracking, no ads, no privacy concerns."

### Step 8: Content Rating
Complete the IARC questionnaire (usually takes 5-10 minutes)

### Step 9: Pricing & Distribution
- Set app as Free or Paid
- Select target countries/regions
- Accept necessary agreements

### Step 10: Upload Build
1. Go to "Testing" → "Internal Testing"
2. Upload the APK or AAB file
3. Add release notes
4. Start testing with internal testers

### Step 11: Submit for Review
1. Once internal testing is complete, go to "Production"
2. Upload the signed APK/AAB
3. Review all store listing details
4. Submit for review
5. Wait for Google's review (usually 24-48 hours)

---

## 📱 App Features to Highlight in Screenshots

### Screenshot 1: Home Screen
- **Title**: "Beautiful Moon Visualization"
- Shows the main moon emoji, current phase, illumination bar
- Next moon phase information
- Track Your Mood button

### Screenshot 2: Mood Tracking
- **Title**: "Track Your Emotional Patterns"
- Shows mood selection interface
- Demonstrates mood tracking features

### Screenshot 3: Calendar View
- **Title**: "Explore Moon Phases"
- Shows calendar with moon phase indicators
- Easy date selection

### Screenshot 4: Details & Festival Info
- **Title**: "Comprehensive Moon Data"
- Shows detailed moon information
- Festival calendar

### Screenshot 5: Multi-Language Support
- **Title**: "Available in Your Language"
- Shows language switcher
- Multiple language support

### Screenshot 6: Mood Tracking History
- **Title**: "Understand Your Patterns"
- Shows mood tracking results
- Connection between mood and moon phases

---

## 🔑 Important Files

### Created/Modified:
1. `android/key.properties` - Signing configuration
2. `android/app/build.gradle.kts` - Updated with signing config
3. `build/app/outputs/flutter-apk/app-release.apk` - Release APK

### Key Information:
- **Package ID**: com.mooncalendar.moon_calendar
- **Version Code**: 1
- **Version Name**: 1.0.0
- **Min SDK**: API 21+
- **Target SDK**: API 35+

---

## ⚠️ Before Final Submission

- [ ] Test the signed APK on multiple Android devices
- [ ] Verify all permissions are used correctly
- [ ] Check all app functionality
- [ ] Ensure no sensitive data is included
- [ ] Test on Android 6.0+ devices
- [ ] Verify location permissions work
- [ ] Test with mood tracking features
- [ ] Check all UI elements display correctly
- [ ] Test language switching
- [ ] Verify dark theme appearance

---

## 📊 Recommended Metadata

**App Title**: Moon Calendar
**Developer Name**: Lalit
**Email**: dr.lalit@gmail.com
**Website**: (Optional - add if available)
**Privacy Policy**: (Required - create a privacy policy page)
**Contact Email**: (Required for support)

---

## 🚀 Release Timeline

1. **Initial Setup**: Complete ✅
2. **Build Preparation**: Complete ✅
3. **Keystore Generation**: Pending (Do on Windows/Linux with Java)
4. **Testing**: Next
5. **Internal Testing Track**: 1-2 days
6. **Production Upload**: When ready
7. **Review Process**: 24-48 hours
8. **Live on Play Store**: Ready to download!

---

## 💡 Tips for Success

1. **Detailed Description**: Be specific about features and benefits
2. **High-Quality Screenshots**: Show key features clearly
3. **Regular Updates**: Push updates regularly (fixes, new features)
4. **User Reviews**: Respond to user feedback and reviews
5. **Localization**: Translations already in app! Highlight this.
6. **Unique Selling Points**: Moon tracking + mood correlation is unique
7. **Privacy**: Emphasize no data collection, works offline

---

Generated: January 29, 2026
App Version: 1.0.0
Build Ready: ✅ APK Generated (47.1 MB)
