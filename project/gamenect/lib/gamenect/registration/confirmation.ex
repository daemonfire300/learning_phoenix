defmodule Gamenect.Registration.Confirmation do
    def generate_token() do
        length = Application.get_env(:gamenect, :confirmation_token_length, 32)
        :crypto.strong_rand_bytes(length) |> Base.url_encode64
    end
end