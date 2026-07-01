module ApplicationHelper
  def format_currency(symbol = "£", value)
    symbol + sprintf("%.2f", value)
  end
end
