module CountBubbleHelper
  def count_bubble(count)
    class_name = "count-bubble #{count >= 10 ? 'double-digit' : ''}"
    content_tag :span, count, class: class_name 
  end

  def exclamation_bubble(count)
    if count > 0
      content_tag :span, gicon('exclamation-sign'), class: "exclamation-bubble"
    end
  end
end
