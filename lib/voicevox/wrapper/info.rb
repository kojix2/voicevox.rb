require "json"

class Voicevox
  SupportedDevices = Struct.new(:cpu, :cuda, :dml, keyword_init: true)

  #
  # サポートしているデバイスを取得します。
  #
  # @return [Voicevox::SupportedDevices] サポートしているデバイス。
  #
  def self.supported_devices
    SupportedDevices.new(
      **JSON.parse(Voicevox::Core.supported_devices),
    )
  end

  CharacterInfo = Struct.new(:name, :styles, :speaker_uuid, :version, keyword_init: true)
  StyleInfo = Struct.new(:name, :id, keyword_init: true)

  #
  # キャラクターの一覧を取得します。
  #
  # @return [Array<CharacterInfo>] キャラクターの一覧。
  #
  def self.characters
    JSON.parse(Voicevox::Core.metas).map do |meta|
      CharacterInfo.new(
        **{
          **meta,
          "styles" => meta["styles"].map { |style| StyleInfo.new(**style) },
        },
      )
    end
  end
end
