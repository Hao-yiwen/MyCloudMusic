//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 3 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var infoPlist: infoPlist { .init(source: .init(bundle: bundle, tableName: "InfoPlist", preferredLanguages: preferredLanguages, locale: locale)) }
    var launchScreen: launchScreen { .init(source: .init(bundle: bundle, tableName: "LaunchScreen", preferredLanguages: preferredLanguages, locale: locale)) }
    var localizable: localizable { .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale)) }

    func infoPlist(preferredLanguages: [String]) -> infoPlist {
      .init(source: .init(bundle: bundle, tableName: "InfoPlist", preferredLanguages: preferredLanguages, locale: locale))
    }
    func launchScreen(preferredLanguages: [String]) -> launchScreen {
      .init(source: .init(bundle: bundle, tableName: "LaunchScreen", preferredLanguages: preferredLanguages, locale: locale))
    }
    func localizable(preferredLanguages: [String]) -> localizable {
      .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.infoPlist` struct is generated, and contains static references to 1 localization keys.
    struct infoPlist {
      let source: RswiftResources.StringResource.Source

      /// en translation: CloudMusic
      ///
      /// Key: CFBundleName
      ///
      /// Locales: en, zh-Hans
      var cfBundleName: RswiftResources.StringResource { .init(key: "CFBundleName", tableName: "InfoPlist", source: source, developmentValue: "CloudMusic", comment: nil) }
    }

    /// This `_R.string.launchScreen` struct is generated, and contains static references to 0 localization keys.
    struct launchScreen {
      let source: RswiftResources.StringResource.Source
    }

    /// This `_R.string.localizable` struct is generated, and contains static references to 1 localization keys.
    struct localizable {
      let source: RswiftResources.StringResource.Source

      /// en translation: Server not found
      ///
      /// Key: ErrorNetworkUnknownHost
      ///
      /// Locales: en, zh-Hans
      var errorNetworkUnknownHost: RswiftResources.StringResource { .init(key: "ErrorNetworkUnknownHost", tableName: "Localizable", source: source, developmentValue: "Server not found", comment: nil) }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 2 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }

    /// Color `TestColor`.
    var testColor: RswiftResources.ColorResource { .init(name: "TestColor", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 1 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `SplashBanner`.
    var splashBanner: RswiftResources.ImageResource { .init(name: "SplashBanner", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }
  }
}