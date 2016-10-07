# TFBoccoSwift

[![CI Status](http://img.shields.io/travis/tfuru/TFBoccoSwift.svg?style=flat)](https://travis-ci.org/tfuru/TFBoccoSwift)
[![Version](https://img.shields.io/cocoapods/v/TFBoccoSwift.svg?style=flat)](http://cocoapods.org/pods/TFBoccoSwift)
[![License](https://img.shields.io/cocoapods/l/TFBoccoSwift.svg?style=flat)](http://cocoapods.org/pods/TFBoccoSwift)
[![Platform](https://img.shields.io/cocoapods/p/TFBoccoSwift.svg?style=flat)](http://cocoapods.org/pods/TFBoccoSwift)

[BOCCO API β](http://api-docs.bocco.me/index.html) を Swift で利用する為のライブラリ

| API | 実装 | 追加 権限 |
|:-----------:|:------------:|:------------:|
| アクセストークンの取得 | ◯ |  |
| チャットルームの取得 | ◯ |  |
| メッセージの送信 | ◯ |  |
| メッセージ一覧の取得  | ◯ | ◯ |
| イベントの取得 | ☓ | ◯ |
| メッセージを既読にする | ☓ | ◯ |

※別途 権限  
このAPIにアクセスするためには、追加の権限が必要です。BOCCOサポートに問合せが必要です。  
追加の権限がない場合レスポンスが 下記のbodyがついた 404レスポンスとなります。
```
{"code":404001,"message":"Not Found"}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TFBoccoSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TFBoccoSwift"
```

## Author

tfuru

## License

TFBoccoSwift is available under the MIT license. See the LICENSE file for more info.
