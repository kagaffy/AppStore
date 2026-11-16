.PHONY: bootstrap init generate open format format-lint test

DESTINATION ?= platform=iOS Simulator,name=iPhone 17

bootstrap:
	mint bootstrap

init: bootstrap generate

generate:
	mint run xcodegen generate

open:
	open AppStore.xcodeproj

format:
	mint run swiftformat .

format-lint:
	mint run swiftformat --lint .

# Swift Testing を既定のテストランタイムとして有効化（XCTest との共存は移行完了まで）。
test: generate
	set -o pipefail; \
	SWIFT_TESTING_XCTEST_INTEROP_MODE=complete \
	xcodebuild test \
		-project AppStore.xcodeproj \
		-scheme AppStore \
		-destination '$(DESTINATION)' \
		-skip-testing:AppStoreUITests \
		-skip-testing:AppStoreTests \
		| mint run xcbeautify
