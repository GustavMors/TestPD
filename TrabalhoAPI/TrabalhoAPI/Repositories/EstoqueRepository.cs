using TrabalhoAPI.Models;
using TrabalhoAPI.Repositories;
namespace TrabalhoAPI.Repositories
{
    public class EstoqueRepository : RepositoryBase
    {
        public EstoqueRepository () { }




        //registra uma movimentação de produtos entre estoques
        public static int RegistrarMovimentacaoEntreEstoques(MovimentacaoEstoque m)
        {
            var resultados = 0;

            try
            {
                //inserindo no estoque Recebedor
                resultados += Update($@"INSERT INTO MovimentacoesEstoque
                                        (IdEstoque,
                                        IdTipoMovimentacaoEstoque,
                                        IdFuncionarioSolicitador,
                                        IdFuncionarioAutenticador,
                                        IdProduto,
                                        Quantidade)
                                        VALUES
                                        ({m.IdEstoqueRecebedor},
                                        {m.IdTipoMovimentacaoEstoque},
                                        {m.IdFuncionarioSolicitador},
                                        {m.IdFuncionarioAutenticador},
                                        {m.IdProduto},
                                        {m.Quantidade})
                                        
             ");

                //retirando quantidade produto do estoque de saída
                resultados += Update($@"INSERT INTO MovimentacoesEstoque
                                        (IdEstoque,
                                        IdTipoMovimentacaoEstoque,
                                        IdFuncionarioSolicitador,
                                        IdFuncionarioAutenticador,
                                        IdProduto,
                                        Quantidade)
                                        VALUES
                                        ({m.IdEstoqueSaida},
                                        {m.IdTipoMovimentacaoEstoque},
                                        {m.IdFuncionarioSolicitador},
                                        {m.IdFuncionarioAutenticador},
                                        {m.IdProduto},
                                        -{m.Quantidade})
                                        
             ");
                return resultados;
            }
            catch {
                resultados = 0;
            }
            return resultados;
            
        }



        public static int RegistrarMovimentacaoEntradaArmazem(MovimentacaoEstoque m)
        {
            
            return Update($@"INSERT INTO MovimentacoesEstoque
                                        (IdEstoque,
                                        IdTipoMovimentacaoEstoque,
                                        IdFuncionarioSolicitador,
                                        IdFuncionarioAutenticador,
                                        IdProduto,
                                        Quantidade)
                                        VALUES
                                        ({m.IdEstoqueRecebedor},
                                        {m.IdTipoMovimentacaoEstoque},
                                        {m.IdFuncionarioSolicitador},
                                        {m.IdFuncionarioAutenticador},
                                        {m.IdProduto},
                                        {m.Quantidade})
                                        
             ");

        }



        //retorna uma lista de fornecedores cadastrados
        public static List<Fornecedor> ConsultarFornecedores()
        {
            var fornecedores = new List<Fornecedor>();
            var respostaSql = Select("SELECT * FROM Fornecedores");
            while (respostaSql.Read())
            {
                Fornecedor fornecedor = new()
                {
                    IdFornecedor = respostaSql.GetInt64(0),
                    CNPJ = respostaSql.GetString(1),
                    Nome = respostaSql.GetString(2)
                };

                fornecedores.Add(fornecedor);
            }
            respostaSql.Close();

            return fornecedores;
        }

        public static List<TiposMovimentacoesEstoque> ConsultarTiposMovimentacaoEstoque()
        {
            var movimentacoes = new List<TiposMovimentacoesEstoque>();
            var respostaSql = Select($"SELECT * FROM TiposMovimentacaoEstoque");

            while (respostaSql.Read())
            {
                var movimentacao = new TiposMovimentacoesEstoque()
                {
                    IdTipoMovimentacaoEstoque = respostaSql.GetInt64(0),
                    Descricao = respostaSql.GetString(1)
                };

                movimentacoes.Add(movimentacao);
            }
            respostaSql.Close();
            return movimentacoes;
        }

        //retorna uma lista dos estoques existentes no banco 


        public static List<Estoque> ConsultarEstoquesCadastrados()
        {
            var estoquesCadastrados = new List<Estoque>();
            var respostaSql = Select($"SELECT * FROM Estoques");

            while (respostaSql.Read())
            {
                var estoque = new Estoque()
                {
                    IdEstoque = respostaSql.GetInt64(0),
                    IdTipoEstoque = respostaSql.GetInt64(1),
                    Descricao = respostaSql.GetString(2)
                };

                estoquesCadastrados.Add(estoque);
            }
            respostaSql.Close();

            return estoquesCadastrados;
        }
    }

}
