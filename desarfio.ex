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
    {lista_emails_real, quantidade_emails} = lista_emails(emails)
    valor_total_lista(lista_de_compras,0)
    |>repartir_valor(quantidade_emails,lista_emails_real)

  end

  defp lista_emails(emails) do
    lista_emails_real  = Enum.frequencies(emails)|> Map.keys()
    {lista_emails_real,length(lista_emails_real)}
  end

  defp valor_total_lista([], valor_compra), do: valor_compra

  defp valor_total_lista(lista_de_compras,valor_compra) do
    [item| itens_restantes] = lista_de_compras
    valor_compra = valor_compra + (elem(item,1)*elem(item,2))
    valor_total_lista(itens_restantes, valor_compra)
  end

  def repartir_valor(valor_total,quantidade_emails,emails) do
    divisao = div(valor_total,quantidade_emails)
    resto = rem(valor_total,quantidade_emails)
    acc = 0
    resultado = %{}
    case  [divisao,resto] do
      [0, resto]->
        if (acc != 0) do
          inserir_no_map(emails,1,resto)

          else
            inserir_no_map(emails,0,_resto)
        end
    #  [divisao,0]->
     #     inserir_no_map(emails,divisao)
      [_divisao,_resto]->
        :ok
      end
    end

    def inserir_no_map(emails,valor,_resto, _quantidade_emails) do
      acc = 0
      Enum.map(emails,
      fn x ->
        if(acc < quantidade_emails ), do: Map.put_new(%{},x,valor)
        else

      end)
    end
end
#emails = ~w(
#  paulo@email.com
#  valente@email.com
#  teste@email.com
#  valente@email.com
#  paulo@email.com
#  valente@email.com
#)

#Desafio.split([1,2,3], emails)
