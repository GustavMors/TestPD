using System.Data.SqlClient;

namespace TrabalhoAPI.Repositories
{

    public class RepositoryBase
    {
        private static string ConnString = "Data Source=localhost\\SQLEXPRESS;Initial Catalog=trabalhofinalmais;Persist Security Info=True;User ID=trabalhofinalmais;Password=trabalhofinalmais;Integrated Security=false;MultipleActiveResultSets=true;";
        public static SqlConnection Connection = new SqlConnection(ConnString);

        public RepositoryBase()
        {

        }

        private static bool VerifyConnection()
        {
            if (Connection.State != System.Data.ConnectionState.Open)
            {
                try
                {
                    Connection.Open();
                    return true;
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
            return true;
        }

        public static SqlDataReader Select(string sql)
        {
            if (!VerifyConnection())
                throw new Exception("Erro ao verificar conexão com o banco");
            var command = new SqlCommand(sql, Connection);
            return command.ExecuteReader();

        }

        public static int Update(string sql)
        {
            if (!VerifyConnection())
                throw new Exception("Erro ao verificar conexão com o banco");
            SqlCommand command = new SqlCommand(sql, Connection);
            return command.ExecuteNonQuery();
        }

    }
}

