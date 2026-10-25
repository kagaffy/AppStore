.PHONY: bootstrap init generate open format format-lint test

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

test: generate
	xcodebuild test \
		-project AppStore.xcodeproj \
		-scheme AppStore \
		-destination 'platform=iOS Simulator,name=iPhone 17' \
		-only-testing:AppStoreTests \
		-quiet
