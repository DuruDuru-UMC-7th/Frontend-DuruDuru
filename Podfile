# Uncomment the next line to define a global platform for your project
platform :ios, '18.0'

target 'DuruDuru' do
  use_frameworks!

  # Pods for YourProjectName
  pod 'Kingfisher', '~> 8.1.4'
  pod 'NVActivityIndicatorView', '~> 5.2.0'
  pod 'SnapKit', '~> 5.7.1'
  pod 'Then', '~> 3.0.0'
  pod 'StompClientLib', '~> 1.4.1'

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end

  # Add any other dependencies here
end
