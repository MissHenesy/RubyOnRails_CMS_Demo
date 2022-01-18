class PullQuote < ApplicationRecord
  belongs_to :post, :inverse_of => :pull_quotes, optional: true

end
