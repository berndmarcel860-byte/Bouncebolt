# Bounce Bolt (Godot Android)

Bounce Bolt is a native Android endless one-touch arcade game project built with **Godot 4** for Google Play Store publishing.

## Included game systems

- Endless procedural obstacle gameplay loop with instant retry
- Dynamic difficulty scaling, score system, combo multiplier, high score save
- Daily rewards and daily mission rotation
- Reward progression with unlockable skins/trails/world themes
- Google Play Services hooks for leaderboards and achievements
- Ad monetization service hooks for AdMob rewarded/interstitial ads
- In-app purchase handling hook (remove ads + premium content)
- Android export presets for signed **AAB** and **APK**

## Project layout

- `/home/runner/work/Bouncebolt/Bouncebolt/godot/project.godot` - Godot app/game configuration
- `/home/runner/work/Bouncebolt/Bouncebolt/godot/export_presets.cfg` - Android Play Store export setup
- `/home/runner/work/Bouncebolt/Bouncebolt/godot/scenes` - Main gameplay scenes
- `/home/runner/work/Bouncebolt/Bouncebolt/godot/scripts` - Gameplay, persistence, daily systems, monetization, platform integration
- `/home/runner/work/Bouncebolt/Bouncebolt/godot/android/privacy_policy_url.txt` - Privacy policy placeholder

## Build for Google Play

1. Open `/home/runner/work/Bouncebolt/Bouncebolt/godot` in Godot 4.
2. Install Android build template in Godot.
3. Configure release keystore values in `export_presets.cfg` (or in the export dialog).
4. Configure real AdMob unit IDs and Google Play Games IDs in the Android plugin layer.
5. Export signed **AAB** (`build/BounceBolt.aab`) for Play Store upload.

## Android compliance checklist

- Portrait orientation configured
- Android network permissions configured for ads/services
- App icon configured
- Privacy policy support placeholder included
- Signed release export paths ready for AAB/APK

