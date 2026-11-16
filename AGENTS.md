# Agent Instructions — AppStore

学習用の iPhone App Store クローン。

## 現在のフェーズ

Phase 3（MVVM 抽出）。全画面のロジックを Presentation ViewModel / Model へ移す。**xib / storyboard / SwiftUI など UI 置換はユーザーが後で行う**（エージェントは UI を変更しない）。Phase 単位で進める。未着手フェーズの大規模変更は、明示的に依頼されない限り行わない。

## CLI / ツールチェーン

- CLI は **Mint** 経由のみ。`Mintfile` のバージョンを使う
- プロジェクト生成: `make generate`（内部で `mint run xcodegen`）
- フォーマット: `make format` / CI 相当は `make format-lint`
- テスト: `make test`（unit test のみ。UI test は後回し）
- `brew install xcodegen` やグローバル CLI 前提の手順を新たに書かない（Mint 本体の brew インストールは可）
- `project.yml` 変更後は必ず `make generate`
- Xcode でパッケージソースを見るときは Project Navigator の `Packages` グループ、または各 Package.swift から開く
- `fileGroups: Packages` は使わない（`localPackagesGroup` と二重表示になる）
- Xcode.app で Missing package product が出る場合は `script/fix-local-package-backlinks.py` を手動実行するか、`project.yml` の `postGenCommand` を有効化する
- 言語モードは当面 Swift 5（`SWIFT_VERSION: 5.0`）。Swift 6 化は Phase 3 以降で UI ごと進める

## アーキテクチャ方針

- Clean Architecture のレイヤ分割（ローカル SPM）:
  - `Packages/Domain` ← 外部依存なし（Entity / UseCase / Repository protocol）
  - `Packages/AppData` → Domain のみ依存（API / Response / Repository 実装）。**モジュール名は `AppData`（Foundation.`Data` との衝突回避）**
  - `Packages/Presentation` → Domain のみ依存（ViewModel / SwiftUI / Model）。**AppData を import しない**
  - App target → Composition Root（DI・ナビ組み立て）のみが AppData の具象に依存する
- Phase 5 でフィーチャーモジュールへ垂直分割する予定。レイヤが安定するまで Feature 分割しない
- 依存規則: `App → Presentation → Domain ← AppData`

## 命名規則（型）

`DTO` という語は使わない。層ごとにサフィックスを固定する。

| 層 | サフィックス | 例 | 置き場所 |
|---|---|---|---|
| ネットワーク JSON 境界 | `xxxResponse` | `AppDetailsResponse`, `AppsGroupResponse` | `AppData` |
| UI 表示用 | `xxxModel` | `AppDetailsModel`, `AppsGroupModel` | `Presentation` |
| ドメインの中核 | サフィックスなし（Entity） | `AppDetails`, `AppsGroup`, `Review` | `Domain` |

- `Response` → Domain Entity への変換は AppData（`toDomain()` など）
- Domain Entity → `Model` への変換は Presentation（ViewModel 付近）
- ViewModel は `xxxViewModel`。`xxxModel` は画面が持つ表示データ
- 新規コードで `DTO` / `xxxDTO` を作らない

## UI / 設計

- 現状 UI は既存 UIKit + xib。SwiftUI 化・xib 削除はユーザー担当（エージェントは触らない）
- MVVM: ロジックは ViewModel / UseCase に置き、ViewController は薄いバインダのみ
- View / ViewModel / VC は Domain（UseCase）だけに依存し、**AppData を import しない**（配線は CompositionRoot）
- Liquid Glass / 大画面適応は Phase 4。それ以前にデザインシステム全面刷新しない

## テスト

- Domain / AppData のロジック変更には **ユニットテスト必須**
- 単体テストは **Swift Testing**（`import Testing` / `@Test` / `#expect` / `#require`）。XCTest の新規追加はしない
- UI テスト（`AppStoreUITests`）のみ XCTest / XCUITest を継続利用する
- ViewModel は UseCase / Repository をモック注入してテストする
- ネットワークは `HTTPClient` プロトコル化し、fixture JSON で検証する（JSON はインデント付きで保存）
- UI テスト拡充は後回し（単体テスト文化を先に定着）
- `make test` / CI はパッケージ単体テストのみ（ホスト App の `AppStoreTests` / UITests はスキップ）

## 依存ライブラリ

- Hydra / SwiftyJSON / SwiftDate は使わない（削除済み）
- 非同期は `async/await`、JSON は `Codable`、日付は Foundation
- Kingfisher は当面残してよい。削除判断は Phase 6

## API

- ランキングは旧 `itunes.apple.com/jp/rss/...`。見出しは `RankingChart.displayTitle` でクライアント固定
- 「We Love」相当は公式代替なしのため `newapplications` で代用
- Search / Lookup / Reviews は既存ホスト。Reviews は HTTPS
- Repository 境界の外に URL ハードコードを増やさない（`URLMaker` に集約）

## 変更の進め方

- 依頼された Phase / タスクの範囲に留める
- `project.yml` を編集したら `make generate` で Xcode プロジェクトを再生成する
- コミットはユーザーが依頼したときだけ作成する
