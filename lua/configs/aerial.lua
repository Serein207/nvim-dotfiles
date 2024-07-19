function AerialKeybind(bufnr)
  require("mappings").mapAerial(bufnr)
end

require("aerial").setup {
  on_attach = AerialKeybind,
}
