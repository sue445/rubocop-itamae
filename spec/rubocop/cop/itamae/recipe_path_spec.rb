# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Itamae::RecipePath do
  subject(:cop) { described_class.new(config) }

  let(:config) do
    RuboCop::Config.new(
      {
        'AllCops' => {
          'Include' => []
        },
        described_class.badge.to_s => cop_config
      },
      '/some/.rubocop.yml'
    )
  end

  let(:cop_config)       { {} }
  let(:source)           { "package 'git'" }
  let(:processed_source) { parse_source(source) }

  before do
    allow(processed_source.buffer)
      .to receive(:name).and_return(filename)
    @offenses = _investigate(cop, processed_source)
  end

  context 'within cookbooks' do
    let(:filename) { '/path/to/repo/cookbooks/git/default.rb' }

    it 'registers no offense' do
      expect(@offenses).to be_empty
    end
  end

  context 'within roles' do
    let(:filename) { '/path/to/repo/roles/web.rb' }

    it 'registers no offense' do
      expect(@offenses).to be_empty
    end
  end

  context 'within other path' do
    let(:filename) { '/path/to/repo/recipe.rb' }

    it 'registers an offense' do
      expect(@offenses.size).to eq(1)
      expect(@offenses.map(&:message)).to eq(['Prefer recipe to placed under `cookbooks` dir or `roles` dir.'])
    end
  end
end
