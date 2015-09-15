module CountBubbleHelper
  def count_bubble(count)
    class_name = "count-bubble #{count >= 10 ? 'double-digit' : ''}"
    content_tag :span, count, class: class_name 
  end
end
