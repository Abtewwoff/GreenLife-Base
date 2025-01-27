function _GreenLifeInventory:toggleInventory()
  if self.StateInventory then
    self:closeInventory()
  else
    self:openInventory()
  end
end