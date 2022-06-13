module UsersHelper

    def get_string_priority(task)
        p = task.priority
        if(p == 1)
          "High"
        elsif(p == 2)
          "Medium"
        elsif(p == 3)
          "Low"
        else
          "Not specified"
        end
    end
      
end
