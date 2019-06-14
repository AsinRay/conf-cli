spring:
  application:
    name: ws
  cloud:
    config:
      uri: https://@conf.token@@confserver.ailu.internal@:8443
      #uri: http://@confserver.ailu.internal@:9999
      profile: '@conf.profile@'
      fail-fast: true
      #label: pro