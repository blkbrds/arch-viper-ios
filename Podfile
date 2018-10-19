platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def app_pods
  # UI
  pod 'IQKeyboardManagerSwift'
  pod 'SVProgressHUD'
  pod 'PureLayout'

  # Network
  pod 'Alamofire'
  pod 'Socket.IO-Client-Swift'
  pod 'Kingfisher'

  # Analytics
  pod 'Fabric'
  pod 'Crashlytics'

  # Utils
  pod 'RxSwift'
  pod 'RxSwiftExt'
  pod 'RxDataSources'
  pod 'R.swift'
  pod 'ObjectMapper'
  pod 'SwifterSwift'
  pod 'XCGLogger'

  # Security
  pod 'RNCryptor'

  # Development
  pod 'SwiftLint', '~> 0.25.0'
end

def test_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'Viper' do
  use_frameworks!
  app_pods

  target 'ViperTests' do
    inherit! :search_paths
    test_pods
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['SwifterSwift'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = 4.2
      end
    end
    if ['R.swift.Library'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = 4.0
      end
    end
  end
  installer.pods_project.build_configurations.each do |config|
    if config.name.start_with? 'Release'
      config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
    end
  end
end
