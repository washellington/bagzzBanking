module TransactionsHelper

  def search_button
    button_tag id:  'search-transaction-bttn' do
      svg 'search_icon'
    end
  end

end
