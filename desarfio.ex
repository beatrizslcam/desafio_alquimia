defmodule Desafio do
  @moduledoc """
  Este é o módulo que deverá ser preenchido
  com a sua solução.

  É permitido criar quantas funções privadas for necessário,
  mas a única função pública deverá ser a função `split/2`
  que está definida como placeholder abaixo.
  """

  @spec split(
          lista_de_compras :: [
            {item :: String.t(), quantidade :: pos_integer(),
             preco_unitario_centavos :: pos_integer()}
          ],
          emails :: [String.t()]
        ) :: [%{String.t() => non_neg_integer()}]

  def split(lista_de_compras, emails) do
    lista_emails_real= lista_emails(emails)
    valor_total_lista(lista_de_compras,0)
    |>repartir_valor(lista_emails_real)
  end

  defp lista_emails(emails) do
    Enum.frequencies(emails)
    |> Map.keys()
  end

  defp valor_total_lista([], valor_compra), do: valor_compra

  defp valor_total_lista(lista_de_compras,valor_compra) do
    [item| itens_restantes] = lista_de_compras
    valor_compra = valor_compra + (elem(item,1)*elem(item,2))
    valor_total_lista(itens_restantes, valor_compra)
  end

  def repartir_valor(valor_total,emails) do
    divisao = div(valor_total,length(emails))
    resto = rem(valor_total,length(emails))
    emails
    |>Enum.with_index()
    |>Enum.map(fn {email, index} ->
       if index < resto do
          {email,divisao + 1}
       else
          {email,divisao}
       end
    end)
    |>Map.new()
  end

end


import ExUnit.Assertions

# Lista de emails com valores repetidos
emails = ~w(
  paulo@email.com
  valente@email.com
  teste@email.com
  valente@email.com
  paulo@email.com
  valente@email.com
)

# Primeiro, vamos validar os casos em que o valor total é menor ou igual ao número de emails
assert %{"paulo@email.com" => 1, "valente@email.com" => 0, "teste@email.com" => 0} ==
         Desafio.split([{"banana", 1, 1}, {"maçã", 0, 10}], emails)

assert %{"paulo@email.com" => 1, "valente@email.com" => 1, "teste@email.com" => 0} ==
         Desafio.split([{"banana", 2, 1}, {"maçã", 0, 10}], emails)
assert %{"paulo@email.com" => 1, "valente@email.com" => 1, "teste@email.com" => 1} ==
         Desafio.split([{"banana", 1, 1}, {"maçã", 1, 2}], emails)

# Caso em que há mais de um centavo de resto
assert %{"paulo@email.com" => 2, "valente@email.com" => 2, "teste@email.com" => 1} ==
         Desafio.split([{"banana", 1, 1}, {"maçã", 1, 2}, {"uva", 2, 1}], emails)

# Teste de erro de arredondamento

assert %{
         "1@email.com" => 1,
         "2@email.com" => 1,
         "3@email.com" => 1,
         "4@email.com" => 1,
         "5@email.com" => 1,
         "6@email.com" => 1,
         "7@email.com" => 1,
         "8@email.com" => 0,
         "9@email.com" => 0,
         "10@email.com" => 0,
         "11@email.com" => 0
       } == Desafio.split([{"banana", 7, 1}], Enum.map(1..11, &"#{&1}@email.com"))
