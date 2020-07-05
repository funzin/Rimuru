.PHONY: setup
setup:
	swift build
	swift package generate-xcodeproj

.PHONY: swiftlint
swiftlint:
	swift run swiftlint
