platform :ios, '13.0'

target 'MyCloudMusic' do
  use_frameworks!

  # Direct pods are pinned to the newest CocoaPods trunk release that still
  # matches this app's APIs. Trunk does not publish a newer Moya, HandyJSON,
  # TangramKit, DynamicColor, or NSObject+Rx.
  pod 'TangramKit', '1.4.2'
  pod 'R.swift', '7.8.0'
  pod 'DynamicColor', '5.0.1'
  pod 'QMUIKit', '4.8.0'
  pod 'Moya/RxSwift', '15.0.0'
  pod 'NSObject+Rx', '5.2.2'
  pod 'SDWebImage', '5.21.7'
  pod 'HandyJSON', '5.0.2'

  # Transitive, pinned so resolution does not float past a known-good trunk
  # release. RxSwift 6.10+ dropped its podspec; 6.9.0 is the newest trunk pod.
  pod 'Alamofire', '5.12.2'
  pod 'RxSwift', '6.9.0'

  target 'MyCloudMusicTests' do
    inherit! :search_paths
  end

  target 'MyCloudMusicUITests' do
  end
end
