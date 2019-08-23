class ZipcodeStateMap
  ZIPCODE_STATE = JSON.parse(File.read(File.join(Rails.root, 'data', 'zipcode_to_state_map.json'))).freeze
end