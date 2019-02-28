class RulesEngine::Outcome
  attr_accessor :name,
                :values,
                :reference,
                :original

  def initialize(options = {})
    @name = options.fetch(:name)
    @values = options.fetch(:values)
    @reference = options.fetch(:reference, nil)
    @original = options.fetch(:original, nil)
  end
end
