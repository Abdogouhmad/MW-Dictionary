# Define your app's targets here
APP_NAME = my_flutter_app

# Flutter commands
FLUTTER = flutter
DART = dart
ADB = adb

# Default target when no arguments are given to make
.PHONY: help
help:
	@echo "Makefile commands:"
	@echo "  make get_deps        - Fetch project dependencies"
	@echo "  make run             - Run the Flutter app on a connected device or emulator"
	@echo "  make build_apk       - Build an APK for Android"
	@echo "  make build_ios       - Build for iOS (requires macOS)"
	@echo "  make clean           - Remove build files"
	@echo "  make fmt             - Format Dart code in the project"
	@echo "  make lint            - Analyze Dart code for errors and warnings"
	@echo "  make devices         - List connected devices"
	@echo "  make logs            - Show logs from the connected device"
	@echo "  make install_apk     - Install APK to connected Android device"
	@echo "  make uninstall_apk   - Uninstall APK from connected Android device"

# Fetch project dependencies
.PHONY: get_deps
get_deps:
	$(FLUTTER) pub get

# Run the app in release mode
.PHONY: run
run:
	$(FLUTTER) run --release

# Build APK for Android
.PHONY: build_apk
build_apk:
	$(FLUTTER) build apk --release

# Build for iOS (macOS only)
.PHONY: build_ios
build_ios:
	$(FLUTTER) build ios --release

# Clean build files
.PHONY: clean
clean:
	$(FLUTTER) clean

# Format Dart code
.PHONY: fmt
fmt:
	$(DART) format .

# Analyze Dart code for errors and warnings
.PHONY: lint
lint:
	$(FLUTTER) analyze
	$(DART) analyze

# List connected devices
.PHONY: devices
devices:
	$(FLUTTER) devices

# Show logs from the connected device
.PHONY: logs
logs:
	$(FLUTTER) logs

# Install APK to connected Android device
.PHONY: install_apk
install_apk: build_apk
	$(ADB) install -r build/app/outputs/flutter-apk/app-release.apk

# Uninstall APK from connected Android device
.PHONY: uninstall_apk
uninstall_apk:
	$(ADB) uninstall $(APP_NAME)
