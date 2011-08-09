module CanTangoFixtures
  def tango_permissions
    {"roles"=>{
      "admin"=>{
       "can"=>{
        "manage"=>["all"]
       }},
      "user"=>{
       "can"=>{
        "read"=>["^articles", "Post"],
        "write"=>["Comment"]
       },
       "cannot"=>{
        "write"=>["Post"],
        "write"=>["Article"]
       }
      }
     }, 
     "role_groups"=>{"bloggers"=>{"can"=>{"read"=>["Article", "Comment"]}, 
                                  "cannot"=>{"write"=>["Article", "Post"]}}, 
                     "editors"=>{"can"=>{"read"=>["Article", "Comment"]}, 
                                 "cannot"=>{"write"=>["Article", "Post"]}}}, 
     "licenses"=>{"editors"=>{"can"=>{"manage"=>["all"]}}},
     "users" => {"kris@gmail.com" => {"can" => {"read" =>["Article"] }}}
    
    }  
  end
end

