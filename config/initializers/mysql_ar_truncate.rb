# lib/active_record/add_reset_pk_sequence_to_base.rb  
module ActiveRecord  
  class Base  
    def self.truncate  
      case ActiveRecord::Base.connection.adapter_name  
      when 'Mysql2'
        update_seq_sql = "TRUNCATE TABLE #{self.table_name}"
        ActiveRecord::Base.connection.execute(update_seq_sql)  
      else  
        raise "Task not implemented for this DB adapter"  
      end  
    end    
  end  
end
