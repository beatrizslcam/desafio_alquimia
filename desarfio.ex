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
   quantidade_emails = tamanho_lista_email(emails)
   valor_total_lista(lista_de_compras,0)
  |>atribuicao_compra(quantidade_emails,emails)

  end

  defp tamanho_lista_email(emails) do
    Enum.frequencies(emails)
    |>map_size()
  end

  defp valor_total_lista([], valor_para dividir), do: valor_para_dividir

  defp valor_total_lista(lista_de_compras,valor_para_dividir) do
    [item| itens_restantes] = lista_de_compras
    valor_para_dividir = valor_para_dividir + (elem(item,1)*elem(item,2))
    valor_total_lista(itens_restantes, valor_para_dividir)
  end

  defp atribuicao_compra(valor_total,quantidade_emails,emails) do
    divisao = div(valor_total,quantidade_emails)
    resto = rem(valor_total,quantidade_emails)
    case  divisao do
      0 ->
        rem(valor_total,quantidade_emails)

      _ && rem(valor_total,quantidade_emails) == 0 ->

      _->

    end

  end

end
##ToDO:
#Finalizar a parte de atribuição e testar
