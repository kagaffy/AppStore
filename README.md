# AppStore

Clone application of the iPhone App Store (study project).

現代化のロードマップ: [docs/modernization-plan.md](docs/modernization-plan.md)

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

## Common commands

| Command | Description |
|---------|-------------|
| `make bootstrap` | Mintfile の CLI をインストール |
| `make generate` | Xcode プロジェクト生成 |
| `make format` | SwiftFormat 適用 |
| `make format-lint` | SwiftFormat lint（CI 相当） |
| `make test` | ユニットテスト実行 |

## CLI tools (Mint)

バージョンは [Mintfile](Mintfile) で固定する。個別に `brew install xcodegen` などはしない。

- [XcodeGen](https://github.com/yonaskolb/XcodeGen)
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)

## App libraries (SPM)

- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)（削除予定）
- [SwiftDate](https://github.com/malcommac/SwiftDate)（削除予定）
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Hydra](https://github.com/malcommac/Hydra)（削除予定）
