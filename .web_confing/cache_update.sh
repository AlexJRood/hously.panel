#!/bin/bash

set -e  # Jeśli wystąpi błąd, skrypt się zatrzyma
set -o pipefail  # Jeśli błąd jest w `|`, skrypt się zatrzyma
set -x  # Debugowanie – pokazuje każdą linię

# 🔹 Ścieżki
APP_PATH="/httpdocs" # and depend on user
CACHE_FILE="$APP_PATH/cache_control.txt"
LOG_FILE="$APP_PATH/cache_update.log"

# 🔹 Czyszczenie starego logu i ustawienie przekierowania
echo "=== Aktualizacja cache $(date) ===" > "$LOG_FILE"
exec >> "$LOG_FILE" 2>&1

# 🔹 Sprawdzenie dostępu do katalogu aplikacji
if [[ ! -d "$APP_PATH" ]]; then
    echo "❌ Błąd: Katalog $APP_PATH nie istnieje lub brak dostępu!"
    exit 1
fi

# 🔹 Znalezienie wymaganych narzędzi
BC_PATH=$(command -v bc || echo "/local/bin/bc")
AWK_PATH=$(command -v awk || echo "/local/bin/awk")
SED_PATH=$(command -v sed || echo "/local/bin/sed")
BROTLI_PATH=$(command -v brotli || echo "/local/bin/brotli")
FIND_PATH=$(command -v find || echo "/local/bin/find")

# 🔹 Weryfikacja dostępności narzędzi
for CMD in "$BC_PATH" "$AWK_PATH" "$SED_PATH" "$BROTLI_PATH" "$FIND_PATH"; do
    if [[ ! -x "$CMD" ]]; then
        echo "❌ Błąd: Nie znaleziono narzędzia: $CMD"
        exit 1
    fi
done


# 🔹 Pobranie obecnej wersji cache lub ustawienie domyślnej
if [[ -f "$CACHE_FILE" ]]; then
    CURRENT_VERSION=$(cat "$CACHE_FILE")
else
    CURRENT_VERSION="1.00"
fi

# 🔹 Zwiększenie wersji cache o 0.01
NEW_VERSION=$(echo "$CURRENT_VERSION + 0.01" | "$BC_PATH")
NEW_VERSION=$(echo "$NEW_VERSION" | "$AWK_PATH" '{printf "%.2f", $1}')

# 🔹 Zapisanie nowej wersji cache do pliku
echo "$NEW_VERSION" > "$CACHE_FILE"

echo "🟢 Nowa wersja cache: ${NEW_VERSION}"

# 🔹 Aktualizacja `index.html` i `flutter_service_worker.js`
echo "🟢 Aktualizacja index.html i Service Workera..."
"$SED_PATH" -i "s|flutter_service_worker.js?v=[0-9.]*|flutter_service_worker.js?v=${NEW_VERSION}|g" "$APP_PATH/index.html"
"$SED_PATH" -i "s|main.dart.js?v=[0-9.]*|main.dart.js?v=${NEW_VERSION}|g" "$APP_PATH/index.html"

# 🔹 Sprawdzenie, czy `cache_control.txt` faktycznie został zapisany
if [[ ! -f "$CACHE_FILE" ]]; then
    echo "❌ Błąd: Plik cache_control.txt nie został zapisany!"
    exit 1
fi

# 🔹 Usuwanie starych plików Brotli
echo "🟢 Usuwanie starych plików Brotli..."
"$FIND_PATH" "$APP_PATH" -type f -name "*.br" -exec rm -v {} \; || echo "❌ Błąd usuwania Brotli!"

# 🔹 Tworzenie nowych wersji Brotli
echo "🟢 Tworzenie nowych wersji Brotli..."
"$FIND_PATH" "$APP_PATH" -type f \( \
    -name "*.js" -o \
    -name "*.css" -o \
    -name "*.wasm" -o \
    -name "*.json" -o \
    -name "*.svg" -o \
    -name "*.woff2" -o \
    -name "*.woff" -o \
    -name "*.ttf" -o \
    -name "*.otf" -o \
    -name "*.eot" -o \
    -name "*.ico" -o \
    -name "*.avif" \
\) -exec "$BROTLI_PATH" --best --keep {} \; || echo "❌ Błąd kompresji Brotli!"

# 🔹 Restart serwera (opcjonalnie, jeśli cache nie odświeża się natychmiast)
touch "$APP_PATH/index.html" || echo "❌ Błąd dotyku index.html"

echo "✅ Cache updated to version ${NEW_VERSION} | Brotli compression completed!"
