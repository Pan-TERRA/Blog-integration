source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'Blog-integration' do

pod 'Alamofire'
pod 'AlamofireObjectMapper'
pod 'AlamofireImage'
pod 'SwiftyJSON'
pod 'IQKeyboardManagerSwift'
pod 'KMPlaceholderTextView'
pod 'DZNEmptyDataSet'

pod 'Firebase/Core'
pod 'FirebaseUI/Auth'
pod 'Firebase/Database'

end

target 'Blog-integrationTests' do
    inherit! :search_paths

pod 'Alamofire'
pod 'AlamofireObjectMapper'
pod 'AlamofireImage'
pod 'SwiftyJSON'
pod 'IQKeyboardManagerSwift'
pod 'KMPlaceholderTextView'
pod 'DZNEmptyDataSet'

pod 'Firebase/Core'
pod 'FirebaseUI/Auth'
pod 'Firebase/Database'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |configuration|
            configuration.build_settings['SWIFT_VERSION'] = "4.0"
            configuration.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
        end
    end
end
