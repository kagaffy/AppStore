# AppStore

Clone application of the iPhone App Store (study project).

## Requirements

- Xcode 27.1+
- [Mint](https://github.com/yonaskolb/Mint)（CLI ツールのバージョン管理）

## Setup

```bash
brew install mint
make init
make open
```

`make init` は `mint bootstrap` のあと XcodeGen で `AppStore.xcodeproj` を生成する。

## Modules (local SPM)

| Package | Role |
|---------|------|
| `Packages/Domain` | Entity / UseCase / Repository protocol（外部依存なし） |
| `Packages/AppData` | API / DTO / Repository 実装（Domain に依存） |
| `Packages/Presentation` | ViewModel / SwiftUI（Domain に依存。Phase 3 で本実装） |

依存規則: `App → Presentation → Domain ← AppData`

## Common commands

| Command | Description |
|---------|-------------|
| `make bootstrap` | Mintfile の CLI をインストール |
| `make generate` | Xcode プロジェクト生成 |
| `make format` | SwiftFormat 適用 |
| `make format-lint` | SwiftFormat lint（CI 相当） |
| `make test` | App + Domain + AppData + Presentation のユニットテスト |

## CLI tools (Mint)

バージョンは [Mintfile](Mintfile) で固定する。個別に `brew install xcodegen` などはしない。

- [XcodeGen](https://github.com/yonaskolb/XcodeGen)
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
- [xcbeautify](https://github.com/cpisciotta/xcbeautify)

## App libraries (SPM)

- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Hydra](https://github.com/malcommac/Hydra)（削除予定 / AppData 経由）
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)（削除予定 / AppData 経由）
