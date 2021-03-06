require 'ADB'

require 'stf/client'
require 'stf/log/log'
require 'stf/errors'
require 'stf/interactor/stop_debug_session_interactor'

class StopAllDebugSessionsInteractor
  include Log
  include ADB

  def initialize(stf)
    @stf = stf
  end

  def execute
    connected_devices = devices()
    remote_devices    = @stf.get_user_devices.map { |d| d.remoteConnectUrl }

    pending_disconnect = connected_devices & remote_devices
    pending_disconnect.each do |d|
      StopDebugSessionInteractor.new(@stf).execute d
    end
  end
end