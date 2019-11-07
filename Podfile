# frozen_string_literal: true

platform :ios, '12.0'
use_frameworks!

def common_pods
  pod 'SnapKit', '~> 5'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RxRealm'
  pod 'SwiftGen', '~> 6.0'
end

target 'AddressBook' do
  common_pods
end

target 'AddressBookTests' do
  common_pods
  pod 'Quick'
  pod 'Nimble'
end
