# frozen_string_literal: true

RSpec.shared_examples 'autocorrect' do
  it 'autocorrects' do
    autocorrected = autocorrect_source(original)

    expect(autocorrected).to eql(corrected)
  end
end
