using TrabalhoAPI.Models;

namespace TrabalhoAPI.Repositories
{
    public class FornecedoresRepository : RepositoryBase
    {
        public FornecedoresRepository() { }


        public static List<Fornecedor> ListarFornecedores()
        {
            var fornecedores = new List<Fornecedor>();
            var respostaSql = Select("SELECT * FROM Fornecedores;");

            while (respostaSql.Read())
            {

                Fornecedor fornecedor = new Fornecedor()
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

        public static int CadastrarFornecedor(Fornecedor fornecedor)
        {
            return Update($"INSERT INTO Fornecedores (CNPJ, Nome) VALUES ('{fornecedor.CNPJ}', '{fornecedor.Nome}');");
        }

        public static Fornecedor ConsulatarFornecedoresCNPJ(string CNPJ)
        {
            var RespostaSql = Select($"Select * FROM Fornecedores WHERE CNPJ = '{CNPJ}';");
            if (RespostaSql.Read())
            {
                var fornecedor = new Fornecedor()
                {
                    IdFornecedor = RespostaSql.GetInt64(0),
                    CNPJ = RespostaSql.GetString(1),
                    Nome = RespostaSql.GetString(2)
                }; RespostaSql.Close();
                return fornecedor;
            }
            return new Fornecedor();
        }






    }
}
