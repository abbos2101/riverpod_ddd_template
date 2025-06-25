# Flutter Development Makefile

.PHONY: clean fix-ios fix-ios-clean gen-clean gen fix fmt build-apk-dev build-apk-prod run-dev run-prod res translate prompt add-all add-android add-ios add-web

# Load environment variables from .env.dev file
ifneq (,$(wildcard .env.dev))
    include .env.dev
    export
endif

# Variables
PACKAGE_NAME = $(shell grep '^name:' pubspec.yaml | awk '{print $2}' | tr -d '[:space:]')
# Use ORGANIZATION_DOMAIN from .env.dev, fallback to default if not set
ORG_NAME = $(if $(ORGANIZATION_DOMAIN),$(ORGANIZATION_DOMAIN),uz.abbos)

# Basic cleanup
clean:
	flutter clean
	flutter pub get

# iOS troubleshooting
fix-ios:
	cd ios && \
	pod cache clean --all && \
	pod clean && \
	pod deintegrate && \
	sudo gem install cocoapods-deintegrate cocoapods-clean && \
	pod repo update && \
	pod install

# Complete iOS reset
fix-ios-clean:
	sudo gem uninstall cocoapods && \
	sudo gem install cocoapods && \
	pod setup && \
	cd ios && \
	rm -rf Pods Podfile.lock Runner.xcworkspace && \
	pod cache clean --all && \
	pod install --repo-update && \
	flutter clean && \
	flutter pub get

# Code generation
gen-clean:
	dart run build_runner clean

gen:
	dart run build_runner watch --delete-conflicting-outputs

# Code formatting and fixes
fix:
	dart fix --apply
	dart format .

fmt:
	dart format .

# APK builds
build-apk-dev:
	flutter clean
	flutter build apk --dart-define=ENVIRONMENT=dev --release
	mv ./build/app/outputs/flutter-apk/app-release.apk "./build/app/outputs/flutter-apk/$(PACKAGE_NAME)_$(shell date +%d.%m.%Y).apk"
	open ./build/app/outputs/flutter-apk/

build-apk-prod:
	flutter clean
	flutter build apk --dart-define=ENVIRONMENT=prod --release
	mv ./build/app/outputs/flutter-apk/app-release.apk "./build/app/outputs/flutter-apk/$(PACKAGE_NAME)_$(shell date +%d.%m.%Y).apk"
	open ./build/app/outputs/flutter-apk/

# Run configurations
run-dev:
	flutter run --dart-define=ENVIRONMENT=dev --release

run-prod:
	flutter run --dart-define=ENVIRONMENT=prod --release

# Platform management
add-all:
	flutter create --platforms android,ios,web,windows --org $(ORG_NAME) .

add-android:
	flutter create --platforms android --org $(ORG_NAME) .

add-ios:
	flutter create --platforms ios --org $(ORG_NAME) .

add-web:
	flutter create --platforms web --org $(ORG_NAME) .

# Resource generators
res:
	dart run res_generator:generate

translate:
	dart run res_generator:translate

prompt:
	dart run prompt_generator:generate

# Debug: Show loaded environment variables
debug-env:
	@echo "ORGANIZATION_DOMAIN: $(ORGANIZATION_DOMAIN)"
	@echo "ORG_NAME: $(ORG_NAME)"
	@echo "APP_NAME: $(APP_NAME)"
	@echo "BASE_URL: $(BASE_URL)"