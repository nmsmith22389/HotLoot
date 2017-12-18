function newT( t )
    local mt,_korder = {},{}
    local fsort = function( a,b ) return tostring(a) < tostring(b) end
    local isSorted = true
    -- set methods
    -- index gets only called if the value is not found in the original table
    -- overridden values can be accessed again by deleting the variable over t[key] = nil
    mt.__index = {
       -- traversal of hidden values
       hidden = function() return pairs( mt.__index ) end,
       -- traversal of table ordered: returning index, key
       ipairs = function( self )
          if not isSorted then
             table.sort( _korder,fsort )
             isSorted = true
          end
          return ipairs( _korder )
       end,
       -- traversal of table
       pairs = function( self ) return pairs( self ) end,
       -- traversal of table sorted: returning key,value
       spairs = function( self )
          if not isSorted then
             table.sort( _korder,fsort )
             isSorted = true
          end
          local i = 0
          local function iter( self )
             i = i + 1
             local k = _korder[i]
             if k then
                return k,self[k]
             end
          end
          return iter,self
       end,
       -- to be able to delete entries we must write a delete function
       del = function( self,key )
          -- check if key exists beforestarting the traversal
          if self[key] then
             self[key] = nil
             for i,k in ipairs( _korder ) do
                if k == key then
                   table.remove( _korder,i )
                   return
                end
             end
          end
       end,
    }
    -- set new index handling, is really on new index !!!
    -- setting an non exisitng key to nil will pass here
    mt.__newindex = function( self,k,v )
       if k ~= "del" and v then
          rawset( self,k,v )
          table.insert( _korder,k )
          isSorted = false
       end
    end
    return setmetatable( t or {},mt )
 end