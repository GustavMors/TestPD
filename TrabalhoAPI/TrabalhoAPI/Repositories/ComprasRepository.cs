using TrabalhoAPI.Models;
using TrabalhoAPI.Models.ViewModels;

namespace TrabalhoAPI.Repositories
{
    public class ComprasRepository : RepositoryBase
    {
        public ComprasRepository() { }

        public static List<Compra> ListarCompras()
        {
            var compras = new List<Compra>();
            var respostaSql = Select("SELECT * FROM Compras;");

            while (respostaSql.Read())
            {

                Compra compra = new Compra()
                {
                    IdCompra = respostaSql.GetInt64(0),
                    IdFornecedor = respostaSql.GetInt64(1),
                    IdProduto = respostaSql.GetInt64(2),
                    Data = respostaSql.GetDateTime(3),
                    Quantidade = respostaSql.GetInt64(4)

                };
                compras.Add(compra);
            }
            respostaSql.Close();
            return compras;
        }

        public static int CadastrarCompra(ComprasViewModel novaCompra)
        {
            // CNPJ -> IdFornecedor,  CodBArras -> IdProduto, Quantidade==

            var RespostaSql = Select(@$"SELECT p.IdProduto, f.IdFornecedor FROM Produtos p, Fornecedores f 
                                        WHERE p.CodBarras = '{novaCompra.CodBarras}' AND f.CNPJ = '{novaCompra.CNPJ}';");
            if (RespostaSql.Read())
            {
                ComprasViewModel compra = new ComprasViewModel()
                {
                    IdProduto = RespostaSql.GetInt64(0),
                    IdFornecedor = RespostaSql.GetInt64(1),
                    Quantidade = novaCompra.Quantidade,
                    IdFuncionarioSol = novaCompra.IdFuncionarioSol,
                    IdFuncionarioAut = novaCompra.IdFuncionarioAut

                }; RespostaSql.Close();
                return Update(@$"INSERT INTO Compras (IdFornecedor, IdProduto, Quantidade, Data) 
                                    VALUES ({compra.IdFornecedor},{compra.IdProduto},{compra.Quantidade}, GETDATE());
                                 INSERT INTO MovimentacoesEstoque (IdEstoque, IdTipoMovimentacaoEstoque,
                                                                   IdFuncionarioSolicitador, IdFuncionarioAutenticador, IdProduto, Quantidade, DataHora)
                                 VALUES (5, 4, {compra.IdFuncionarioSol},{compra.IdFuncionarioAut},{compra.IdProduto},{compra.Quantidade}, GETDATE());
                return INSERT INTO MovimentacoesEstoque
                                        (IdEstoque,
                                        IdTipoMovimentacaoEstoque,
                                        IdFuncionarioSolicitador,
                                        IdFuncionarioAutenticador,
                                        IdProduto,
                                        Quantidade,
                                        DataHora)
                                        VALUES
                                        (5,
                                        4,
                                        {compra.IdFuncionarioSol},
                                        {compra.IdFuncionarioAut},
                                        {compra.IdProduto},
                                        {compra.Quantidade},
                                        '20/10');

");



            }
            else return -1;
            
            
            
           
        }
        
    }
}
