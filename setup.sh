#!/usr/bin/env bash
# شغّله داخل مجلد المشروع بعد فك الضغط: bash setup.sh
set -e
mkdir -p /tmp/sz_src && rm -rf /tmp/sz_src/* && cp -r lib pubspec.yaml /tmp/sz_src/
flutter create --org com.sonyz --project-name sony_z --platforms android .
rm -rf lib && mkdir lib && cp -r /tmp/sz_src/lib/. lib/
cp /tmp/sz_src/pubspec.yaml pubspec.yaml
M=android/app/src/main/AndroidManifest.xml
sed -i 's/android:label="[^"]*"/android:label="sony-z"/' $M
grep -q "permission.INTERNET" $M || sed -i 's#<application#<uses-permission android:name="android.permission.INTERNET"/>\n    <application#' $M
flutter pub get
flutter build apk --release --split-per-abi
echo "تم. الملف: build/app/outputs/flutter-apk/app-arm64-v8a-release.apk"
