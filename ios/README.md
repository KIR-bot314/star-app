# iOS-обёртка «Звёздочки»

Приложение из одного `WKWebView`, которое открывает https://kir-bot314.github.io/star-app/.
Нужно только для того, чтобы «Звёздочки» можно было добавить в «Упрощённый доступ»
на детских iPhone: туда попадают лишь настоящие приложения, веб-приложения с экрана «Домой» не видны.
Вся логика остаётся на GitHub Pages, обновления приложения не требуют пересборки.

## Сборка Ad Hoc `.ipa` (для друга с платным аккаунтом разработчика)

1. developer.apple.com → Certificates, Identifiers & Profiles → **Devices** → «+» → добавить два UDID (пришлёт Кирилл).
2. В Xcode 15+ выполнен вход в Apple ID команды (Xcode → Settings → Accounts).
3. Скачать проект и собрать:

   ```bash
   git clone https://github.com/KIR-bot314/star-app.git && cd star-app/ios
   ./build.sh TEAM_ID
   ```

   `TEAM_ID` — 10 символов, developer.apple.com → Membership details.
4. Отправить Кириллу два файла: `build/ipa/Zvezdochki.ipa` и `build/ipa/manifest.plist`.

Что делает скрипт: `xcodebuild archive` с автоматической подписью, затем `-exportArchive`
методом `release-testing` (бывший Ad Hoc). App ID, сертификат и профиль создаются автоматически
(`-allowProvisioningUpdates`), в профиль попадают все устройства, зарегистрированные в аккаунте.
Если bundle id `com.kirillborisov.zvezdochki` окажется занят другой командой:
`./build.sh TEAM_ID com.другой.id` и сообщить Кириллу новый id.

То же самое руками: открыть `Zvezdochki.xcodeproj` → Signing & Capabilities → выбрать Team →
Product → Archive → Distribute App → Release Testing → Export.

Профиль Ad Hoc живёт год. Через год повторить шаги 3–4, код менять не нужно.

## Установка на телефоны (Кирилл)

Файлы `Zvezdochki.ipa` и `manifest.plist` кладутся в эту папку и пушатся. После этого на детском iPhone
(выйдя из Упрощённого доступа) в Safari открыть https://kir-bot314.github.io/star-app/ios/install.html
и нажать «Установить». Затем: Настройки → Универсальный доступ → Упрощённый доступ →
Управление приложениями → добавить «Звёздочки».

Запасной способ без сайта: подключить iPhone кабелем к Маку и перетащить `Zvezdochki.ipa`
на устройство в боковой панели Finder.
