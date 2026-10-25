# Agent Instructions — AppStore

学習用の iPhone App Store クローン。現代化の全体像は [docs/modernization-plan.md](docs/modernization-plan.md) を正とする。

## 現在のフェーズ

Phase 単位で進める。未着手フェーズの大規模変更は、明示的に依頼されない限り行わない。

## CLI / ツールチェーン

- CLI は **Mint** 経由のみ。`Mintfile` のバージョンを使う
- プロジェクト生成: `make generate`（内部で `mint run xcodegen`）
- フォーマット: `make format` / CI 相当は `make format-lint`
- テスト: `make test`（unit test のみ。UI test は後回し）
- `brew install xcodegen` やグローバル CLI 前提の手順を新たに書かない（Mint 本体の brew インストールは可）
- `project.yml` 変更後は必ず `make generate`
- 言語モードは当面 Swift 5（`SWIFT_VERSION: 5.0`）。Swift 6 化は Phase 1–2

## アーキテクチャ方針

- Clean Architecture のレイヤ分割を優先（Phase 1）:
  - `Domain` ← 外部依存なし（Entity / UseCase / Repository protocol）
  - `Data` → Domain のみ依存（API / DTO / Repository 実装）
  - `Presentation` → Domain のみ依存（ViewModel / SwiftUI）。**Data を import しない**
  - App target → Composition Root（DI・ナビ組み立て）
- Phase 5 でフィーチャーモジュールへ垂直分割する予定。レイヤが安定するまで Feature 分割しない
- 依存規則: `App → Presentation → Domain ← Data`

## UI / 設計

- 新規 UI は **SwiftUI**。画面ホストは **`UIViewController` + `UIHostingController`**
- **新規の Storyboard / xib は追加しない**。既存は Phase 3 で削除する
- MVVM: ロジックは ViewModel / UseCase に置き、ViewController には置かない
- Liquid Glass / 大画面適応は Phase 4。それ以前にデザインシステム全面刷新しない

## テスト

- Domain / Data のロジック変更には **ユニットテスト必須**
- ViewModel は UseCase / Repository をモック注入してテストする
- ネットワークはプロトコル化し、fixture JSON で検証する
- UI テスト拡充は後回し（単体テスト文化を先に定着）

## 依存ライブラリ

- 新規に Hydra / SwiftyJSON / SwiftDate を使わない（Phase 2 で削除予定）
- 非同期は `async/await`、JSON は `Codable`、日付は Foundation
- Kingfisher は当面残してよい。削除判断は Phase 6

## API

- ランキング RSS 差し替えの調査結果は [docs/rss-api-replacement.md](docs/rss-api-replacement.md)
- 実装は Phase 2。Repository 境界の外に URL ハードコードを増やさない

## 変更の進め方

- 依頼された Phase / タスクの範囲に留める
- `project.yml` を編集したら `make generate` で Xcode プロジェクトを再生成する
- コミットはユーザーが依頼したときだけ作成する
