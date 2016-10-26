require 'spec_helper'
require 'rails_helper'
describe "Tentang Pokedex" do
  it 'nama pokedex harus ada dan unik' do
  	pokedex1 = ::Pokedex.new(name: nil)
  	expect(pokedex1.save).to eq(false)	
  end
end
