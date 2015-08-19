module BootstrapHelper
  def bootstrap_col(args)
    args.map{|k,v| "col-#{k}-#{v}" }.join(' ')
  end

  def bootstrap_offset(args)
    args.map{|k,v| "col-#{k}-offset-#{v}" }.join(' ')
  end

  def bootstrap_push(args)
    args.map{|k,v| "col-#{k}-push-#{v}" }.join(' ')
  end
end
