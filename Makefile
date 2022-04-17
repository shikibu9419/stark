XCODEFLAGS=-project "Stark.xcodeproj" -scheme "Stark"

BUILD_DIR=$(PWD)/Build
STARK_ACHIVE=$(BUILD_DIR)/Stark.xcarchive
EXPORT_PLIST=$(PWD)/ExportPlist.plist

JAVASCRIPT_DIR=$(PWD)/StarkJS

all: build

build:
	@xcodebuild $(XCODEFLAGS) build

archive:
	@xcodebuild $(XCODEFLAGS) clean archive -archivePath $(STARK_ACHIVE)
	@xcodebuild -exportArchive -archivePath $(STARK_ACHIVE) -exportPath $(BUILD_DIR) -exportOptionsPlist $(EXPORT_PLIST)

bootstrap:
	@cd $(JAVASCRIPT_DIR) && npm install

lint:
	@cd $(JAVASCRIPT_DIR) && npx eslint *.js

concat:
	@cd $(JAVASCRIPT_DIR) && npx concat *.js -o ../Stark/Resources/stark-lib.js

.PHONY: all build archive bootstrap lint concat
