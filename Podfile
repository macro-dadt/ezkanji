
# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'
# Uncomment this line if you're using Swift
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'KanjiApp' do
    
   
    pod 'SwiftyJSON', :git => 'https://github.com/acegreen/SwiftyJSON.git', :branch => 'swift3'
    pod 'Alamofire'
    pod 'SDWebImage’
    pod 'SVProgressHUD'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'Google/Analytics'
    pod 'Google/SignIn'
    pod 'Firebase/Core'
    pod 'Firebase/AdMob'
    pod 'SQLite.swift', '~> 0.11.3'
    pod 'GRDB.swift'
end

target 'KanjiAppTests' do
    
end

target 'KanjiAppUITests' do
    
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end


