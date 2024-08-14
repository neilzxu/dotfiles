return {
  {
    'neilzxu/dingllm.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local system_prompt =
        'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks'
      local helpful_prompt = 'You are a helpful assistant. What I have sent are my notes so far. You are very curt, yet helpful.'
      local dingllm = require 'dingllm'

      local function azure_openai_replace()
        dingllm.invoke_llm_and_stream_into_editor({
          url_name = 'AZURE_OPENAI_API_BACKEND',
          api_key_name = 'AZURE_OPENAI_API_KEY',
          system_prompt = system_prompt,
          replace = true,
        }, dingllm.make_azure_openai_spec_curl_args, dingllm.handle_openai_spec_data)
      end

      local function azure_openai_help()
        dingllm.invoke_llm_and_stream_into_editor({
          url_name = 'AZURE_OPENAI_API_BACKEND',
          api_key_name = 'AZURE_OPENAI_API_KEY',
          system_prompt = helpful_prompt,
          replace = false,
        }, dingllm.make_azure_openai_spec_curl_args, dingllm.handle_openai_spec_data)
      end
      -- Keymaps
      vim.keymap.set({ 'n', 'v' }, ',l', azure_openai_replace, { desc = 'llm azure_openai' })
      vim.keymap.set({ 'n', 'v' }, ',L', azure_openai_help, { desc = 'llm azure_openai_help' })
    end,
  },

}
