using TrabalhoAPI.Models;
using TrabalhoAPI.Models.ViewModels;

namespace TrabalhoAPI.Repositories
{
    public class ProdutosRepository : RepositoryBase
    {

        public static int NovoProduto(Produto produto)
        {
            return Update($@"INSERT INTO Produtos (CodBarras, Descricao) VALUES
                ('{produto.CodBarras}', '{produto.Descricao}') ");
        }

        public static int AlterarCodBarras(string codBarrasAtual, string codBarrasAlterar)
        {   
            return Update(
                $@"UPDATE Produtos SET 
                    CodBarras = '{codBarrasAlterar}'
                    
                    WHERE CodBarras = {codBarrasAtual}");

        }

        public static List<Produto> ListarProdutos()
        {
            var produtos = new List<Produto>();
            var respostaSql = Select("SELECT * FROM Produtos;");

            while (respostaSql.Read())
            {

                Produto produto = new Produto()
                {
                    IdProduto = respostaSql.GetInt64(0),
                    CodBarras = respostaSql.GetString(1),
                    Descricao = respostaSql.GetString(2)

                };
                produtos.Add(produto);
            }
            respostaSql.Close();
            return produtos;
        }

        public static Produto ConsulatarProdutoCodBarras(string CodBArras)
        {
            var RespostaSql = Select($"Select * FROM Produtos WHERE CodBarras = '{CodBArras}';");
                if (RespostaSql.Read())
                 {
                var produto = new Produto()
                {
                    IdProduto = RespostaSql.GetInt64(0),
                    CodBarras = RespostaSql.GetString(1),
                    Descricao = RespostaSql.GetString(2)
                }; RespostaSql.Close();
                return produto;
            }
            return new Produto();
        }

        //retorna uma lista de produtos que compoem o estoque
        public static List<ViewModelProdutosEmEstoque> ConsultarProdutosEmEstoque(long idEstoque)
        {
            var estoque = new List<ViewModelProdutosEmEstoque>();
            var respostaSql = Select($@"SELECT
                                       *,
                                       (
	                                    SELECT COALESCE(SUM(Quantidade), 0)
	                                    FROM MovimentacoesEstoque me
	                                    WHERE me.IdProduto = p.IdProduto AND me.IdEstoque = {idEstoque}
                                        ) AS Quantidade
                                        FROM Produtos p;"
             );

            while (respostaSql.Read())
            {
                ViewModelProdutosEmEstoque produto = new()
                {
                    IdProduto = respostaSql.GetInt64(0),
                    CodBarras = respostaSql.GetString(1),
                    Descricao = respostaSql.GetString(2),
                    Quantidade = respostaSql.GetInt64(3)

                };

                if (produto.Quantidade != 0)
                {
                    estoque.Add(produto);
                }

            }

            return estoque;
        }

    }
}
