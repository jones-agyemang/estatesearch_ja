module ApplicationHelper
  def format_currency(value, symbol = "£")
    symbol + sprintf("%.2f", value)
  end
end
