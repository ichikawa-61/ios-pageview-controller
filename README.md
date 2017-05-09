# UIPageViewController

## 概要
UIPageViewControllerは、コンテンツのページ間を遷移するUIを実現します。

## 関連クラス
UIViewController

## イニシャライザ
|イニシャライザ名|説明|サンプル|
|---|---|---|
|init(transitionStyle style: UIPageViewControllerTransitionStyle,<br> navigationOrientation: UIPageViewControllerNavigationOrientation,<br> options: [String : Any]? = nil) | style: ページ遷移のスタイル<br>navigationOrientation: ページ単位のナビゲーションの方向<br>options: オプションの辞書<br>　キーについて: https://developer.apple.com/reference/uikit/uipageviewcontroller/options_keys | pageViewController = UIPageViewController(transitionStyle: .scroll,<br>navigationOrientation: .horizontal,<br>options: [UIPageViewControllerOptionInterPageSpacingKey : 20]) |
 
## 主要プロパティ

|プロパティ名|説明|サンプル|
|---|---|---|
|delegate | delegateを指定する <br>UIPageViewControllerDelegateを利用するため | pageViewController.delegate = self |
|dataSource | dataSourceを指定する <br>UIPageViewControllerDataSourceを利用するため | pageViewController.dataSource = dataSource |

## 主要メソッド

|メソッド名|説明|サンプル|
|---|---|---|
|setViewControllers(_ viewControllers: [UIViewController]?,<br>direction: UIPageViewControllerNavigationDirection,<br>animated: Bool,<br>completion: ((Bool) -> Void)? = nil) | viewControllers: 表示されるViewController<br>direction: ナビゲーションの方向<br>animated: アニメーションするかどうか<br>completion: アニメーション完了後に呼び出される（finished: true-> アニメーションが完了した場合 false-> アニメーションがスキップされた場合） | pageViewController.setViewControllers([startingViewController],<br>direction: .forward,<br>animated: false,<br>completion: {done in}) |

## UIPageViewControllerDelegateプロトコルのメソッド

|メソッド名|説明|必須|
|---|---|---|
|willTransitionTo | ジェスチャーによる画面遷移直前に呼び出される | - |
|didFinishAnimating | ジェスチャーによる画面遷移完了後に呼び出される | - |

## UIPageViewControllerDataSourceプロトコルのメソッド

|メソッド名|説明|必須|
|---|---|---|
|viewControllerBefore | 前ページのViewControllerを返す | ◯ |
|viewControllerAfter | 次ページのViewControllerを返す | ◯ |

## フレームワーク
UIKit.framework

## サポートOSバージョン
iOS5.0以上

## 開発環境
|category | Version| 
|---|---|
| Swift | 3.1 |
| XCode | 8.3.2 |
| iOS | 10.0〜 |

## 参考
https://developer.apple.com/reference/uikit/uipageviewcontroller
https://developer.apple.com/reference/uikit/uipageviewcontrollerdelegate
https://developer.apple.com/reference/uikit/uipageviewcontrollerdatasource
