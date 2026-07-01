class PaymentRequest < ApplicationRecord
  belongs_to :lawyer, class_name: "Lawyer"
  belongs_to :response
end

# <table>
#   <thead>
#     <tr>
#       <th>Title</th>
#       <th>Body</th>
#       <th>Category</th>
#       <th>Status</th>
#       <th>Response</th>
#     </tr>
#   </thead>

#   <tbody>


#     <% @questions.each do |question| %>
#       <tr>
#         <td><%= question.title %></td>
#         <td><%= question.body %></td>
#         <td><%= question.category %></td>
#         <td><%= question.status %></td>
#         <td>
#           <% if question.responses.joins(:payment_request).exists?(paid: false) %>
#             <div>
#               <%= button_to("Approve payment", approve_payment_question_path(question), method: :patch) %>
#             </div>
#           <% elsif question.responses.any? %>
#             Payment approved
#           <% else %>
#             No Response
#           <% end%>
#         </td>
#       </tr>
#     <% end %>
#   </tbody>
# </table>
