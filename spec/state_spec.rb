require 'spec_helper'

describe Carb::State do
  it 'loads and saves state' do
    state = Carb::State.instance
    Dir.mktmpdir do |tmpdir|
      raise_error( Carb::NoStateError ) do
        state.find_state_file( tmpdir )
        state.init_dir( tmpdir )
        state.reset
        state.find_state_file( tmpdir )
        state.where.should = File.join tmpdir, Carb::State::CONF_FILE
      end
    end
  end
end
