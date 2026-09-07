#!/bin/zsh
# Сборка Ad Hoc (.ipa) для установки на зарегистрированные iPhone.
# Использование:  ./build.sh TEAM_ID [bundle.identifier]
#   TEAM_ID — 10 символов, developer.apple.com → Membership details.
#   Второй аргумент нужен только если стандартный bundle id окажется занят.
# Требуется Xcode 15+, в котором выполнен вход в Apple ID команды (Xcode → Settings → Accounts).
set -euo pipefail
TEAM=${1:?Укажи Team ID: ./build.sh TEAM_ID}
BUNDLE=${2:-com.kirillborisov.zvezdochki}
cd "$(dirname "$0")"
rm -rf build

xcodebuild archive \
  -project Zvezdochki.xcodeproj -scheme Zvezdochki -configuration Release \
  -destination 'generic/platform=iOS' -archivePath build/Zvezdochki.xcarchive \
  DEVELOPMENT_TEAM="$TEAM" PRODUCT_BUNDLE_IDENTIFIER="$BUNDLE" \
  -allowProvisioningUpdates -quiet

sed "s/TEAM_ID/$TEAM/" ExportOptions.plist > build/ExportOptions.plist
if ! xcodebuild -exportArchive -archivePath build/Zvezdochki.xcarchive \
     -exportOptionsPlist build/ExportOptions.plist -exportPath build/ipa -allowProvisioningUpdates -quiet; then
  # старый Xcode не знает метод release-testing — пробуем прежнее имя
  sed -i '' 's/release-testing/ad-hoc/' build/ExportOptions.plist
  xcodebuild -exportArchive -archivePath build/Zvezdochki.xcarchive \
     -exportOptionsPlist build/ExportOptions.plist -exportPath build/ipa -allowProvisioningUpdates -quiet
fi

echo
echo "Готово. Отправь Кириллу два файла из папки $(pwd)/build/ipa:"
ls -1 build/ipa/*.ipa build/ipa/manifest.plist
