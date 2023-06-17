using TrabalhoAPI.Models;

namespace TrabalhoAPI.Repositories
{
    public class FuncionariosRepository : RepositoryBase
    {
        public FuncionariosRepository() { }


        public static Funcionario LogarFuncionario(string email, string senha)
        {
            var RespostaSql = Select($"SELECT * FROM Funcionarios WHERE Email = '{email}' AND Senha = '{senha}';");
            if (RespostaSql.Read())
            {

                var funcionario = new Funcionario()
                {
                    IdFuncionario = RespostaSql.GetInt64(0),
                    Nome = RespostaSql.GetString(1),
                    Email = RespostaSql.GetString(3),
                    Setor = RespostaSql.GetString(2),
                    Senha = RespostaSql.GetString(3)
                }; RespostaSql.Close();
                return funcionario;
            }
            return new Funcionario();
        }

        public static Funcionario ConsultarLogin(string email, string senha)
        {
            var RespostaSql = Select($"Select * FROM Funcionarios WHERE Email = '{email}' AND Senha = '{senha}';");
            if (RespostaSql.Read())
            {
                var funcionario = new Funcionario()
                {
                    IdFuncionario = RespostaSql.GetInt64(0),
                    Nome = RespostaSql.GetString(1),
                    Email = RespostaSql.GetString(3),
                    Setor = RespostaSql.GetString(2),
                    Senha = RespostaSql.GetString(3)
                }; RespostaSql.Close();
                return funcionario;
            }
            return new Funcionario();
        }
        public static List<Funcionario> ListarFuncionarios()
        {
            var funcionarios = new List<Funcionario>();
            var respostaSql = Select("SELECT * FROM Funcionarios;");

            while (respostaSql.Read())
            {

                Funcionario funcionario = new Funcionario()
                {
                    IdFuncionario = respostaSql.GetInt64(0),
                    Nome = respostaSql.GetString(1),
                    Setor = respostaSql.GetString(2),
                    Email = respostaSql.GetString(3),
                    Senha = ""

                };
                funcionarios.Add(funcionario);
            }
            respostaSql.Close();
            return funcionarios;
        }

        public static int CadastrarFuncionario(Funcionario funcionario) 
        { 
            return Update($@"INSERT INTO Funcionarios(Nome, Setor, Email, Senha) 
            VALUES('{funcionario.Nome}', '{funcionario.Setor}', '{funcionario.Email}', '{funcionario.Senha}');");
        }

        public static int ExcluirFuncionario(string nome)
        {
            return Update($"DELETE FROM Funcionarios WHERE Nome = '{nome}' ;");
        }

        public static int AlterarSenha(string email, string novasenha)
        {
            return Update($"UPDATE Funcionarios SET Senha = '{novasenha}' WHERE Email = '{email}'");
        }

        public static int Alterarfuncionario(string novoEmail, string email, string setor, string senha, string nome)
        {
            return Update($"UPDATE Funcionarios SET Email = '{novoEmail}', Setor = '{setor}', Senha = '{senha}', Nome = '{nome}' WHERE Email = '{email}'");
        }

    }
}
