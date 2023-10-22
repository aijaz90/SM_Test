# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SmallworldTesr' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SmallworldTesr

  #  iOS / OSX network debugging library! 🦊 FOR DEBUG ONLY
  pod 'netfox', :configurations => ['Debug'] # https://github.com/kasketis/netfox
  
  # ReactiveX # https://github.com/ReactiveX/RxSwift
  pod 'RxSwift', '~> 5.1.1'
  pod 'RxCocoa', '~> 5.1.1'
  # ReactiveX + Networking
  pod 'Moya/RxSwift', '~> 14.0.0'

  pod 'SwiftyJSON'
  pod 'DropDown'
  
  #  Dependency Injection
  pod 'Swinject'#, '2.7.0' # https://github.com/Swinject/Swinject
  pod 'SwinjectAutoregistration'#, '2.7.0' # https://github.com/Swinject/SwinjectAutoregistration


  target 'SmallworldTesrTests' do
    inherit! :search_paths
    # Pods for testing

 # ReactiveX
    pod 'RxBlocking', '~> 5.1.1'
    pod 'RxTest', '~> 5.1.1'
  end

  target 'SmallworldTesrUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
