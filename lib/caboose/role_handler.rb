module Caboose
  
  class AccessHandler   
    include LogicParser
    
    #@acls = {}
    
    #def register_key(key)
    #  key.downcase!
    #  if @acls.has_key? key
    #    raise DuplicateKeyError, "An Key named '#{key}' is already registered"
    #  end
    #  @acls[key] = KeyLookup.new(key)
    #end   
  
    def check(key, context)
      false
    end
  
  end
   
  # The RoleHandler hold a collection of RoleLookup objects
  # one RoleLookup object gets initialized fror every key.title
  # returned from Role.find(:all). so your set up a RoleHandler
  # and give it the Role model object.
  # @handler = RoleHandler.new(Role)
  # @handler.process("(admin | moderator) & !blacklisted", @user)
  class RoleHandler < AccessHandler 
    
    # loads an ActiveRecord Role model and registers all the keys.
    def initialize(model)
      #@acls = {}
      #model.find(:all).each do |role|
      # register_key(role.title)
      #end
    end
    
    def check(key, context)
      #return false unless @acls[key]    
      context[:user].roles.map{ |role| role.title.downcase}.include? key
    end
        
  end # End RoleHandler

=begin  
  # Does a check using an active record lookup on a key model
  class KeyLookup
     # key gets passed in here. 
     def initialize(key)
        @key = key
     end
     # Check gets called with context. context has a user model object
     # in context[:user]. We collect all the user.keys title attribute
     # and see if @key is included in those key.title's
     def check(user)
        user.roles.map{ |role| role.title.downcase}.include? @key
     end
   end # END KeyLookup
   
   # raised when two Key's of the same name are registered
   class DuplicateKeyError < StandardError
   end
=end
   
end